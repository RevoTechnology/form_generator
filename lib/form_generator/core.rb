module FormGenerator
  class Core
    attr_reader :form

    def initialize options={}
      @params = options[:params]
      @request = options[:request]

      @form = init_form_with @params[:public_hash], @params
      @form.init_params @request, @params if @form
    end

    private
      def init_form_with public_hash, params
        order = Order.where(:public_hash => public_hash).first
        version = order.published_version if order
        Form.new(:version => version, :params => params) if order && version
      end
  end
end
