require 'json'
# require 'form_generator/scub_coral/scub_coral'
module FormGenerator
  class ApiController < ActionController::Base
    # before_filter :parse_json_data
    # before_filter :cors_preflight_check
    before_filter :spatial_distortion, :only => [:order, :organization, :field, :skin, :validation]
    before_filter :get_client_information
    # after_filter :cors_set_access_control_headers
    skip_before_filter :verify_authenticity_token
    # @received_data[key] = val.is_a?(String) ? JSON.parse(val,:symbolize_names => true) : val

    def order
      data = params[:data]
      data.each do |key, val|
        send "handle_#{key}",  JSON.parse(val, :symbolize_names => true)
      end

      render :json => { :error => false, :message => "Transfer was successful." }
    end

    def unpublish
      order_id = params[:order_id]
      order = Order.find_by_id order_id
      if order
        order.unpublish_all_versions
        render :json => { :error => false, :message => "Order was unpublished." }
      else
        render :json => { :error => true, :message => "Bad robots." }
      end
    end

    def delete
      order_id = params[:order_id]
      order = Order.find_by_id order_id
      if order
        order.soft_delete
        render :json => { :error => false, :message => "Order was deleted." }
      else
        render :json => { :error => true, :message => "Kill all humans!" }
      end
    end

    private
      def handle_order order_data
        order = Order.find_or_initialize_by_id order_data[:id]
        order.update_attributes order_data
      end

      def handle_version version_data
        version = OrderVersion.find_or_initialize_by_id version_data[:id]
        version.update_attributes version_data
      end

      def handle_skin skin_data
        skin = Skin.find_or_initialize_by_id skin_data[:id]
        skin.update_attributes skin_data
      end

      def handle_fields fields
        Field.destroy_all
        Field.create fields
      end

      def handle_organization organization_data
        organization = Organization.find_or_initialize_by_id organization_data[:id]
        organization.update_attributes organization_data
      end

      def handle_validations validations
        Validation.destroy_all
        Validation.create validations
      end

      def get_client_information
        @client_ip = request.remote_ip
        @client_browser = request.env['HTTP_USER_AGENT'].downcase
      end

      def spatial_distortion
        unless params["sender"] == ScubCoral.command_cluster_coralian && params["receiver"] == ScubCoral.humanoid_coralians
          render :json => { :error => true, :message => "Bad Trapars." }
        end
      end
  end
end