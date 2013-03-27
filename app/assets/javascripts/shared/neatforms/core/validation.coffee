namespace "Neatform.Validation", (exports) ->

  # function format for hooks:
  # hook_function = (validation_status, field_name, error_message = null, short_error_message = null) ->
  #   ...
  #   do something useful
  #   ...
  #
  # and then you like
  # Neatform.Validation.after_validation function_name

  post_validation_hooks = []

  timers =
    validation: {}

  bind_validation = (element) ->
    if "date" == element.instance.getAttribute "type"
      bind_event element, "input", (e) -> validate_field element.id

    if dropdown_element
      bind_event element, "change", (e) -> validate_field element.attribute "name"

    else if clickable_element element
      bind_event element, "click", (e) -> validate_field element.attribute "name"

    if writable_element element
      bean.one element.instance, "blur", (e) ->
        element.data "changed", true
        validate_field element.attribute "name" if element.data "changed"

      bind_event element, "keyup", (e) ->
        if key_can_trigger_validation(e) and element.data("changed")
          # console.log "starting timer..."
          clearTimeout timers.validation[element.attribute "name"] if timers.validation[element.attribute "name"]
          timers.validation[element.attribute "name"] = setTimeout ->
            validation_wrapper element.attribute("name")
          ,
          100

  validation_wrapper = (name) ->
    validate_field name

  determine_initial_validation_status_of_field = (field_description) ->
    status = false # default invalid state for all fields

    if window.validations[field_description.parameter] and window.validations[field_description.parameter].length # if the field doesnt have any validations, it's valid by default
      status = true

    if field_description.tag == 'checkbox' # finding pre-defined checkbox values
      status = if "true" == get_value(field_description.parameter) then true else false

    return status

  flat_field_structure = []

  push_to_validation_table = (step_index, field_description) ->
    unless field_description.tag in ["announce", "separator"]
      flat_field_structure.push field_description.parameter # if -1 == flat_field_structure.indexOf(field_description.parameter)
      Neatform.Data.validation_status[step_index][field_description.parameter] = determine_initial_validation_status_of_field field_description

  generate_validation_tables = ->
    for step in window.fields
      Neatform.Data.validation_status[step.index + 1] = {}

      for field in step.fields
        if field.type in ['item', "text", 'date', "number", "tel"]
          push_to_validation_table step.index + 1, field

        if field.type == 'group' || field.scenario
          for f in field.items
            push_to_validation_table step.index + 1, f

  validate_field = (field_name) ->
    if Neatform.CustomValidations && Neatform.CustomValidations.got_something(field_name)
      data = Neatform.CustomValidations.validate field_name
      result = data.status
      message = data.message
      short_message = data.short_message
    else
      value = get_value field_name
      # console.log field_name, value

      validations = if "undefined" != typeof window.validations[field_name] then window.validations[field_name].validations else null
      result = true

      if Document.find_all_by_name(field_name).length > 1 && value == null
        # console.log "Radio"
        result = false
        message = "Пожалуйста, выберите один из вариантов"

      if dropdown_element(Document.find_by_name field_name) and value == "-1"
        result = false
        message = "Пожалуйста, выберите значение"

      if validations and validations.length
        message = null
        short_message = null
        for validation in validations
          # console.log validation
          # console.log validation.regexp.substr(1, validation.regexp.length-2).replace("\\A", "^").replace("\\z", "$")
          unless RegExp(validation.regexp.substr(1, validation.regexp.length-2).replace("\\A", "^").replace("\\z", "$")).test value
            result = false
            message = validation.message
            short_message = validation.short_message
            break

    # console.log "#{field_name} #{result} / #{Document.find('#'+field_name).data("changed")}"
    # console.log field_name
    unless Neatform.Data.step_validation_ignor
      field_step =   Neatform.Data.current_step
    else
      field_step = Document.select("[name=#{field_name}]").first().data("step")

    Neatform.Data.validation_status[field_step] = {} unless Neatform.Data.validation_status[field_step]
    if result
      Neatform.Data.validation_status[field_step][field_name] = true
      indicate_success field_name
      hook.call(hook, true, field_name) for hook in post_validation_hooks
    else
      Neatform.Data.validation_status[field_step][field_name] = false
      indicate_error field_name, message, short_message
      hook.call(hook, false, field_name, message, short_message) for hook in post_validation_hooks

    update_availability_of_next_step()
    unless Neatform.Data.step_validation_ignor
      if Neatform.Data.number_of_steps > 1
        unless Neatform.Data.skin_is_accordion
          if validate_step field_step
            Document.select("ul.steps li[data-step='#{Neatform.Data.current_step}']").first().remove_class "error"
          else
            Document.select("ul.steps li[data-step='#{Neatform.Data.current_step}']").first().add_class "error"

    return status

  exports.validate_field = validate_field
  

  window.vf = validate_field

  indicate_success = (field_name) ->
    if Document.find_all_by_name(field_name).length > 1
      # radio shit
      hint = Document.find "##{field_name}-hint"
      hint.clear()
      hint.attribute "class", ""
      hint.add_class "class", "message"
      hint.add_class "class", "success"
    else
      field = Document.find "##{field_name}"
      field.remove_class("invalid")
      field.add_class("valid")

      unless field.data "group"
        hint = Document.find "##{field_name}-hint"
        hint.clear()
        hint.attribute "class", ""
        hint.add_class "class", "message"
        hint.add_class "class", "success"
      else
        hint = Document.find "##{field.data "group"}-hint"
        hint.child("p##{field.id}-group-hint").destroy() if hint && hint.child("p##{field.id}-group-hint")

      # circle = Document.find "##{field_name}_hover_error"
      # if circle
      #   circle.css "display", "none"

      # tooltip = Document.find "##{field_name}_hover_tooltip"
      # if tooltip
      #   tooltip.css "display", "inline-block"

      # field = Document.find "##{field_name}"
      # if field && field.data "group"
      #   circle = Document.find "##{field.data "group"}_hover_error"
      #   circle.css "display", "none"
  exports.indicate_success = indicate_success

  extract_label = (field_name) ->
    label = ""
    field = Document.select("[name=#{field_name}]").first()
    if field
      if field.data "group"

        group_name = Document.find(".#{field.data("group")} > strong").inner_html()
        if "radio" == field.instance.getAttribute("type")
          label = group_name
        else
          if field.tag == "select"
            label = group_name.concat(" / ", field.data("label"))
          else
            label = group_name.concat(" / ", field.data("placeholder"))

      else if field.tag == "select"
        label = Document.select("[for='#{field.id}']").first().inner_html()

      else if field.instance.type == 'checkbox'
        label = field.parent(-2).child("label").instance.innerHTML.replace(/<.*>/, '')


      else
        label = Document.select("[for='#{field.id}']").first().inner_html()

    label = label.replace('<span class="req">*</span>', '').replace('<SPAN class="req">*</SPAN>', '')
    label

  exports.extract_label = extract_label

  indicate_error = (field_name, long_message, short_message) ->
    message = short_message || long_message
    # if typeof(_gaq) != 'undefined' && Neatform.Analytics.track_errors
    #   _gaq.push(['_trackEvent', "Errors", "Field Error", extract_label(field_name)])

    field = Document.find "##{field_name}"
    if field
      field.remove_class("valid")
      field.add_class("invalid")

      if field.data "group"
        # console.log "WHAT"
        label = Document.select(".group.#{field.data("group")}_group > strong").first()
        #message = field.data("label") + ": " + message
    # console.log field_name

    # FUCKING RED CIRCLES!!!
    # circle = Document.find "##{field_name}_hover_error"
    # if circle
    #   circle.data "message", long_message
    #   circle.css "display", "inline-block"

    # tooltip = Document.find "##{field_name}_hover_tooltip"
    # if tooltip
    #   tooltip.css "display", "none"

    # field = Document.find "##{field_name}"
    # if field && field.data "group"
    #   circle = Document.find "##{field.data "group"}_hover_error"
    #   if circle
    #     circle.data "message", ((if field.attribute("placeholder") then (field.attribute("placeholder") + ": ") else "") + long_message)
    #     circle.css "display", "inline-block"


    if Document.find_all_by_name(field_name).length > 1
      # radio shit
      hint = Document.find "##{field_name}-hint"
      hint.inner_html "<span>#{message}</span>"
      hint.attribute("class", "message error")
    else
      if field && field.data "group"
        hint = Document.find "##{field.data "group"}-hint"
        # console.log hint.children("p##{field.id}-group-hint")
        unless hint.child("p##{field.id}-group-hint")
          p = new DOMElement "p"
          p.attribute "id", "#{field.id}-group-hint"
          p.inner_html (if field.data("placeholder") then (field.data("placeholder") + ": ") else "") + message
          hint.append p
        else
          hint.child("p##{field.id}-group-hint").inner_html (if field.data("placeholder") then (field.data("placeholder") + ": ") else "") + message

        hint.attribute("class", "message error block clear")
      else
        # if hint
        hint = Document.find "##{field_name}-hint"
        hint.inner_html "<span>#{message}</span>"
        if field.tag == 'textarea'
          hint.attribute("class", "message error block clear")
        else
          hint.attribute("class", "message error")

  exports.indicate_error = indicate_error

  validate_step = (step_index) ->
    if Neatform.Data.validation_status[step_index]
      statuses = Neatform.Data.validation_status[step_index]
      result = true
      for field, status of statuses
        unless field in Neatform.Data.fields_to_ignore
          # trace field unless status
          result = false unless status
      return result


  validate_form = ->
    if Neatform.Data.validation_status
      result = true
      for i in [ 1..Neatform.Data.number_of_steps ]
        result = false unless validate_step(i)
      return result
  exports.validate_form = validate_form


  highlight_errors_in_form = ->
    for i in [ 1..Neatform.Data.number_of_steps ]
      highlight_errors_in_step(i)

  exports.highlight_errors_in_form = highlight_errors_in_form

  window.vstep = validate_step

  exports.validate_step = validate_step

  update_availability_of_next_step = ->
    # status = true
    # for field_name in field_names_in_current_step()
    #   if validation_status[current_step][field_name]
    #     status = false unless validation_status[current_step][field_name]
    if validate_step Neatform.Data.current_step
      unless Neatform.Data.current_step == Neatform.Data.number_of_steps
        unless Neatform.Data.skin_is_accordion
          li = Document.select("ul.steps li[data-step='#{Neatform.Data.current_step+1}']").first()
          # li.add_class("enabled") unless li.has_class "enabled"
          Document.select("ul.steps li[data-step='#{Neatform.Data.current_step}']").first().remove_class "error"
          clear_event li, "click"
          bind_event li, "click", (e) ->
            target = target_of_event e
            switch_step parseInt target.data "step"

        Neatform.Data.allowed_steps.push(Neatform.Data.current_step+1) if -1 == Neatform.Data.allowed_steps.indexOf(Neatform.Data.current_step+1)
    else
      idx = Neatform.Data.allowed_steps.indexOf(Neatform.Data.current_step+1)
      if -1 < idx
        Neatform.Data.allowed_steps.destroy_at idx

  exports.update_availability_of_next_step = update_availability_of_next_step

  key_can_trigger_validation = (e) ->
    e = e || window.event
    key = e.which || e.keyCode

    unless e.metaKey || e.ctrlKey || e.altKey
      if (key in [9..40] or key in [91..93] or key in [112..145]) and key != 8 then false else true
    else
      false

  exports.key_can_trigger_validation = key_can_trigger_validation

  highlight_errors_in_current_step = ->
    Neatform.Data.validation_status[Neatform.Data.current_step] = {} unless Neatform.Data.validation_status[Neatform.Data.current_step]
    for field_name in Neatform.Data.get_field_names_in_current_step()
      validate_field(field_name) unless Neatform.Data.validation_status[Neatform.Data.current_step][field_name]

  highlight_errors_in_step = (index) ->
    Neatform.Data.validation_status[index] = {} unless Neatform.Data.validation_status[index]

    unless Neatform.Data.step_validation_ignor
      for field_name in Neatform.Data.get_field_names_in_step(index)
        validate_field(field_name) unless Neatform.Data.validation_status[index][field_name]
    else
      for field_name in Neatform.Data.get_any_field_names_in_step(index)
        validate_field(field_name) unless Neatform.Data.validation_status[index][field_name]

  safe_highlight_errors_in_step = (index) ->
    Neatform.Data.validation_status[index] = {} unless Neatform.Data.validation_status[index]
    for field_name in Neatform.Data.get_field_names_in_step(index)
      validate_field(field_name) unless Neatform.Data.validation_status[index][field_name] || field_name in Neatform.Data.fields_to_ignore

  exports.highlight_errors_in_current_step = highlight_errors_in_current_step
  exports.highlight_errors_in_step = highlight_errors_in_step
  exports.safe_highlight_errors_in_step = safe_highlight_errors_in_step

  field_is_subject_to_validation = (field) ->
    !! ( ( (field.visible() || (field.tag == "input" && field.instance.type == "checkbox")) && validations[field.attribute "name"] ) || (field.instance.type == "radio") || (field.visible() && field.tag == "select") )

  exports.field_is_subject_to_validation = field_is_subject_to_validation

  exports.after_validation = (func) ->
    post_validation_hooks.push func

  exports.initialize = ->
    generate_validation_tables()

    for field_name in flat_field_structure
      _fields = Document.find_all_by_name field_name
      bind_validation field for field in _fields

      # groups handling (VERY DUMB, REFACTOR)
      _group = Document.select("li.#{field_name}").first()
      bind_validation field for field in _group.children("input, textarea, select") if _group

  exports.ffs = -> flat_field_structure

domReady ->
  Neatform.Validation.initialize()
