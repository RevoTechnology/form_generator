namespace "Neatform.Logging", (exports) ->
  timers =
    logging: {}

  enable_fields_logging = ->
    for field_name in window.fields
      _fields = Document.find_all_by_name field_name
      bind_change field for field in _fields

      # groups handling (VERY DUMB, REFACTOR)
      _group = Document.select("li.#{field_name}").first()
      bind_change field for field in _group.children("input, textarea, select") if _group

  bind_change = (element) ->
    if dropdown_element element
      bind_event element, "change", send_click_input_log
    else
      bind_event element, "click", send_click_input_log if clickable_element element

    bind_event element, "keyup", send_text_input_log if writable_element element

  send_click_input_log = (e) ->
    try
      send_field_log e
    catch error
      null

  send_text_input_log = (e) ->
    if Neatform.Validation.key_can_trigger_validation e
      target = target_of_event e
      clearTimeout timers.logging[target.attribute "name"] if timers.logging[target.attribute "name"]
      timers.logging[target.attribute "name"] = setTimeout( ->
        send_field_log e
      , 400)

  send_field_log = (e) ->
    target = target_of_event e
    if target
      name = target.attribute "name"
      value = get_value name
      data = JSON.stringify { "client_key": Neatform.Data.client_id, "order": { "builder_id": window.order_info.order_id }, "version": { "builder_id": window.order_info.version_id }, "field": { "builder_id": name}, "value": value }

      try
        XHR.post "#{window.organization_url}/api/field.json",
          { data: data },
          field_logging_callback
      catch error
        2

  field_logging_callback = (data) ->
    unless data.error
      2
      # console.log "WOOHOO"

  exports.send_form_log = (callback) ->
    form_data = {}
    for step_number in [1..Neatform.Data.number_of_steps]
      for field in Document.select("fieldset[data-step='#{step_number}'] [name]")
        unless field.attribute("name") in Neatform.Data.fields_to_ignore
          value = get_value(field.attribute("name"))
          if typeof(value) == "string"
            value = value.clear_spaces()
          form_data[field.attribute("data-parameter") ] = value
          if field.attribute("data-suggest")
            form_data[field.attribute("data-parameter") + "_uid" ] = field.attribute("data-parent")

    data =
      "meta_data":
        "client_key": Neatform.Data.client_id
        "order": window.order_info.order_id
        "version": window.order_info.version_id
      "form_data": form_data

    XHR.post "#{window.organization_url}/api/step.json",
      { data: JSON.stringify data },
      (data) ->
        # callback.call callback, data
        # console.log("We`r back")
        #console.log(data)


  exports.initialize = ->
    2
    # enable_fields_logging() unless window.preview_mode || window.organization_url == ""

domReady ->
  Neatform.Logging.initialize()
