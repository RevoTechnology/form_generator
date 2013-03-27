# encoding: utf-8
require 'form_generator/yumi/yumi'
require 'form_generator/yumi/item_builder'
module FormGenerator
  class StepBuilder < Yumi
    attr_accessor :fields, :step_number

    def post_initialize
      @fields = objectize_fields
    end

    def all_fields_from_step
      fields_from_scenarios = @fields.map{|field|
        unless field.scenario_items.nil?
          field.scenario_items.map{|data|
            data.map{|value, fields|
              fields
            }
          }
        end
      }.compact.flatten

      fields_from_scenarios_2 = fields_from_scenarios.map{|field|
        unless field.scenario_items.nil?
          field.scenario_items.map{|data|
            data.map{|value, fields|
              fields
            }
          }
        end
      }.compact.flatten

      [@fields + fields_from_scenarios + fields_from_scenarios_2].flatten
    end

    def render url_params, params = {}
      field_set_tag content_tag(:span, @header) do
        (content_tag :p, :class => :required do
          content_tag(:span, "*", :class => :req) +
          "Обязательные поля"
        end) +
        (content_tag :ul do
          (@fields.map { |f| f.render params, url_params } ).join("\n").html_safe
        end)
      end
    end

    def header
      @header
    end

    def fields_element_ids
      @fields.map do |field|
        if field.scenario != {}
          field.scenario_items.map{|data| data.map{|value, fields| fields.map(&:element_id)} } + [field.element_id]
        else
          field.element_id
        end
      end
    end

    private
      def item_element_id index
        [@element_number[0], @element_number[1], index+1]
      end

      def objectize_fields
        @fields.each_with_index.map{|params, index| ItemBuilder.new(:data => params, :element_id => item_element_id(index), :step_number => @step_number) }
      end
  end
end