# encoding: UTF-8
class UserMailer < ActionMailer::Base
  default from: "Администрация netsmarts.ru <admin@mail.netsmarts.ru>"

  def send_password(user)
    @user = user
    headers 'X-Mailer' => 'Rails Mailer', 'User-Agent' => 'Rails Application', "Reply-to" => "admin@mail.netsmarts.ru"
    mail :to => user.email, :recipients => "#{user.email}", :from => "Администрация netsmarts.ru <admin@mail.netsmarts.ru>", :subject => "Пароль пользователя для доступа к netsmarts.ru"
  end

  def send_demo_password(user)
    @user = user
    mail :to => user.email, :subject => "Password"
  end

  def send_demo_request(email, demo_user )
    @demo_user = demo_user
    mail :to => email, :subject => "Запрос demo доступа для входа в систему"
  end

  def send_forgot_password(user)
    @user = user
    mail :to => user.email, :subject => "Password"
  end

  def send_data_from_form email, data
    @data = data
    mail :to => email, :subject => "Данные"
  end
end
