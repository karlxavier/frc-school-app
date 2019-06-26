class FeeReminderMailer < ApplicationMailer
     default from: "school.transportation@fastuae.com"

     def payment_reminder(student_email, student_details, due_amount, fee_details)
          @student_details = student_details
          @due_amount = due_amount
          @fee_details = fee_details

          puts "************* sending email for #{ student_email }"
          mail(to: student_email, subject: "Transportation Payment Reminder")
  	end
end
