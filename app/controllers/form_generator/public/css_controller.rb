# encoding: UTF-8
module FormGenerator
  class Public::CssController < FrontendController
    layout false # This controller generates only css files
    caches_page :preview, :public

    def public
      @version = Order.where(:public_hash => params[:public_hash]).first.published_version
      render :public, :content_type => 'text/css'
    end
  end
end