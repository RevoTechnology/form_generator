# Browsers

window.isIE8 = ->
  return !!( (/msie 8./i).test(navigator.appVersion) && !(/opera/i).test(navigator.userAgent) && window.ActiveXObject && XDomainRequest && !window.msPerformance )

window.isIE = ->
  # return true
  return !!(document.all && document.querySelector)

# Events

window.bind_event = (element, event_name, handler) ->
  bean.add element.instance, event_name, handler if element

window.fire_event = (element, event_name) ->
  bean.fire element.instance, event_name

window.clear_event = (element, event_name) ->
  bean.remove element.instance, event_name

window.target_of_event = (event) ->
  event = event || window.event
  if event
    if isIE8()
      _target = event.srcElement
    else
      _target = event.currentTarget
    # return _target
    new DOMElement _target
  else null

# Element analyzers

window.clickable_element = (element) ->
  if element.tag == "select" || (element.tag == "input" && (element.attribute("type") in ["checkbox", "radio", "hidden"]))
    true
  else false

window.dropdown_element = (element) ->
  if element && element["tag"] && (element.tag == "select") then true else false

window.writable_element = (element) ->
  if element.tag == "textarea" || (element.tag == "input" && (element.attribute("type") in ["text", "password", "number", "tel"]))
    true
  else false

# Value extractors

window.get_value = (name) ->
  elements = Document.find_all_by_name name
  if elements.first().attribute("type") != 'number' && elements.length > 1 then parse_radio elements else (parse_value elements.first() if elements.length)

parse_value = (element) ->
  if (isIE8() && element.tag == 'select')
    return element.instance.options[element.instance.selectedIndex].value

  if (element.tag in ['select', 'textarea']) || (element.tag == 'input' && element.attribute('type') in ['text', 'password', 'hidden', 'item', 'number', 'tel', 'date'])
    return "" if element.instance.value == element.instance.getAttribute("placeholder") && !element.data("changed") && isIE()
    return element.value()

  if (element.tag == 'input' && element.attribute('type') == 'date')
    return element.instance.value

  if element.tag == 'input' && 'checkbox' == element.attribute("type")
    return if element.instance.checked then true else false

parse_radio = (elements) ->
  return element.value() for element in elements when element.instance.checked
  return null

window.get_select_value = (inst) ->
  if isIE8()
    inst.options[inst.selectedIndex].value
  else
    inst.value

window.is_final_step = ->
  Neatform.Data.current_step == Neatform.Data.number_of_steps

window.trace = (thing) ->
  if window.console
    console.log thing
  else
    false

window.scroll_to = (position) ->
  document.body.scrollTop = position
  document.scrollTop = position
  window.scrollTop = position

window.scroll_to_top = ->
  scroll_to 0
