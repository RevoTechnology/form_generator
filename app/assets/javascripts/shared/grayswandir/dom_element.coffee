# Dependancy: qwery.js

classReg = (c) ->
  return new RegExp("(^|\\s+)" + c + "(\\s+|$)")

trimReplace = /(^\s*|\s*$)/g
trim = if String.prototype.trim
    (s) -> return s.trim()
  else
    (s) -> return s.replace(trimReplace, '')

class DOMElement
  # - - - - - - - - - - - - - - - -
  # internals
  calculate_bottom: -> this.bottom = document.height - this.height - this.top

  calculate_right: -> this.right = document.width - this.left - this.width

  relation: (method) ->
    buffer = this.instance[method]
    buffer = buffer[method] while buffer && buffer.nodeType != 1
    if buffer then new DOMElement buffer else null

  parent_at_level: (level) ->
    if Math.abs(level) - 1
      parent = this.instance.parentNode
      for i in [1..(Math.abs(level) - 1)]
        parent = (if parent != null && parent.nodeName != "HTML" && typeof parent.parentNode != "undefined" then parent.parentNode else null)
      if parent then new DOMElement parent else null
    else this.relation "parentNode"

  parent_by_selector: (selector) ->
    # console.log "HEJ #{selector}"

  detect_features: ->
    e = document.createElement('p')
    this.has_class_list = if 'undefined' != typeof e['classList'] then true else false
    # console.log this.has_class_list

  constructor: (obj) ->
    this.instance = unless "string" == typeof obj then obj else document.createElement obj
    # console.log this.instance['parentNode']
    this.has_parent = if null != this.instance['parentNode'] then true else false
    this.tag = this.instance.tagName.toLowerCase() if "undefined" != typeof obj.tagName
    this.id = this.instance.id if "undefined" != typeof obj.id
    this.detect_features()
    # this.name = this.instance.getAttribute("name") || null

  # - - - - - - - - - - - - - - - -
  # tools
  hide: -> this.instance.style.display = "none"; this

  show: ->
    if this.instance.style.removeAttribute
      this.instance.style.display = '' if !this.instance.style.removeAttribute("display")
    else
      this.instance.style.removeProperty "display"
    return this

  clone: -> new DOMElement this.instance.cloneNode true

  destroy: -> if this.has_parent then new DOMElement this.instance.parentNode.removeChild this.instance else null

  parent: (arg = null) ->
    unless arg then return this.parent_at_level -1
    else
      return this.parent_at_level arg if typeof arg == "number"
      return this.parent_by_selector arg if typeof arg == "string"

  children: (selector) ->
    selector = selector || "*"
    (new DOMElement result for result in qwery selector, this.instance)

  child: (selector) -> (new DOMElement result for result in qwery selector, this.instance).first()

  next:     -> this.relation "nextSibling"

  previous: -> this.relation "previousSibling"

  before: (object) -> this.parent().instance.insertBefore object.instance, this.instance

  after: (object) ->
    if this.next()
      this.parent().instance.insertBefore object.instance, this.next().instance
    else
      this.parent().instance.appendChild object.instance

  append: (object) ->
    this.instance.appendChild object.instance; new DOMElement object.instance

  has_children: -> if this.instance.hasChildNodes then true else false

  prepend: (object) ->
    if this.has_children()
      this.instance.insertBefore object.instance, this.children().first().instance
    else
      this.append object
    # new DOMElement object.instance

  swap_children: (node1, node2) -> this.instance.insertBefore node1.instance, node2.instance

  move_up_in_parent: -> this.parent().swap_children this, this.previous()

  move_down_in_parent: -> this.parent().swap_children this.next(), this

  swap_data: (what, target) ->
    buffer = target.data what
    target.data what, this.data what
    this.data what, buffer

  # - - - - - - - - - - - - - - - -
  # class name manipulation
  add_class: (class_name) ->
    if this.has_class_list
      this.instance.classList.add class_name
    else
      this.instance.className = trim(this.instance.className + ' ' + class_name) unless this.has_class(class_name)
    return this

  remove_class: (class_name) ->
    if this.has_class_list
      this.instance.classList.remove class_name
    else
      this.instance.className = trim(this.instance.className.replace(classReg(class_name), ' '))
    return this

  has_class: (class_name) ->
    if this.has_class_list
      this.instance.classList.contains class_name
    else
      classReg(class_name).test this.instance.className

  toggle_class: (class_name) -> if this.has_class class_name then this.remove_class class_name else this.add_class class_name

  # - - - - - - - - - - - - - - - -
  # attributes manipulation
  inner_html: (data = null) ->
    if data
      # console.log this.instance.tagName
      this.instance.innerHTML = data
      return this
    else
      return this.instance.innerHTML

  full_html: -> this.instance.outerHTML

  append_html: (html) -> this.instance.innerHTML += html # do not fucking use this shit, ever

  clear: -> this.instance.innerHTML = ""

  value: -> this.instance.value

  attribute: (key, value = null) ->
    if value != null then this.instance.setAttribute key, value; return this
    else return if null != this.instance.getAttribute key then this.instance.getAttribute key else null

  data: (key, value = null) -> this.attribute "data-#{key}", value

  css: (parameter, argument = null) ->
    if argument
      this.instance.style[parameter] = argument
      return this
    else
      return this.instance.style[parameter]

  visible: -> if this.instance.clientWidth == 0 && this.instance.clientHeight == 0 then false else true

  top: ->
    _instance = this.instance
    top = _instance.offsetTop
    top = top + _instance.offsetTop while _instance = _instance.offsetParent
    top

  left: ->
    _instance = this.instance
    left = _instance.offsetLeft
    left = left + _instance.offsetLeft while _instance = _instance.offsetParent
    left

  width: -> this.instance.offsetWidth

  height: -> this.instance.offsetHeight

  # - - - - - - - - - - - - - - - -
  # udpaters
  # update_inner_html: (html) -> this.instance.innerHTML = data

  # update_attributes: (args) ->
  #   for key, value of args
  #     if this.hasOwnProperty key
  #       switch key
  #         when "width"
  #           this.element_instance.style.setProperty "width", "#{value}px"
  #           this.width = this.element_instance.clientWidth
  #           this.calculate_right()
  #   this

# push this function to prototype cache
window["globals"] = {} unless window["globals"]
window.globals.dom_element = DOMElement
