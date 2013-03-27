# encoding: UTF-8
require 'form_generator/yumi/yumi'
module FormGenerator
  class ItemBuilder < Yumi
    attr_accessor :element_id, :scenario_items, :validations, :scenario, :type, :items, :values, :header, :scenario_items, :parameter, :attributes, :step_number

    def get_tag
      @tag
    end

    def post_initialize
      items_preload if @id
      @type ||= "item"
      @label ||= ""
      @text ||= ""
      @value ||= ""
      @placeholder ||= ""
      @width ||= "normal"
      @height ||= "normal"
      @hint ||= {}
      @hint["text"] ||= ""
      @hint["style"] ||= "inline"
      @hint["style"] = "block" if @from_group || @type == "group" || @tag == "textarea"
      @values ||= []
      @values = [""] + @values if @tag == "select" && (@allow_blank == true || @allow_blank == "true" || @allow_blank.nil?)

      @attributes ||= {}
      @attributes["class"] ||= ""

      @default_value ||= (@tag == "select") ? 1 : ""
      if (@tag == "checkbox")
        @default_value = (@default_value == true || @default_value == 'true') ? true : false
      end
      @validations ||= {}
      @scenario ||= {}
      @limit ||= ""
      @template ||= ""
      @element_id = @parameter if @parameter.present?

      identify_group_items @items if @type == "group"
      identify_scenario_items @scenario if @scenario != {}

      @validations = validations_dog
    end

    def items_preload
      field = Field.find(@id)
      attributes = YAML::load(field.body)
      attributes.each do |k,v|
        unless instance_variable_get "@#{k}"
          instance_variable_set("@#{k}", v)
        end
      end
    end

    def items_afterload url_params
      url_params.each do |k,v|
        unless instance_variable_get "@#{k}"
          instance_variable_set("@#{k}", v)
        end
      end
    end

    def scenario_hash
      scenarios = {}
      scenario_items.map do |data|
        data.map do |value, fields|
          scenarios[value] = fields.map{|f|
            f.type == "group" ? f.items.map(&:element_id) : f.type == "radio" ? f.values.each_with_index.map{|value, index| "#{f.element_id}"  } : f.element_id
          }.flatten.compact.uniq
        end
      end
      scenarios
    end

    def validations_dog
      @validations.map do |validation|
        if validation["id"].nil?
          validation
        else
          original_validation = Validation.find(validation["id"])
          {
            "message" =>
            validation["message"] || original_validation.default_error_message,
            "regexp" =>
            validation["regexp"] || original_validation.regexp,
            "short_message" =>
            validation["short_message"]
          }
        end
      end
    end



    def render params = {}, url_params = {}
      @params = params
      items_afterload url_params

      case @tag
        when "string"
          render_string
        when "hidden"
          render_hidden + render_scenario
        when "announce"
          render_announce
        when "separator"
          render_separator
        when "password"
          render_password
        when "checkbox"
          render_checkbox + render_scenario
        when "textarea"
          render_textarea
        when "datepicker"
          render_datepicker
        when "select"
          render_select + render_scenario
        when "radio"
          render_radio + render_scenario
        else
          render_group if @type == "group"
      end
    end

    def validations_list
      if @type == "group"
        @items.map(&:validations_list)
      elsif @scenario != {}
        @scenario_items.map{|data| data.map{|value, fields| fields.map(&:validations_list)} }
      elsif @tag == "radio"
        nil
      else
        if @validations == {}
          nil
        else
          validations = @validations.map{|validation| {:message => validation["message"], :short_message => validation["short_message"], :regexp => validation["regexp"]} }
          [ @element_id, { :type => @tag, :validations => validations } ]
        end
      end
    end

    def element_tag
      @tag
    end

    def label_data
      @label
    end

    private
      def render_group
        first_element_parameter = @items.first.parameter
        content_tag :li, :class => [@element_id, "group", "field_#{first_element_parameter}"] do
          content_tag(:strong, [@header, @required ? "<span class='req'>*</span>" : ""].join.html_safe ) + content_tag(:span, "", { :class => :hover_error, :id => "#{@element_id}_hover_error" }) +
          content_tag(:ul, @items.map(&:render).join("\n").html_safe, :class => "group") +
          hint
        end
      end

      def render_scenario
        @scenario != {} ? @scenario_items.map{|data| data.map{|value, fields| fields.map(&:render)} }.join("\n").html_safe : ""
      end

      def render_string
        @attributes["class"] = [@attributes["class"], "field", "string", "field_#{@parameter}"].join(" ")
        content_tag :li, @attributes do
          label + text_field_tag_build + hint
        end
      end

      def text_field_tag_build
        data = {}
        data[:group] = group_id if @from_group
        data[:limit] = @limit if @limit.present?
        data[:template] = @template if @template.present?
        data[:parameter] = @parameter if @parameter.present?
        data[:keyboard] = @keyboard if @keyboard.present?
        data[:suggest] = @suggest if @suggest.present?
        data[:dependent] = @dependent if @dependent.present?
        data[:step] = @step_number
        data[:label] = @label
        @default_value = @params[@parameter] if @params.has_key? @parameter

        content_tag :span, :class => "field text" do
          content_tag :span, :class => :outer do
            content_tag :span, :class => :inner do
              text_field_custom_type_tag_build data
            end
          end
        end
      end

      def text_field_custom_type_tag_build data
        @attributes["class"] = [@attributes["class"], @width].join(" ")

        if @type.nil?
          text_field_tag(@element_id, @default_value, {:placeholder => placeholder, :data => data, :maxlength => (@maxlength if @maxlength.present?)}.merge(@attributes))
        else
          @type = "text" if @type == "item"
          text_field_tag(@element_id, @default_value, {:placeholder => placeholder, :data => data, :maxlength => (@maxlength if @maxlength.present?)}.merge(@attributes)).to_s.sub('type="text"', "type=\"#{@type}\"").html_safe
        end
      end

      def render_hidden
        hidden_field_tag_build
      end

      def hidden_field_tag_build
        data = {}
        data[:parameter] = @parameter if @parameter.present?
        data[:step] = @step_number
        @default_value = nil
        @default_value = @params[@parameter] if @params.has_key? @parameter
        @default_value ||= "WEB" if @parameter == "channel"
        # @default_value ||= @params[:referer] if @parameter == "Partner"

        hidden_field_tag @element_id, @default_value, {:data => data}.merge(@attributes)
      end

      def render_announce
        content_tag :li, :class => "announce_block field_#{@parameter}" do
          content_tag :p, :class => "announce" do
            @text
          end
        end
      end

      def render_separator
        # content_tag :li do
        content_tag :hr
        # end
      end

      def render_password
        content_tag :li, :class => "password field_#{@parameter}" do
          label + password_tag_build + hint
        end
      end

      def password_tag_build
        data = {}
        data[:parameter] = @parameter if @parameter.present?
        data[:group] = group_id if @from_group
        data[:step] = @step_number
        content_tag :span, :class => :field do
          password_field_tag(@element_id, "", :placeholder => placeholder, :class => @width, :data => data)
        end
      end

      def render_checkbox
        content_tag :li, :class => [:checkbox, (@parameter != "" ? "element_#{@parameter}" : nil ), "field_#{@parameter}"] do
          check_box_tag_build + hint

          # content_tag(:span, "", { :class => :hover_error, :id => "#{@element_id}_hover_error" }) +
          # hint
        end
      end

      def check_box_tag_build
        data = {}
        data[:parameter] = @parameter if @parameter.present?
        data[:group] = group_id if @from_group
        data[:step] = @step_number
        @default_value = ((@params[@parameter] == true || @params[@parameter] == 'true') ? true : false) if @params.has_key? @parameter

        label_tag @element_id do
            check_box_tag(@element_id, "", @default_value, {:data => data}.merge(@attributes)) + @label
        end
        # end

        # if @tooltip.present?
        #   check_box_tag(@element_id, "", @default_value, :data => data) # + content_tag(:span, "?", { :class => "tooltip", "data-tooltip" => @tooltip}) + @label
        # else
        #   check_box_tag(@element_id, "", @default_value, :data => data) # + @label
        # end
      end

      def render_button
        content_tag :li do
          submit_tag @text
        end
      end

      def render_textarea
        content_tag :li, :class => [:textarea, "field_#{@parameter}"] do
          label + text_area_tag_build + hint
        end
      end

      def text_area_tag_build
        data = {}
        data[:parameter] = @parameter if @parameter.present?
        data[:group] = group_id if @from_group
        data[:limit] = @limit if @limit.present?
        data[:step] = @step_number
        @default_value = @params[@parameter] if @params.has_key? @parameter
        @attributes["class"] = [@attributes["class"], @height].join(" ")

        text_area_tag(@element_id, @default_value, {:placeholder => placeholder, :data => data}.merge(@attributes) )
      end

      def render_select
        content_tag :li, :class => ["select", "field_#{@parameter}"] do
          label + select_tag_build + hint
        end
      end

      def render_datepicker
        content_tag :li, :class => ["datepicker", "field_#{@parameter}"] do
          label + datepicker_tag_build + content_tag(:span, "", :class => :message, :id => "#{@element_id}-hint")
        end
      end

      def datepicker_tag_build
        data = {}
        data[:template] = @template if @template.present?
        data[:parameter] = @parameter if @parameter.present?
        data[:step] = @step_number
        @default_value = @params[@parameter] if @params.has_key? @parameter
        @attributes["class"] = [@attributes["class"], "calendar normal"].join(" ")

        content_tag :span, :class => "field text" do
          content_tag :span, :class => :outer do
            content_tag :span, :class => :inner do
              text_field_tag(@element_id, @default_value, {:placeholder => "ДД.ММ.ГГГГ", :data => data}.merge(@attributes))
            end
          end
        end
      end

      def render_radio
        data = {}
        data[:parameter] = @parameter if @parameter.present?
        data[:group] = @element_id
        data[:step] = @step_number
        @default_value = @params[@parameter] if @params.has_key? @parameter

        content_tag :li, :class => ["inline", @element_id, "field_#{@parameter}"] do
          content_tag(:strong, [@label, @required ? "<span class='req'>*</span>" : ""].join.html_safe) + content_tag(:span, "", { :class => :hover_error, :id => "#{@element_id}_hover_error" }) +
          (content_tag :span, :class => "field radio" do
            @values.each_with_index.map{|value, index|
              content_tag :span, :class => "radio-input" do
                content_tag(:span, "", :class => :bullet, :id => "#{@element_id}_#{index+1}_bullet") +
                radio_button_tag(@element_id, value, value == @default_value, {:id => "#{@element_id}_#{index+1}", :data => data}.merge(@attributes)) +
                label_tag("#{@element_id}_#{index+1}", value)
              end
            }.join("\n").html_safe
          end) +
          hint
        end
      end

      def select_tag_build
        data = {}
        data[:parameter] = @parameter if @parameter.present?
        data[:group] = group_id if @from_group
        data[:label] = @label
        data[:select] = @select
        data[:dependent] = @dependent
        data[:step] = @step_number
        if @from_group
          # select_tag(@element_id, @values.each_with_index.map{|value, index| content_tag :option, value, :value => index == 0 ? "-1" : nil }.join("\n").html_safe, :data => data )
          content_tag :span, :class => "field select" do
            content_tag :span, :class => "outer" do
              content_tag :span, :class => "inner" do
                select_tag(@element_id, @values.each_with_index.map{|value, index| content_tag :option, value, :value => (index == 0 && (@allow_blank == true || @allow_blank == "true" || @allow_blank.nil?)) ? "-1" : nil }.join("\n").html_safe, :data => data)
              end
            end
          end
        else
          content_tag :span, :class => "field select" do
            content_tag :span, :class => "outer" do
              content_tag :span, :class => "inner" do
                select_tag(@element_id, @values.each_with_index.map{|value, index| content_tag :option, value, :value => (index == 0 && (@allow_blank == true || @allow_blank == "true" || @allow_blank.nil?)) ? "-1" : nil }.join("\n").html_safe, :data => data)
              end
            end
          end
        end
      end

      def hint
        content_tag :span, :id => "#{@element_id}-hint", :class => "#{@type == "group" ? 'clear' : ''} message hint #{@hint["style"]}" do
          @hint["text"].html_safe
          # content_tag :span, @hint["text"].html_safe
        end
      end

      def label
        if @from_group
          "".html_safe
        else
          label_tag(@element_id, [@label, @required ? "<span class='req'>*</span>" : ""].join.html_safe) +
          content_tag(:span, "", { :class => :hover_error, :id => "#{@element_id}_hover_error" }) +
          (content_tag(:span, "", { :id => "#{element_id}_hover_tooltip", :class => "tooltip", "data-tooltip" => @tooltip}) if @tooltip.present? )
        end
      end

      def placeholder
        @from_group ? @label : @placeholder
      end

      def identify_group_items items
        @items = items.each_with_index.map{|item, index| ItemBuilder.new(:data => item.merge({:from_group => true, :group_name => @element_id}), :element_id => [@element_id, index+1].join("_"), :step_number => @step_number) }
      end

      def identify_scenario_items scenario
        @scenario_items = scenario.each_with_index.map{ |s, index|
          value_elements = {}
          value_elements[s[0]] = s[1].each_with_index.map do |field, index2|
            ItemBuilder.new(:data => field, :element_id => [@element_id, index+1, index2+1].join("_"), :step_number => @step_number)
          end
          value_elements
        }
      end

      def group_id
        # @element_id.split("_")[0..-2].join("_")
        @group_name
      end
  end
end