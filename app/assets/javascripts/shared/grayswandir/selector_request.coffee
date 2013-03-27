DOMElement = window.globals.dom_element

class SelectorRequest
  # - - - - - - - - - - - - - - - -
  # internals
  ie: /msie/i.test(navigator.userAgent)

  constructor: () ->
    this.selectors = []

  current_selector: () ->
    this.selectors[this.selectors.length] = {} if typeof this.selectors.first() == "undefined"
    this.selectors.first()

  # - - - - - - - - - - - - - - - -
  # finders
  find: (id) -> this.with_id(id).first()

  select: (selector = undefined) -> this.current_selector().prefix = selector if selector; this.all()

  # - - - - - - - - - - - - - - - -
  # conditions
  find_by_tag: (tag_name) ->
    if typeof tag_name == "string" && tag_name.match(/^<[a-zA-Z]*>$/).length
      this.current_selector().tag = tag_name.slice(1, tag_name.length-1)
    this

  of_class: (class_name) ->
    if typeof class_name == "string"
      this.current_selector().klass = [] if typeof this.current_selector().klass == "undefined"
      this.current_selector().klass.push class_name
    this

  with_id: (id) -> this.current_selector().id = id if typeof id == "string"; this

  with_attr: (args) ->
    this.current_selector().attributes = {} if typeof this.current_selector().attributes == "undefined"
    this.current_selector().attributes[key] = value for key, value of args
    this

  within_tag: (tag_name) ->
    if typeof tag_name == "string" && tag_name.match(/^<[a-zA-Z]*>$/).length
      this.selectors.unshift { tag: tag_name.slice(1, tag_name.length-1) }
    this

  find_by_name: (name) ->
    this.with_attr({ name: name }).first()

  find_all_by_name: (name) ->
    this.with_attr({ name: name }).all()

  # - - - - - - - - - - - - - - - -
  # quering interface
  all: () ->
    selector_string = (for s in this.selectors
      klass = if s.klass then "." + s.klass.join(".") else ""
      attributes = if s.attributes then ("[#{key}='#{value}']" for key, value of s.attributes).join("") else ""
      [s.prefix || "", s.tag || "", klass, s.id || "", attributes].join ""
    ).join " "

    this.selectors = []
    (new DOMElement result for result in qwery selector_string)

  first: () -> this.all().first()

  last: () -> this.all().last()

  nth: (n) -> this.all()[n-1]

  # - - - - - - - - - - - - - - - -
  # dimensions. todo: move the hell out
  dimensions: # todo: refactor for IE
    width: -> window.innerWidth
    height: -> window.innerHeight

# - - - - - - - - - - - - - - - -
# push this function to prototype cache
window["globals"] = {} unless window["globals"]
window.globals.selector_request = SelectorRequest
