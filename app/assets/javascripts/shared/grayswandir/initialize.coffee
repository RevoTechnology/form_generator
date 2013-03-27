window.DOMElement = window.globals.dom_element
window.Document = new window.globals.selector_request()

# domReady ->
  # window.thing = Document.find_by_tag("<b>").first()
  # thing.update_attributes { width: 40 }
