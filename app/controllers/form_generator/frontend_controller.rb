module FormGenerator
  class FrontendController < ApplicationController

    def forgot_password
    end

    def send_password
      @email = params[:email]

      @user = User.find_by_email(@email)
      if @user.nil?
        redirect_to forgot_password_path, :notice => I18n.t("flash.errors.validation.user.has_no_such_user")
      else
        @user.password = SecureRandom.urlsafe_base64(6)
        puts @user.password
        @user.save
        UserMailer.send_forgot_password(@user).deliver
        redirect_to root_path, :notice => I18n.t("flash.notices.users.new_password_sended")
      end
    end
  end
end