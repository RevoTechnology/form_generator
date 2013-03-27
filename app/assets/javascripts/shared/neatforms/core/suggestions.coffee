namespace "Neatform.Suggestions", (exports) ->
  # ----------
  # Auto-finding places by ZIP code

  find_place_by_zip = (e) ->
    setTimeout ->
      control = target_of_event e
      index = parseInt control.value()
      if Neatform.Data.validation_status[Neatform.Data.current_step][control.attribute "id"] == true
        unless isNaN index
          XHR.post_with_csrf post_index_puller.url,
            { index: index },
            (data) ->
              unless data.error
                region_field = Document.find("#" + post_index_puller.region_field_id)
                if region_field
                  region_field.instance.value = data.region
                  Neatform.Validation.validate_field region_field.attribute "name"

                city_field = Document.find("#" + post_index_puller.city_field_id)
                if city_field
                  city_field.instance.value = data.city
                  Neatform.Validation.validate_field city_field.attribute "name"
    , 500

  # ----------
  # Suggestions popup
  # TODO: add keyboard controls handling (up, down, left, right arrows; escape; enter)

  suggest = (e) ->
    control = target_of_event e
    url = control.data "url"

    existing_suggest = Document.find "#suggest"
    existing_suggest.destroy() if existing_suggest

    XHR.post_with_csrf url,
      { data: control.value() },
      (data) -> # showing suggestion popup
        unless data.error
          show_suggestion_popup control, data.data

  show_suggestion_popup = (control, data) ->
    popup = new DOMElement "div"
    popup.add_class("suggest").add_class("neatform").attribute("id", "suggest")
    popup.inner_html "<ul>" + ("<li data-value='#{item}'>#{item}</li>" for item in data).to_s() + "</ul>"
    Document.select("body").first().append popup

    popup.css "top", "#{bonzo(control.instance).offset().top + 30}px"
    popup.css "left", "#{bonzo(control.instance).offset().left}px"
    popup.css "width", "#{bonzo(control.instance).offset().width}px"

    for item in popup.children("li[data-value]")
      bind_event item, "click", (e) ->
        item = target_of_event e
        control.instance.value = item.data "value"

    bean.one document, "click", (e) ->
      hide_suggestion_popup()

  hide_suggestion_popup = ->
    popup = Document.find "#suggest"
    popup.destroy() if popup

  exports.initialize = ->
    "some crazy code"
    # -------
    # enabling finding places by zip code if such fields are present
    # if window.post_index_puller && window.post_index_puller.index_field_id != ""
    #   bind_event Document.find("#" + window.post_index_puller.index_field_id), "keyup", (e) -> find_place_by_zip e

    # -------
    # enabling suggestions if any
    # if window.suggestion_urls
    #   for id, url of window.suggestion_urls
    #     item = Document.find("#" + id)
    #     # console.log item
    #     item.data "url", url
    #     bind_event item, "keyup", (e) -> suggest e


domReady ->
  Neatform.Suggestions.initialize()
