namespace "Neatform.Limits", (exports) ->

  get_ch = (keyCode) ->
    ch = ''
    switch keyCode
      when 8 then ch = 'bksp'
      when 46 # // handle del and . both being 46
        ch = if evt == 'keydown' then 'del' else '.'
      when 16 then ch = 'shift'
      when 0, 9, 13 then ch = 'etc'
      when 37, 38, 39, 40
        ch = if !code.shiftKey && code.charCode != 39 && code.charCode != undefined then 'etc' else String.fromCharCode keyCode
    # default to thinking it's a character or digit
      else ch = String.fromCharCode keyCode
    ch

  # ----------
  # Positioning cursor in input
  set_text_cursor = (element, position) ->
    try
      if element.instance.selectionStart >= 0
        #console.log "something"
        element.instance.focus()
        element.instance.setSelectionRange position, position
      else if element.instance.createTextRange # IE
        range = element.instance.createTextRange()
        range.move 'character', position
        range.select()
    catch e
      # console.log e
      return false

  clear_any_text_selection = ->
    if window.getSelection
      if window.getSelection().empty
        window.getSelection().empty()
      else if window.getSelection().removeAllRanges
        window.getSelection().removeAllRanges()
    else if document.selection
      document.selection.empty()
    # sel = if window.getSelection then window.getSelection() else document.selection
    # if sel
    #   if sel.removeAllRanges
    #     sel.removeAllRanges()
    #   else if sel.empty
    #     sel.empty()

  position_cursor_in_template = (e) ->
    key = e.charCode || e.keyCode
    if key == 9
      e.preventDefault()
      e.stopPropagation()
      clear_any_text_selection()
      target = target_of_event e
      template = target.data "template"
      #console.log template
      position = template.indexOf "_"
      set_text_cursor target, position

  # now, what the fuck
  validate_foreign_length = (event) ->
    target = target_of_event(event)
    keyCode = event.which
    keyCode = event.keyCode if keyCode == null

    ch = get_ch(keyCode)

    parameter = if target.data("parameter") == 'foreign_surname' then 'foreign_first_name' else 'foreign_surname'
    other = Document.select("input[data-parameter='#{parameter}']")[0]

    if(other.value().length + target.value().length >= 21)
      if !(keyCode in [0, 8, 9, 13, 37, 38, 39, 40, 46])
        event.preventDefault()
      else if(keyCode in [ 37, 38, 39, 40, 46] && ch != 'etc')
        event.preventDefault()

  validate_key = (event) ->
    event = event || window.event
    code = event
    ch = ''
    keyCode = code.which
    evt = code.type
    keyCode = code.keyCode if keyCode == null

    keyCode = window.event.keyCode if keyCode == undefined
    keyCode = window.event.which if keyCode == undefined

    return "" if keyCode == null # no key, no play
    # deal with special keys
    switch keyCode
      when 8 then ch = 'bksp'
      when 46 # // handle del and . both being 46
        ch = if evt == 'keydown' then 'del' else '.'
      when 16 then ch = 'shift'
      when 0, 9, 13 then ch = 'etc'
      when 37, 38, 39, 40
        ch = if !code.shiftKey && code.charCode != 39 && code.charCode != undefined then 'etc' else String.fromCharCode keyCode
    # default to thinking it's a character or digit
      else ch = String.fromCharCode keyCode

    # what the fuck
    # window.alert ch
    target = target_of_event event
    if !(keyCode in [0, 8, 9, 13, 37, 38, 39, 40, 46])
      if target.data("limit").indexOf(ch) == -1
        event.preventDefault()
    else if(keyCode in [ 37, 38, 39, 40, 46] && ch != 'etc')
      if target.instance.getAttribute("data-limit").indexOf(ch) == -1
        event.preventDefault()


  exports.initialize = ->
    for input in Document.select "#{Neatform.Data.form_class} input"
      # FUCK MASKED INPUTS! // commented for legacy
      # if input.data "template"
      #   params = { elm: input.instance, format: input.data("template"), separator: '+7\/:.- ()'}
      #   params.allowed = input.data("limit") if input.data "limit"
      #   MaskedInput params

      #   # positioning cursor on fisrt underscore if something has a template
      #   bind_event input, "keyup", position_cursor_in_template

      if input.data("limit") != null && !input.data("template")
        bind_event input, "keypress", validate_key
      # if input.data('parameter') == 'foreign_first_name' || input.data('parameter') == 'foreign_surname'
      #   bind_event input, "keypress", validate_foreign_length

domReady ->
  Neatform.Limits.initialize()
