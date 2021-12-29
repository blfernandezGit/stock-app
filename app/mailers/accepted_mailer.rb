class AcceptedMailer < ApplicationMailer

    def send_acceptance_email(user)
        @user = user
        mail to: @user.email, subject: "Registration to Stock Overflow has been Accepted", from: "stockoverflowmailer@gmail.com"
    end

end
