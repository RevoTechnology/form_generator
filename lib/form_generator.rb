require "form_generator/engine"
require "form_generator/core"
require "form_generator/form"
require "form_generator/css_renderer"
require "form_generator/js_renderer"
require "form_generator/cream/cream"

# @form = FormGenerator.new(params, request).form
# if form.nil?
#   ""
# else
#   @form.render
#   @form.js_path
#   @form.css_path
# end
module FormGenerator
  def self.new options={}
    Core.new options
  end
end
