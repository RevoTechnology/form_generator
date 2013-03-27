# encoding: UTF-8
require 'form_generator/yumi/form_builder'
module FormGenerator
  module Cream
    attr_accessor :form, :form_data, :fields

    def form
      @form ||= FormBuilder.new :version => id, :data => body, :custom_css => !skin.custom_css.to_s.empty?, :skin_type => skin.flow
    end

    def already_loaded_data
      form_data["steps"].to_json.html_safe
    end

    def form_data
      @form_data ||= YAML.load(body)["form"]
    end

    def fields
      @fields ||= form.fields
    end

    def fields_element_ids
      form.fields_element_ids
    end

    ##############
    ## Api urls ##
    ##############
    def zip_code_data_finder
      # TODO: insert public_zip_code_data_path
      { :url => "" }.to_json.html_safe
    end

    def suggestion_data
      # TODO: insert public_suggestion_path(:parameter => ":parameter" )
      { :url => "" }.to_json.html_safe
    end

    #####################
    ## Json generators ##
    #####################
    def validations_json
      validations = form.fields.map{|field| field.validations_list}
      Hash[*validations.flatten.compact].to_json.html_safe
    end

    def skin_json
      skin.body.html_safe
    end

    def scenarios_json
      Hash[scenarios_generator].to_json.html_safe
    end

    def scenarios_generator
      form.fields.map{ |field|
        unless field.scenario.empty?
          [field.element_id, field.scenario_hash]
        end
      }.compact
    end
  end
end