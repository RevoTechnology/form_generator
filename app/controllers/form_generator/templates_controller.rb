# TODO: Remove this
module FormGenerator
  class TemplatesController < ActionController::Base
    def new_version
      render :layout => "templates"
    end

    def neatforms
      render :layout => "form_generator/public"
    end

    def calendar
      render :layout => "form_generator/public"
    end
  end
end