# encoding: UTF-8
class OrderMailer < ActionMailer::Base
  default from: "Администрация netsmarts.ru <admin@mail.netsmarts.ru>"

  def send_to_review(order, user)
    @order = order
    @user = user
    @link = review_publish_request_backend_order_url(@order)
    mail :to => @user.email, :subject => "Форма на рассмотрение"
  end

  def send_when_decline(order, user,comment)
    @order = order
    @user = user
    @comment = comment
    mail :to => @user.email, :subject => "Публикация отменена"
  end

  def send_when_published(order, user)
    @order = order
    @user = user
    mail :to => @user.email, :subject => "Форма опубликована"
  end

  def send_when_restored(order, user)
    @order = order
    @user = user
    mail :to => @user.email, :subject => "Форма восстановлена"
  end

  def send_when_destroyed(order, user)
    @order = order
    @user = user
    mail :to => @user.email, :subject => "Форма удалена"
  end


  def send_to_delete(order, user)
    @order = order
    @user = user
    mail :to => @user.email, :subject => "Удаление формы"
  end
end
