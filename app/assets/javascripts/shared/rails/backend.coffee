domReady ->

  # Replacing rails functionality for DELETE links. Ported from rails_ujs
  method_link_click = (e) ->
    e.preventDefault()
    link = objectize e.currentTarget
    href = link.attr('href')
    method = link.attr('data-method')
    csrf_token = objectize(select_first('meta[name=csrf-token]')).attr('content')
    csrf_param = objectize(select_first('meta[name=csrf-param]')).attr('content')

    form = "<form id=\"delform\" method=\"post\" action=\"#{href}\"></form>"
    metadata_input = "<input name=\"_method\" value=\"#{method}\" type=\"hidden\" />"

    if csrf_param && csrf_token
      metadata_input += "<input name=\"#{csrf_param}\" value=\"#{csrf_token}\" type=\"hidden\" />"

    objectize(select_first("body")).append(form)
    form = objectize element_with_id "delform"
    form.hide().append(metadata_input)
    elementize(form).submit()

  # bean.add item, "click", delete_link_click for item in select("a[data-method='delete']")

  # Replacing rails functionality for :confirm parameter in link_to()
  confirm_click = (e) ->
    link = objectize e.currentTarget
    if link.attr('data-confirm') && confirm(link.attr('data-confirm'))
      if link.attr('data-method')
        method_link_click e
    else
      e.preventDefault()

  for item in select("a[data-method]")
    # console.log "shit"
    if objectize(item).attr "data-confirm"
      bean.add item, "click", confirm_click
    else
      bean.add item, "click", method_link_click

  # some other stuff
  if is_there "field_body"
    textarea = element_with_id "field_body"

    textarea_typing = (e) ->
      if e.keyCode == 9
        e.preventDefault()
        insert_text textarea, "  "

    insert_text = (element, text) ->
      val = element.value
      if (typeof element.selectionStart != "undefined" && typeof element.selectionEnd != "undefined")
        endIndex = element.selectionEnd;
        element.value = val.slice(0, endIndex) + text + val.slice(endIndex);
        element.selectionStart = element.selectionEnd = endIndex + text.length;
      else if (typeof document.selection != "undefined" && typeof document.selection.createRange != "undefined")
        element.focus();
        range = document.selection.createRange();
        range.collapse(false);
        range.text = text;
        range.select();

    bean.add textarea, "keydown", textarea_typing
