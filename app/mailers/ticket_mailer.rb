class TicketMailer < ApplicationMailer

  def purchase_email(current_user)
    @user = current_user

    mail(to: @user.email, subject: 'Thank you for the purchase at Diversecity')
  end
end
