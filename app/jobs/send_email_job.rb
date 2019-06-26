class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(selected_fees)
    # @selected_fees = selected_fees

    students =  JSON.parse(selected_fees)

    students.each do |student|
          @student_email = student['student']['father_email']
          @student_details = [student['id'], student['student']['name']].join(' - ')
          @due_amount = student['balance_amount']
          @fee_details = student['fee_details']

          fee_id = student['id'].to_s

          fee = Fee.find(fee_id)
          fee.update_attributes(last_notified: Time.now)
          FeeReminderMailer.payment_reminder(@student_email, @student_details, @due_amount, @fee_details).deliver_later
    end
  end
end
