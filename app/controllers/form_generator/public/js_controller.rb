# encoding: UTF-8
module FormGenerator
  class Public::JsController < FrontendController
    layout false # This controller generates only javascript files
    #before_filter :only_after_login!, :only => [:preview]
    caches_page :preview, :public

    def preview
      @order = Order.find params[:id]
      @version = @order.order_versions.find params[:version_id]
      render :preview, :content_type => 'text/javascript'
    end

    def public
      @version = Order.where(:public_hash => params[:public_hash]).first.published_version
      render :public, :content_type => 'text/javascript'
    end

    private
      def only_after_login!
        redirect_to root_url, :notice => I18n.t('errors.messages.no_access') unless user_signed_in?
      end
  end
end