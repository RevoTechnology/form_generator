# encoding: UTF-8
module FormGenerator
  class Public::FormsController < FrontendController
    def show
      @partner = Partner.find_by_name params[:partner].gsub(/(%20)/, ' ') if params[:partner]
      @product = Product.find_by_name params[:product].gsub(/(%20)/, ' ') if params[:product]

      order = Order.where(:public_hash => params[:public_hash]).first
      @version = order.published_version if order
      if @version
        if params[:partner].blank? &&  params[:product].blank?

          @url_params = get_url_params request.referer
          @url_params.merge!(params.reject{|key, value| key.to_s == 'organization_latin_name' || key.to_s == 'pablic_hash' })
          @url_params[:referer] ||= request.referer

          #bmsmall params
          set_params_for_bmsmall

          #TODO Remove this!
          o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten;
          random_string  =  (0..50).map{ o[rand(o.length)]  }.join;

          cookies[:visiter] = {
            :value => Digest::SHA1.hexdigest(request.ip.to_s + Time.now.nsec.to_s + random_string),
            :expires => 1.year.from_now
          }
          render :layout => "form_generator/public", :locals => { :params => params }
        elsif !@partner.nil? &&  !@product.nil?
          @product_relation = ProductRelation.where(:partner_id => @partner.id, :product_id => @product.id).first
          order = Order.find @product_relation.order_id

          if @product_relation && order.public_hash ==  params[:public_hash]
            @url_params = get_url_params request.referer
            @url_params.merge!(params.reject{|key, value| key.to_s == 'organization_latin_name' || key.to_s == 'pablic_hash' })
            @url_params[:referer] ||= request.referer

            #bmsmall params
            set_params_for_bmsmall

            #TODO Remove this!
            o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten;
            random_string  =  (0..50).map{ o[rand(o.length)]  }.join;

            cookies[:visiter] = {
              :value => Digest::SHA1.hexdigest(request.ip.to_s + Time.now.nsec.to_s + random_string),
              :expires => 1.year.from_now
            }
            render :layout => "form_generator/public", :locals => { :params => params }
          else
            render :text => I18n.t("flash.errors.security.no_rights")
          end
        else
          render :text => I18n.t("flash.errors.security.no_rights")
        end
      else
        render :text => ""
      end

    end

    def send_data
      data = JSON.parse(params[:data]).to_yaml.to_s
      # UserMailer.send_data_from_form("send.this.to.moff@gmail.com", data).deliver
      redirect_to root_url, :notice => I18n.t("flash.notices.data_sended")
    end

    def set_params_for_bmsmall 
      ref = {}
      ref['email']           = params['email'] if params['email']
      ref['second_name']     = params['user_last_name'] if params['user_last_name']
      ref['card_first_name'] = params['user_first_name'] if params['user_first_name']
      ref['mobile']          = params['phone_number_handler'] if params['phone_number_handler']
      ref['user_id']         = params['user_id'] if params['user_id']
      ref['IP']              = request.remote_ip
      ref['Application_id']  = Application.create.id

      datetime = Time.now 
      ref['application_date']= datetime.strftime("%d.%m.%Y")
      ref['application_time']= datetime.strftime("%H:%M")

      ref['utmcsr'] = params['utm_source']
      ref['utmcdm'] = params['utm_medium']
      ref['utmccn'] = params['utm_campaign']

      @url_params.merge!(ref)
    end

    def get_url_params referer
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
  end
end