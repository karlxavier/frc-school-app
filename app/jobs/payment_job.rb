class PaymentJob < ApplicationJob
     queue_as :default
   
     def perform(students)
          PaymentMailer.reminder(students).deliver
     end
end
   