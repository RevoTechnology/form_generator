module FormGenerator
  class BackendController < ApplicationController
    before_filter :only_after_login!


    private
      def only_after_login!
        redirect_to root_url, :notice => I18n.t('errors.messages.no_access') unless user_signed_in?
      end

      def set_flash_error_for object
        flash.now[:error] = object.errors.messages.count == 1 ? I18n.t("flash.errors.validations.one") : I18n.t("flash.errors.validations.many")
      end

      def current_organization
        current_user.organization
      end

      ##################
      # BEFORE FILTERS #
      ##################

      # TODO: отрефакторить так, чтоб потом и index можно было на этом завязать
      def find_categories
        @categories = Category.available_for(current_organization).map{|c| [c.name, c.id]}.uniq
      end

      def find_organizations
        @organizations = Organization.all.map{|o| [o.name, o.id]}
      end

      def find_skins
        @skins = Skin.available_for(current_organization).map{|s| [s.title, s.id]}
      end

      def find_fields
        @fields = Field.available_for(current_organization)
      end

      def find_validations
        @validations = Validation.available_for(current_organization)
      end

      def find_user
        @user = current_user
      end

  end
end