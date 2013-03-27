# Welcome to NeatForms 3!
# Now playing: Baths
# Hopefully it won't be the mess this time

# Some tools
field_names_in_current_step = ->
  result = new Array()
  for field in Document.select("fieldset[data-step='#{Neatform.Data.current_step}'] [name]")
    if Neatform.Validation && Neatform.Validation.field_is_subject_to_validation(field)
      result.push field.attribute "name"
  result

field_names_in_step = (index)->
  result = new Array()
  for field in Document.select("fieldset[data-step='#{index}'] [name]")
    if Neatform.Validation && Neatform.Validation.field_is_subject_to_validation(field)
      result.push field.attribute "name"
  result

any_field_names_in_step = (index) ->
  result = new Array()
  for field in Document.select("fieldset[data-step='#{index}'] [name]")
    unless field.attribute("name") in Neatform.Data.fields_to_ignore
      result.push field.attribute "name"
  result

Neatform.Data.get_field_names_in_current_step = field_names_in_current_step
Neatform.Data.get_field_names_in_step = field_names_in_step
Neatform.Data.get_any_field_names_in_step = any_field_names_in_step

# Callbacks for step switching
step_criterias = []
step_switch_criteria = (func) ->
  step_criterias.push func

pre_step_switch_triggers = []
before_step_switch = (func) ->
  pre_step_switch_triggers.push func

post_step_switch_triggers = []
after_step_switch = (func) ->
  post_step_switch_triggers.push func

Neatform.step_switch_criteria = step_switch_criteria
Neatform.before_step_switch = before_step_switch
Neatform.after_step_switch = after_step_switch

# Step switching
preflight_check = ->
  result = true
  for criteria in step_criterias
    if false == criteria.call()
      result = false
      break
  result

ignite_engines = ->
  trigger.call() for trigger in pre_step_switch_triggers

afterburn = ->
  trigger.call() for trigger in post_step_switch_triggers

soft_switch_step = (step_index) ->
  hard_switch_step(step_index) if preflight_check()

window.go_to_step = (step) ->
  hard_switch_step(step)

soft_switch_step_prev = (step_index) ->
  ignite_engines()
  Neatform.Data.current_step = step_index
  afterburn()

hard_switch_step = (step_index) ->
  ignite_engines()
  Neatform.Data.current_step = step_index
  afterburn()

# Fieldsets handling
initialize_fieldsets = ->
  fieldsets = Document.select "#{Neatform.Data.form_class} fieldset"
  Neatform.Data.number_of_steps = fieldsets.length
  fieldset.data "step", i+1 for fieldset, i in fieldsets

generate_button_for_step = (index) ->
  button = new DOMElement "ul"
  button.add_class "buttons"
  
  if Neatform.Data.number_of_steps == index
    button.inner_html "<li><input class='float-right' type='submit' value='Отправить заявку'></li>"
  else if 1 == index
    button.inner_html "<li><button class='next float-left'>Следующий шаг</button></li>"
  else
    button.inner_html "<li><button class='next float-right'>Следующий шаг</button></li>"

  if Neatform.Data.step_validation_ignor

    button_prev = new DOMElement "div"
    button_prev.add_class "buttons"

    container = new DOMElement "div"
    container.add_class "button_container_#{index}"
    unless 1 == index
      button_prev.inner_html "<li><button class='prev float-left'>Предыдущий шаг</button></li>"
      container.append button_prev
      container.append button
    else
      container.append button
    return container
  else
    return button

initialize_buttons_in_steps = ->
  for fieldset in Document.select "#{Neatform.Data.form_class} fieldset"
    step = fieldset.data("step").to_i()
    button_container = generate_button_for_step step

    fieldset.append button_container

    bind_event button_container.child("button.next"), "click", (e) ->
      e.preventDefault()
      button = target_of_event e
      soft_switch_step(Neatform.Data.current_step + 1)
      window.scrollTo(0, 0)

    bind_event button_container.child("button.prev"), "click", (e) ->
      e.preventDefault()
      button = target_of_event e
      soft_switch_step_prev(Neatform.Data.current_step - 1)
      window.scrollTo(0, 0)

    bind_event button_container.child("input[type='submit']"), "click", (e) ->
      button = target_of_event e

      e.preventDefault()
      soft_switch_step(Neatform.Data.current_step + 1)

      #submit_form()

initialize_form_action_attribute = ->
  form.attribute "action", "#{window.organization_url}" unless window.organization_url == ""

# Detectors
detect_form_class = ->
  form = Document.select("form.neatform").first()
  unless form
    form = Document.select("form.custom_form").first()
    Neatform.Data.form_class = ".custom_form"

  window.form = form # global hook to form container, do we need it at all?

detect_accordion = ->
  Neatform.Data.skin_is_accordion = if Document.select("ul.steps").length then false else true

# Generators
generate_client_id = ->
  csrf = Document.find_by_tag("<meta>").with_attr( {name: "csrf-token"}).first().attribute("content")
  client_id = "#{csrf}#{(new Date()).getTime()}"
  Neatform.Data.client_id = client_id

# Step toggler
show_current_step = ->
  for step, i in Document.select("#{Neatform.Data.form_class} fieldset")
    if i != Neatform.Data.current_step-1 then step.hide() else step.show()

  unless Neatform.Data.skin_is_accordion
    for step_item in Document.select("#{Neatform.Data.form_class} ul.steps li")
      if Neatform.Data.current_step != step_item.data("step").to_i()
        step_item.remove_class("active")
      else
        step_item.add_class "active"


# Human Factor backward compatibility
window.next_step = ->
  hard_switch_step(Neatform.Data.current_step + 1)

initialize_step_menu = ->
  # making first step control active and clickable if form has multiple steps
  if Neatform.Data.number_of_steps > 1
    unless Neatform.Data.skin_is_accordion
      first_step_li = Document.select("ul.steps li[data-step='1']").first()
      first_step_li.add_class "enabled"
      bind_event first_step_li, "click", (e) ->
        target = target_of_event e
        hard_switch_step parseInt target.data "step" # THIS IS FUCKING CRAZY LIFEHACK
  else
    step_header = Document.select("#{Neatform.Data.form_class} fieldset legend").first()
    step_header.hide()

# Initializers wrap-up
domReady ->
  # Neatform.Data.step_validation_ignor = true
  # Neatform.Data.validation_block = true

  detect_accordion()
  detect_form_class()
  generate_client_id()
  initialize_fieldsets()
  initialize_buttons_in_steps()
  initialize_form_action_attribute()
  initialize_step_menu()
  show_current_step()

  # Now, you can customize anything you want about steps.

  # Step switching criterias:
  # A: Step is valid
  step_switch_criteria ->
    unless Neatform.Data.step_validation_ignor
      step_is_valid = Neatform.Validation.validate_step(Neatform.Data.current_step)
      Neatform.Validation.highlight_errors_in_current_step() unless step_is_valid
      step_is_valid
    else
      # may be another way to do this
      unless Neatform.Data.number_of_steps == Neatform.Data.current_step
        # go to the next/prev step
        true
      else
        #TODO highlight errors in some cool error block
        if Neatform.ValidationBlock
          Neatform.ValidationBlock.clear_field_statuses()
        form_is_valid = Neatform.Validation.validate_form()

        Neatform.Data.global_validation = true
        Neatform.Validation.highlight_errors_in_form() unless form_is_valid
        Neatform.Data.global_validation = false

        if Neatform.ValidationBlock
          Neatform.ValidationBlock.show_validation_blocks()
        form_is_valid

  # B: 'Next' button isn't locked
  step_switch_criteria ->
    unless Neatform.Data.step_validation_ignor
      fieldset = Document.select("fieldset[data-step=#{Neatform.Data.current_step}]").first()
      button = if is_final_step() then fieldset.child("input[type='submit']") else fieldset.child("button.next")
      if "true" == button.data "locked"
        false
      else
        button.data "locked", "true"
        true
    else
      true

  before_step_switch ->

  after_step_switch ->
    show_current_step()
    if Neatform.Data.current_step <= Neatform.Data.number_of_steps
      unless Neatform.Data.skin_is_accordion
        Document.select("#{Neatform.Data.form_class} ul.steps li[data-step='#{Neatform.Data.current_step}']").first().add_class "enabled"
        Document.select("#{Neatform.Data.form_class} ul.steps li[data-step='#{Neatform.Data.current_step}']").first().add_class "active"

    # bind_event button.child("input[type='submit']"), "click", (e) ->
    #   e.preventDefault()
    #   button = target_of_event e
    #   unless "true" == button.data "locked"
    #     # show_next_step()
    #     unless Neatform.Validation.validate_step Neatform.Data.current_step
    #       highlight_errors_in_current_step()
    #     else
    #       button.data "locked", "true"
    #       button.add_class "loading"
    #       submit_form()










# select_option = (inst, value) ->
#   for option, index in inst.options
#     if option.value == value
#       elem = new DOMElement(inst)
#       elem.previous().inner_html(value)# set span elem
#       inst.selectedIndex = index
#       inst.setAttribute('value', value)
#       option.selected = true
#     else
#       option.selected = false

# remove_click_to_current_step = () ->
#   unless Neatform.Data.skin_is_accordion
#     step_item = Document.select("#{Neatform.Data.form_class} ul.steps li[data-step='#{Neatform.Data.current_step}']").first()
#     clear_event step_item, "click" unless window.preview_mode

# show_current_step = ->
#   for step, i in Document.select("#{Neatform.Data.form_class} fieldset")
#     if i != Neatform.Data.current_step-1 then step.hide() else step.show()

#   unless Neatform.Data.skin_is_accordion
#     for step_item in Document.select("#{Neatform.Data.form_class} ul.steps li")
#       if Neatform.Data.current_step != step_item.data("step").to_i()
#         step_item.remove_class("active")
#       else
#         step_item.add_class "active"

# switch_step = (number) ->
#   Neatform.Data.current_step = number
#   window.cs = Neatform.Data.current_step

#   if Neatform.StepAnimation && !window.preview_mode
#     hide_step_preloader()
#     Neatform.StepAnimation.woo_woo()
#   else
#     show_current_step()

# show_step_preloader = ->
#   loader = Document.find("#big_loader")
#   fieldset = Document.select("fieldset[data-step='#{Neatform.Data.current_step}']").first()
#   loader.css "display", "block"
#   loader.css "top", "#{fieldset.top()+20}px"
#   loader.css "height", "#{fieldset.height()-20}px"

# hide_step_preloader = ->
#   Document.find("#big_loader").css "display", "none"

# window.ssp = show_step_preloader

# show_next_step = ->
#   unless Neatform.Data.current_step == Neatform.Data.number_of_steps
#     button = Document.select("fieldset[data-step='#{Neatform.Data.current_step}'] ul button.next").first()

#     if next_step_allowed()
#       unless window.preview_mode || window.organization_url == "" || "true" == button.data("locked")
#         remove_click_to_current_step()
#         try
#           send_current_step_log()
#           button.data "locked", "true"
#           show_step_preloader()
#           button.instance.innerHTML = ""
#           button.add_class "loading"
#         catch error
#           switch_step(Neatform.Data.current_step + 1)
#           # alert "Произошла ошибка сервера, дальнейшая работа формы невозможна."
#       else
#         switch_step(Neatform.Data.current_step + 1)
#         Neatform.Calendar.time_warp() if Neatform.Data.current_step == 2
#     else
#       highlight_errors_in_current_step()

# show_previous_step = ->
#   switch_step(Neatform.Data.current_step - 1) unless Neatform.Data.current_step == 1

# next_step_allowed = ->
#   if (Neatform.Data.current_step + 1) in Neatform.Data.allowed_steps then true else false

# # ----------
# # Fields and validations

# window.vs = Neatform.Data.validation_status

# highlight_invalid_steps = ->
#   for step_index in Neatform.Data.allowed_steps
#     unless step_index == Neatform.Data.current_step
#       unless Neatform.Validation.validate_step step_index
#         unless Neatform.Data.skin_is_accordion
#           Document.select("ul.steps li[data-step='#{step_index}']").first().add_class("error")

#   for step_index in Neatform.Data.allowed_steps
#     unless step_index == Neatform.Data.current_step
#       unless Neatform.Validation.validate_step step_index
#         switch_step step_index
#         highlight_errors_in_current_step()

# field_is_subject_to_validation = (field) ->
#   !! ( ( (field.visible() || (field.tag == "input" && field.instance.type == "checkbox")) && validations[field.attribute "name"] ) || (field.instance.type == "radio") || (field.visible() && field.tag == "select") )

# all_field_values_in_current_step = ->
#   result = new Object()
#   for field in Document.select("fieldset[data-step='#{Neatform.Data.current_step}'] [name]")
#     if -1 == Neatform.Data.fields_to_ignore.indexOf(field.instance.name)
#       result[field.attribute "name"] = get_value field.attribute "name"
#   result

# window.fnames = field_names_in_current_step

# highlight_errors_in_current_step = ->
#   Neatform.Data.validation_status[Neatform.Data.current_step] = {} unless Neatform.Data.validation_status[Neatform.Data.current_step]

#   for field_name in field_names_in_current_step()
#     unless Neatform.Data.validation_status[Neatform.Data.current_step][field_name]
#       # console.log field_name
#       Neatform.Validation.validate_field field_name

# validate_form = ->
#   result = true
#   for step_index in Neatform.Data.allowed_steps
#     result = false unless Neatform.Validation.validate_step step_index
#   result

# validations_contain_musthave = (validations) ->
#   result = false
#   for validation in validations
#     return true if validation.regexp == "/\\\A.+\\\z/"
#   result

# window.resend_sms = false

# window.next_step = () ->
#   switch_step(window.cs + 1)
#   Neatform.Calendar.time_warp() if Neatform.Data.current_step == 3

# generate_current_step_data = () ->
#   field_data = (for name, value of all_field_values_in_current_step()
#     { "field": { "builder_id": name }, "value": value, "parameter": Document.find_by_name(name).data("parameter") }
#   )

#   data =
#     "client_key": client_id
#     "order":
#       "builder_id": window.order_info.order_id
#     "version":
#       "builder_id": window.order_info.version_id
#     "step":
#       "builder_id": Neatform.Data.current_step
#     "fields": field_data
#     "resend_sms": window.resend_sms
#     "time": step_seconds
#   return data

# window.gcsd = generate_current_step_data

# # and now some crazy timeout shit yeah
# step_logging_timeout = 0
# step_callback_fired = false

# send_current_step_log = () ->
#   step_callback_fired = false
#   data = generate_current_step_data()
#   clearTimeout step_logging_timeout

#   send_step_data data
#   step_logging_timeout = setInterval send_step_data, 10000, data

# send_step_data = (data) ->
#   # console.log ">> sending shit..."
#   XHR.post "#{window.organization_url}/api/step.json",
#     { data: JSON.stringify data },
#     step_logging_callback

# decision_time = 0
# decision_timer = {}
# decision_timer_20 = {}

# start_decision_timer = ->
#   decision_timer = setInterval ->
#     decision_time++
#   ,
#   1000

# get_decision_seconds_string = ->
#   affix = "секунд"
#   affix = "секунду" if decision_time == 1
#   affix = "секунды" if (decision_time % 10) in [2, 3, 4]
#   affix = "секунд" if  10 < decision_time < 21
#   return "#{decision_time} #{affix}"

# step_logging_callback = (data) ->
#   unless step_callback_fired
#     # console.log "<<< got shit"
#     step_callback_fired = true
#     clearInterval step_logging_timeout

#     if data.error
#       Document.select("#{Neatform.Data.form_class} fieldset[data-step='#{Neatform.Data.current_step}']").first().hide()
#       if Neatform.HumanFactor && data.error && data.action == "clarify"
#         hide_step_preloader()
#         Neatform.HumanFactor.validate(data.what)
#     else
#       switch_step(Neatform.Data.current_step + 1)
#       Neatform.Calendar.time_warp() if Neatform.Data.current_step == 2 # fixing year picking ranges, FFS
#       hide_sms_code_confirmation_field() if data.hide_sms
#       window.sms_code = data.sms_code if data.sms_code
#       analyze_decision data if Neatform.Data.current_step == 6


# data_for_decision = {}

# analyze_decision = (data) ->
#   if data.decision != 'stop'
#     data.decision = "wait"
#   if data.decision
#     box = Document.find("#thankyou")
#     clock = Document.find("#clock")

#     switch data.decision
#       when "approve"
#         box.css "display", "block"
#         box.inner_html "<img src='/assets/bin_5/decision-approve.jpg' alt='Заявка одобрена' /> <strong>Добро пожаловать в мир<br>удивительных возможностей Эlixir!</strong> <br>Ваша заявка была одобрена!<br>Начните пользоваться картой Эlixir, перейдя по ссылке<br><a href='https://internetbank.elixirbank.ru' target='_blank'>https://internetbank.elixirbank.ru</a>"
#         clearInterval decision_timer
#         clock.css "display", "none"
#       when "decline"
#         box.css "display", "block"
#         box.inner_html "<img src='/assets/bin_5/decision-decline.jpg' alt='Заявка отклонена' /> <strong>Спасибо за Ваш интерес<br>к картам Эlixir!</strong> Сейчас мы не можем выпустить Вам карту, но обязательно<br>свяжемся с Вами при первой же возможности<br>начать сотрудничество!"
#         clock.css "display", "none"
#       when "verification"
#         box.css "display", "block"
#         box.inner_html "<img src='/assets/bin_5/decision-investigate.jpg' alt='Заявка получена' /> <strong>Спасибо за Ваш интерес<br>к картам Эlixir!</strong> Мы получили Вашу заявку и свяжемся с Вами в ближайшее время.<br>Номер Вашей заявки #{data.order_id}"
#         clock.css "display", "none"
#       when "investigate"
#         box.css "display", "block"
#         box.inner_html "<img src='/assets/bin_5/decision-investigate.jpg' alt='Заявка получена' /> <strong>Спасибо за Ваш интерес<br>к картам Эlixir!</strong> Мы получили Вашу заявку и свяжемся с Вами в ближайшее время.<br>Номер Вашей заявки #{data.order_id}"
#         clock.css "display", "none"
#       when "error"
#         box.css "display", "block"
#         box.inner_html "<img src='/assets/bin_5/decision-investigate.jpg' alt='Заявка получена' /> <strong>Спасибо за Ваш интерес к картам Эlixir!</strong> <br>Мы получили Вашу заявку и свяжемся с Вами в ближайшее время.<br>Номер Вашей заявки #{data.order_id}"
#         clock.css "display", "none"
#       when "wait"
#         clock = Document.find "#clock"
#         clock.css "display", "block"
#         if(Neatform.Data.decision_retries == 0)
#           data_for_decision = data
#           setTimeout resend_with_60_second, 60000
#         Neatform.Data.decision_retries += 1
#         if Neatform.Data.decision_retries == 4
#           clearTimeout(decision_timer_20)
#           box.css "display", "block"
#           box.inner_html "<img src='/assets/bin_5/decision-investigate.jpg' alt='Заявка получена' /> <strong>Спасибо за Ваш интерес к картам Эlixir!</strong> <br>Мы получили Вашу заявку и свяжемся с Вами в ближайшее время.<br>Номер Вашей заявки #{data.order_id}"
#           clock.css "display", "none"
#         else
#           clock = Document.find "#clock"
#           clock.css "display", "block"
#           resend_data_in_a_minute()
#       when "stop"
#         clearTimeout(decision_timer_20)
#         box.css "display", "block"
#         box.inner_html "<img src='/assets/bin_5/decision-investigate.jpg' alt='Заявка получена' /> <strong>Спасибо за Ваш интерес к картам Эlixir!</strong> <br>Мы получили Вашу заявку и свяжемся с Вами в ближайшее время.<br>Номер Вашей заявки #{data.order_id}"
#         clock.css "display", "none"

#     #  when "success"
#     #    box.css "display", "block"
#     #    box.inner_html "Ваша заявка успешно принята к рассмотрению. Наш сотрудник<br />свяжется с вами в ближайшее время."
#     #  when "failure"
#     #    box.css "display", "block"
#     #    box.inner_html "Ваша заявка отклонена."
#     #  when "wait"
#     #    resend_data_in_a_minute()

# resend_with_60_second = ()->
#   clock = Document.find("#clock")
#   clock.css "display", "none"
#   if data_for_decision
#     data_for_decision.decision = "stop"
#   data = if data_for_decision then data_for_decision else {}
#   analyze_decision data

# resend_data_in_a_minute = ->
#   box = Document.find("#thankyou")
#   box.css "display", "block"
#   clock = Document.find("#clock")
#   clock.css "display", "block"
#   box.inner_html "Спасибо за заполнение заявки! Ваша заявка обрабатывается.<br />Вы получите ответ через 60 секунд."
#   # start_resend_countdown()
#   decision_timer_20 = setTimeout resend_data, 20000

# # start_resend_countdown = ->
# #   2

# resend_data = ->
#   #console.log "DATA RESENT"
#   data =
#     "client_key": client_id
#     "order":
#       "builder_id": window.order_info.order_id
#     "version":
#       "builder_id": window.order_info.version_id
#     "step":
#       "builder_id": 5
#     "fields": []

#   XHR.post "#{window.organization_url}/api/step.json",
#     { data: JSON.stringify data },
#     resend_callback

# resend_callback = (data) ->
#   analyze_decision data

# window.ad = analyze_decision

# send_form_log = () ->
#   step_data = new Array()
#   for step_number in [1..Neatform.Data.number_of_steps]
#     _step =
#       "step":
#         "builder_id": step_number
#       "fields": new Array()

#     for field in Document.select("fieldset[data-step='#{step_number}'] [name]")
#       unless field.attribute("name") in Neatform.Data.fields_to_ignore
#         _step.fields.push { "field": { "builder_id": field.attribute("name") }, "value": get_value field.attribute("name") }

#     step_data.push _step

#   data =
#     "client_key": client_id
#     "order":
#       "builder_id": Neatform.Data.current_step
#     "version":
#       "builder_id": window.order_info.version_id
#     "steps": step_data

#   XHR.post "#{window.organization_url}/api/form.json",
#     { data: JSON.stringify data },
#     form_logging_callback

# form_logging_callback = (data) ->
#   unless data.error
#     2
#     # console.log "FORM SENT YO"


# # ----------
# # Scenarios

# hide_sms_code_confirmation_field = ->
#   # console.log "FUCK"
#   # console.log window.cs
#   # console.log window.resend_sms
#   window.resend_sms = true if window.cs == 2
#   # console.log window.resend_sms
#   Document.select("input[parameter='sms_code_confirmation']").first().hide() if Document.select("input[parameter='sms_code_confirmation']").length

# window.hsccf = hide_sms_code_confirmation_field

# Neatform.Data.fields_to_ignore = new Array()
# # console.log typeof Neatform.Data.fields_to_ignore

# window.fti = Neatform.Data.fields_to_ignore

# # ----------
# # Submitting

# submit_form = ->
   # unless validate_form()
   #   highlight_invalid_steps() if number_of_steps > 1
   # else
#   if window.preview_mode
#     generate_demo_json()
#   else
     # if validate_step(current_step)
#     send_current_step_log()
     # else
       # highlight_errors_in_current_step()
     # clear_before_submit()
     # send_form_log() unless window.organization_url == ""
     # Document.select("form#{Neatform.Data.form_class}").first().instance.submit()

# # ----------
# # Key validation

# clear_before_submit = ->
#   fields_manes = field_names_in_current_step()
#   for name in fields_manes
#     elements = Document.find_all_by_name name
#     if elements.length == 1  && is_space_clear_tag(elements.first())
#       element = elements.first()
#       el = document.getElementsByName(element.instance.name)[0]
#       el.value = element.value().trim()

# # ----------
# # JSON generation for previewing purposes

# generate_demo_json = () ->
#   data =
#     user_agent: navigator.userAgent
#     form_id: preview_form_id
#     # skin_id: "some_current_skin"
#     form_data: collect_form_data()

#   json_preview = Document.find "#demo-code-preview"
#   json_preview.inner_html JSON.stringify(data)
#   json_preview.css "display", "block"

# collect_form_data = () ->
#   things = {}

#   for item in form.children "*"
#     if  item.tag in ["input", "select", "textarea"]
#       things[item.id] = item.value() if item.value()

#   things

# collect_form_extended_data = () ->
#   data =
#     user_agent: navigator.userAgent
#     form_id: preview_form_id
#     # skin_id: "some_current_skin"
#     form_data: collect_form_data()

#   json_preview = objectize element_with_id "demo-code-preview"
#   JSON.stringify data

# # ----------
# # Custom skin CSS generation

# generate_skin_css = () ->
#   "\t\t.neatform legend { color: #{window.existing_skin.colors.header} }\n
#   .neatform label, .neatform strong { color: #{window.existing_skin.colors.label} }\n
#   .neatform .message.hint { color: #{window.existing_skin.colors.hint} }\n
#   .neatform .message.error { color: #{window.existing_skin.colors.error} }\n
#   .neatform a, .neatform a:hover { border-bottom: none }\n
#   .neatform a { color: #{window.existing_skin.colors.link} }\n
#   .neatform a:hover { color: #{window.existing_skin.colors.link_hover} }\n
#   .neatform hr { border-bottom-color: #{window.existing_skin.colors.separator} }\n
#   .neatform label, .neatform input, .neatform strong, .neatform select, .neatform .message { font-family: '#{window.existing_skin.fonts.form}' } \n
#   .neatform h1, .neatform h2, .neatform h3, .neatform h4, .neatform legend, .neatform legend span { font-family: '#{window.existing_skin.fonts.header}' }
#     "
# # ----------
# # Step timer

# step_seconds = 0
# step_timer = null

# restart_step_timer = ->
#   clearInterval step_timer
#   step_seconds = 0
#   step_timer = setInterval ->
#       step_seconds++
#     ,
#     1000

# # ----------
# # Initialization

# domReady ->
#   initialize_fieldsets()
#   initialize_buttons_in_steps()
#   Neatform.StepAnimation.init()
#   # show_current_step()
#   restart_step_timer()

#   element = Document.select("select[data-parameter='workplace_since_year']")[0]
#   bind_event element, 'change', (e) ->
#     work_since = Document.select("select[data-parameter='workplace_since_year']")[0]
#     target = Document.select("select[data-parameter='total_working_since_year']")[0]
#     select_option(target.instance, get_select_value(work_since.instance) );

#   # making first step control active and clickable if form has multiple steps
#   if Neatform.Data.number_of_steps > 1
#     unless Neatform.Data.skin_is_accordion
#       first_step_li = Document.select("#{Neatform.Data.form_class} ul.steps li[data-step='1']").first()
#       first_step_li.add_class "enabled"
#       bind_event first_step_li, "click", (e) ->
#         target = target_of_event e
#         switch_step parseInt target.data "step"
#   else
#     step_header = Document.select("#{Neatform.Data.form_class} fieldset legend").first()
#     step_header.hide()

#   # enabling all the steps if we are in preview mode
#   if window.preview_mode
#     Neatform.Data.allowed_steps = [1..Neatform.Data.number_of_steps]
#     if Neatform.Data.number_of_steps > 1
#       unless Neatform.Data.skin_is_accordion
#         for step_index in [2..Neatform.Data.number_of_steps]
#           step_li = Document.select("#{Neatform.Data.form_class} ul.steps li[data-step='#{step_index}']").first()
#           step_li.add_class "enabled"
#           bind_event step_li, "click", (e) ->
#             # console.log target_of_event e
#             target = target_of_event e
#             switch_step parseInt target.data "step"
#       else
#         for step_index in [1..Neatform.Data.number_of_steps]
#           header = Document.select("#{Neatform.Data.form_class} .step_title[data-step='#{step_index}']").first()
#           bind_event header, "click", (e) ->
#             target = target_of_event e
#             switch_step parseInt target.data "step"

#   # -------
#   # handling custom skins
#   if window.existing_skin
#     html_header = Document.find_by_tag("<head>").first()
#     style = new DOMElement "style"
#     html_header.append style

#     if isIE8
#       document.styleSheets[document.styleSheets.length-1].cssText = generate_skin_css()
#     else
#       style.inner_html generate_skin_css()

#   # -------
#   # iframe hack for IE stuff
#   # document.domain = "iceberglabs.binbank.ru" if isIE()

#   # console.log new DOMElement(top.document.body).child("iframe").instance.scrollTop = 300

