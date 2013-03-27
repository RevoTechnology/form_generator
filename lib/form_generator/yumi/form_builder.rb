require 'form_generator/yumi/yumi'
require 'form_generator/yumi/step_builder'
module FormGenerator
  class FormBuilder < Yumi
    attr_accessor :steps, :header

    def post_initialize
      @steps = objectize_steps
    end

    def render params = {}, url_params = {}
      content_tag :div do
        content_tag :form, :method => :post, :class => form_class do
          generate_skin_format(params, url_params)
        end
      end
    end

    def form_class
      @custom_css ? "custom_form" : "neatform #{@skin_type}"
    end

    def generate_skin_format params, url_params
      if @skin_type == "horizontal"
        generate_horizontal_form params, url_params
      else
        generate_vertical_form params, url_params
      end
    end

    def custom_html
      if @custom_html.present?
        @custom_html.join(' ').html_safe
      end
    end

    ####################
    ## form_rendering ##
    ####################
    def generate_horizontal_form params, url_params
      steps_list + generate_steps(params, url_params) + custom_html
    end

    def generate_vertical_form params, url_params
      if @steps.count > 1
        @steps.each_with_index.map{ |step, index|
          generate_step_header(step, index, :div, "step_title") + step.render(params, url_params)
        }.join("\n").html_safe + custom_html
      else
        generate_steps(params, url_params) + custom_html
      end
    end

    def generate_step_header step, index, tag_name, class_name = nil
      content_tag(tag_name, step.header, :data => { :step => index+1 }, :class => class_name)
    end

    def step_header_in_list step, index
      content_tag :li, generate_step_header(step, index, :span), :data => { :step => index+1 }, :class => "active"
    end

    def generate_steps params, url_params
      ( @steps.map { |s| s.render params, url_params } ).join("\n").html_safe
    end

    def steps_list
      if @steps.count == 1
        "".html_safe
      else
        content_tag :ul, :class => "steps" do
          @steps.each_with_index.map{ |step, index|
           step_header_in_list(step, index)
          }.join("\n").html_safe
        end
      end
    end

    def fields
      @steps.map(&:all_fields_from_step).flatten
    end

    def fields_element_ids
      @steps.each_with_index.map { |step, index|
        fields = step.fields.map { |field|
          if field.type == "group"
            sub_items = field.items.map { |f|
              { :tag => f.get_tag, :type => f.type, :parameter => f.parameter }
            }
          end

          if !field.scenario.empty?
            scenario_items = []
            field.scenario_items.each { |scenario|
              scenario.each { |key, fields|
                fields.each { |f|
                  if f.type == "group"
                    # puts "parsing group"
                    f.items.each { |j|
                      scenario_items.push( { :tag => j.get_tag, :type => j.type, :parameter => j.parameter } )
                    }
                  else
                    scenario_items.push( { :tag => f.get_tag, :type => f.type, :parameter => f.parameter } )
                  end
                }
              }
            }
            scenario_items.flatten!
          end

          field_description = { :tag => field.get_tag, :type => field.type, :parameter => field.parameter }
          field_description.merge!( { :items => sub_items } ) if sub_items
          field_description.merge!( { :items => scenario_items, :scenario => true } ) if scenario_items
          field_description
        }

        { :index => index, :fields => fields }
      }.to_json.html_safe
      # @steps.map(&:fields_element_ids).flatten.to_s.html_safe
    end

    private
      def step_element_id index
        [@element_number[0], index+1, 0]
      end

      def objectize_steps
        @steps.each_with_index.map{|params, index| StepBuilder.new :data => params, :element_id => step_element_id(index), :step_number => index+1 }
      end
  end
end