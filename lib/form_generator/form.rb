module FormGenerator
  class Form
    attr_reader :version, :public_hash

    def initialize options={}
      @version = options[:version]
      @params = options[:params]
      @public_hash = @params[:public_hash]
    end

    def init_params request, params
      @url_params = get_full_params_from request, params
      set_params_for_bmsmall params, request #bmsmall params
    end

    def render
      @version.form.render @params, @url_params
    end

    def js_path
      JsRenderer.path_for @version, @public_hash
    end

    def css_path
      CssRenderer.path_for @version, @public_hash
    end

    private
      def get_full_params_from request, params
        url_params = get_url_params request.referer, params
        url_params.merge!(params.reject{|key, value| key.to_s == 'organization_latin_name' || key.to_s == 'pablic_hash' })
        url_params[:referer] ||= request.referer
        url_params
      end

      def get_url_params referer, params
        result = {}
        if referer
          params = referer.split('?')[1]
          if params && params.length > 0
            pairs = params.split('&')
            pairs.each do |val|
              value = val.split('=')
              result[value[0]] = value[1]
            end
          end
        end
        result
      end

      def set_params_for_bmsmall params, request
        ref = {}
        ref['email']           = params['email'] if params['email']
        ref['second_name']     = params['user_last_name'] if params['user_last_name']
        ref['card_first_name'] = params['user_first_name'] if params['user_first_name']
        ref['mobile']          = params['phone_number_handler'] if params['phone_number_handler']
        ref['user_id']         = params['user_id'] if params['user_id']
        ref['IP']              = request.remote_ip

        datetime = Time.now
        ref['application_date']= datetime.strftime("%d.%m.%Y")
        ref['application_time']= datetime.strftime("%H:%M")

        ref['utmcsr'] = params['utm_source']
        ref['utmcdm'] = params['utm_medium']
        ref['utmccn'] = params['utm_campaign']

        @url_params.merge!(ref)
      end
  end
end