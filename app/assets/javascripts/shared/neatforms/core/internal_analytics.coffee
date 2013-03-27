namespace "Neatform.InternalAnalytics", (exports) ->
  SERVER =
    host: 'some_host'
    protocol: 'http'
    port: '8000'

  FORM_ID = 'bm_form'

  user_id = null

  ping = (type, description = null, block = null, element = null, callback = null) ->
    # console.log "Ping:"
    domain = "#{SERVER.protocol}://#{SERVER.host}:#{SERVER.port}"
    path = "/#{FORM_ID}"
    path = path + "/block/#{block}" if block
    path = path + "/element/#{element}" if element
    path = path + "/type/#{type}"
    # console.log "-> #{encodeURI(domain + path)}"

    data_package =
      data: {}
    data_package.data.user_id = user_id if user_id
    data_package.data.description = description if description
    # console.log "-> data:", JSON.stringify(data_package)

    ping_callback = (data) ->
      # console.log "<- ping callback"
      # console.log "<- echo:", data
      if data
        if data.new_user
          user_id = data.user_id

      if callback
        callback.call callback, data

    XHR.post encodeURI(domain + path),
      { data: JSON.stringify(data_package) },
      ping_callback

  # ------------------------------

  probe = ->
    _callback = (data) ->
      if data.error == false
        send_user_data()
        enable_mouse_movement_tracking()

    ping "first form hit", null, null, null, _callback

  send_user_data = ->
    ping "screen size", "#{window.screen.availWidth}x#{window.screen.availHeight}", "user_info"
    ping "browser window size", "#{document.width}x#{document.height}", "user_info"

  # ------------------------------

  enable_step_switch_tracking = ->
    Neatform.after_step_switch ->
      ping "switch to step", null, "step:#{Neatform.Data.current_step}"

  enable_field_time_tracking = ->
    fields = Neatform.Validation.ffs()
    for field_name in fields
      field = Document.find_by_name field_name

      if writable_element(field)
        bind_event field, "focus", (e) ->
          field = target_of_event e
          ping "focus", null, "step:#{Neatform.Data.current_step}", "field:#{field.id}"

        bind_event field, "blur", (e) ->
          field = target_of_event e
          ping "blur", null, "step:#{Neatform.Data.current_step}", "field:#{field.id}"

  enable_field_errors_tracking = ->
    Neatform.Validation.after_validation (validation_status, field_name, error_message = null, short_error_message = null) ->
      if validation_status == false
        ping "error", "Error text: #{error_message}", "step:#{Neatform.Data.current_step}", "field:#{field_name}"

  enable_mouse_movement_tracking = ->
    bean.one document, "mousemove", ->
      ping "mouse movement detected"


  # ------------------------------

  exports.initialize = ->
    probe()
    enable_step_switch_tracking()
    enable_field_time_tracking()
    enable_field_errors_tracking()

domReady ->
  Neatform.InternalAnalytics.initialize()
