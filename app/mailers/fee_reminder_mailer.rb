class FeeReminderMailer < ApplicationMailer
     default from: "school.transportation@fastuae.com"

     def payment_reminder(student_email, student_details, due_amount, fee_details)
          # students =  JSON.parse(selected_fees)

          # students.each do |student|
          #      @student_details = [student['id'], student['student']['name']].join(' - ')
          #      @due_amount = student['balance_amount']
          #      @fee_details = student['fee_details']

          #      puts "************* sending email for #{ @student_details }"
          #      mail(to: student['student']['father_email'], subject: "Transportation Payment Reminder")
          # end

          @student_details = student_details
          @due_amount = due_amount
          @fee_details = fee_details

          puts "************* sending email for #{ student_email }"
          mail(to: student_email, subject: "Transportation Payment Reminder")
  	end
end
