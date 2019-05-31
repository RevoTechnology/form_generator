# encoding: UTF-8
module FormGenerator
  class Public::JsController < FrontendController
    layout false # This controller generates only javascript files

    def public
      @version = Order.where(:public_hash => params[:public_hash]).first.published_version
      render :public, :content_type => 'text/javascript'
    end
  end
end
