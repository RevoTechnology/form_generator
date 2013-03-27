namespace "Neatform.Scenarios", (exports) ->

  bind_scenario = (element) ->
    if dropdown_element(element)
      bind_event element, "change", run_scenario
    else
      bind_event element, "click", run_scenario

  get_scenario_containers = (object_ids) ->
    _stack = []
    for id in object_ids
      _stack.push Document.select(".field_#{id}").first()
    # for name in object_ids
    #   for element in Document.find_all_by_name name
    #     if element.data "group"
    #       _stack.push Document.select(".#{element.data "group"}").first() if Document.select(".#{element.data "group"}").length
    #     else
    #       if "text" == element.instance.type
    #         _stack.push element.parent(-4)

    #       if "number" == element.instance.type
    #         _stack.push element.parent(-4)

    #       if "date" == element.instance.type
    #         _stack.push element.parent(-4)

    #       if "textarea" == element.tag
    #         _stack.push element.parent(-1)

          # console.log element
          # if "text" == element.insta "type"
          # if "radio" == element.attribute "type"
          #   # _stack.push element.parent(-4)
          # else if "checkbox" == element.attribute "type"
          #   # _stack.push element.parent(-1)
          # else
          #   _stack.push element.parent(-1)
    _stack

  run_scenario = (e) ->
    target = target_of_event e
    scenario = window.scenarios[target.attribute "name"]
    current_state = "#{get_value target.attribute "name"}"
    perform_scenario scenario, current_state

    # if Neatform.StepAnimation && !window.preview_mode
    #   step = Document.select("fieldset[data-step='#{current_step}']").first()
    #   step.css "height", "auto"
    #   step.css "overflow", "initial"
    #   step.data "height", 10 + step.height()
    #   step.css "height", "#{10 + step.height()}px"

  exports.run = run_scenario

  perform_scenario = (scenario, current_state) ->
    current_state = String(current_state)
    for state, fields of scenario

      for _field in fields
        if state != current_state
          if -1 == Neatform.Data.fields_to_ignore.indexOf _field
            Neatform.Data.fields_to_ignore.push _field

          if sub_scenario = window.scenarios[_field]
            for sub_scenario_state, sub_scenario_fields of sub_scenario
              for sub_scenario_field in sub_scenario_fields
                if -1 == Neatform.Data.fields_to_ignore.indexOf sub_scenario_field
                  Neatform.Data.fields_to_ignore.push sub_scenario_field

        else
          if -1 < Neatform.Data.fields_to_ignore.indexOf _field
            Neatform.Data.fields_to_ignore.destroy_at Neatform.Data.fields_to_ignore.indexOf(_field)

          if sub_scenario = window.scenarios[_field]
            for sub_scenario_state, sub_scenario_fields of sub_scenario
              for sub_scenario_field in sub_scenario_fields
                if -1 < Neatform.Data.fields_to_ignore.indexOf sub_scenario_field
                  Neatform.Data.fields_to_ignore.destroy_at Neatform.Data.fields_to_ignore.indexOf(sub_scenario_field)

        # handling sub scenarios
        if sub_scenario = window.scenarios[_field]
          if state == current_state
            for field in Document.find_all_by_name _field
              fire_event field, "click"
          else
            for sub_scenario_state, sub_scenario_fields of sub_scenario
              for container in get_scenario_containers sub_scenario_fields
                container.hide()

      for container in get_scenario_containers fields
        if state == current_state
          # console.log "yahoo"
          container.show() if container
        else
          container.hide() if container

    Neatform.Validation.update_availability_of_next_step()

    if Neatform.Data.number_of_steps > 1
      unless Neatform.Data.skin_is_accordion
        if Neatform.Validation.validate_step Neatform.Data.current_step
          Document.select("ul.steps li[data-step='#{Neatform.Data.current_step}']").first().remove_class "error"
        else
          Document.select("ul.steps li[data-step='#{Neatform.Data.current_step}']").first().add_class "error"

  exports.initialize = ->
    for object_name, dependent_fields of window.scenarios
      if Document.find_all_by_name(object_name).length
        for field in Document.find_all_by_name object_name
          bind_scenario field
          # if isIE()
          #   # fire_event field, "click"
          # else
            # console.log field.attribute("name"), window.scenarios[field.attribute("name")]
          perform_scenario window.scenarios[field.attribute("name")], get_value(field.attribute "name")

domReady ->
  Neatform.Scenarios.initialize()
