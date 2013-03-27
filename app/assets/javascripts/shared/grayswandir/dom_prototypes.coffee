Array.prototype.first = () -> this[0]
Array.prototype.to_s = () -> this.join ""
Array.prototype.last = () -> this[this.length-1]
Array.prototype.swap = (x, y) -> buffer = this[y]; this[y] = this[x]; this[x] = buffer; this
Array.prototype.remove_at_index = (index) -> this.splice index, 1
Array.prototype.destroy_at = (index) -> this.splice index, 1

String.prototype.to_i = () -> if this[0] == "0" and this.length > 1 then parseInt this.substr(1) else parseInt this

String.prototype.trim = -> this.replace /^\s+|\s+$/, ''
# remove all spaces from begin and end of string
# replaces all two spaces to one
String.prototype.clear_spaces = ->
  result = this.replace(/^\s+/, '').replace(/\s+$/, '')

  while result.indexOf('  ') != -1
    result = result.replace '  ', ' '

  result

String::capitalize = ->
  this.charAt(0).toUpperCase() + this.slice(1);

# Object.prototype.is_string = () -> if typeof this == "string" then true else false
# Object.prototype.is_number = () -> if typeof this == "number" then true else false

if !Array.prototype.indexOf
  Array.prototype.indexOf = (obj, start = 0) ->
    result = -1
    for i in [start .. this.length-1]
      if this[i] == obj
        result = i
    return result

Date::to_xussr_string = (month_wording = false) ->
  months = ["января", "февраля", "марта", "апреля", "мая", "июня", "июля", "августа", "сентября", "октября", "ноября", "декабря"]
  "#{this.getDate()} #{months[this.getMonth()]} #{this.getFullYear()}"

Date::to_xussr_month_string = (month_wording = false) ->
  months = ["января", "февраля", "марта", "апреля", "мая", "июня", "июля", "августа", "сентября", "октября", "ноября", "декабря"]
  "#{this.getDate()} #{months[this.getMonth()]}"

  # Array.prototype.indexOf = (elt, from = 0) ->
  #   len = this.length >>> 0
  #   from = Number(arguments[1]) || 0;

  #   from = if from < 0 then Math.ceil(from) else  Math.floor(from)
  #   from += len if (from < 0)

  #   while from < len
  #     if from in this and this[from] == elt
  #       return from
  #     from++

  #   return -1
