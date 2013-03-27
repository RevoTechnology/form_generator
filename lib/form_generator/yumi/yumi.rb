module FormGenerator
  class Yumi
    include ActionView::Context
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::FormTagHelper
    #include ActionDispatch::Routing
    #include Rails.application.routes.url_helpers

    def initialize options={}
      identify_element options and assign_params options[:data] and post_initialize
    end

    private
      def identify_element options
        @element_number = options[:version] ? [options[:version],0,0] : options[:element_id]
        @step_number = options[:step_number] if options[:step_number]
        @custom_css ||= options[:custom_css]
        @skin_type ||= options[:skin_type]

        if @element_number.include? "object"
          @element_id = @element_number
        else
          @element_id = ["object", @element_number].join('_')
        end
      end

      def assign_params data
        raw_params = data.is_a?(Hash) ? data : YAML::load(data)["form"]
        raw_params.each{|k,v| instance_variable_set("@#{k}",v) }
      end
  end
end