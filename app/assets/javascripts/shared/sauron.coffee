window.rand = () ->
  Math.ceil(Math.random() * 1000000)

window.element_with_id = (id) ->
  document.getElementById id

window.select_first = (selector) ->
  first_of select selector

window.select = (selector) ->
  qwery selector

window.first_of = (array) ->
  if array[0] then array[0] else null

window.elementize = (array) ->
  first_of array

window.objectize = (html_element) ->
  bonzo html_element

window.object_of = (element) ->
  objectize element

window.is_there = (thing) ->
  switch typeof(thing)
    when "string" then (if document.getElementById thing then true else false)
    when "object" then (if thing.length then true else false)

window.there_is = (thing) ->
  is_there thing

# returns element, not object
window.get_parent_of = (element, level = -1) ->
  if Math.abs(level) - 1
    get_parent_of first_of(objectize(element).parent()), level+1
  else
    first_of objectize(element).parent()

window.parent_of = (element, level = -1) ->
  get_parent_of element, level