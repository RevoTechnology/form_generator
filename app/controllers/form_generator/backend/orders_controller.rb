module FormGenerator
  class Backend::OrdersController < BackendController
    before_filter :find_order, :only =>  :preview
    before_filter :find_order_version, :only => :preview
    skip_before_filter :only_after_login!
    layout 'preview'

    private
      def find_order
        @order = Order.find params[:id]
      rescue ActiveRecord::RecordNotFound
        logger.error(I18n.t("flash.errors.security.no_rights"))
      end

      def find_order_version
        find_order unless @order
        @version = @order.order_versions.find params[:version_id]
      rescue ActiveRecord::RecordNotFound
        logger.error(I18n.t("flash.errors.security.no_rights"))
      end

  end
end