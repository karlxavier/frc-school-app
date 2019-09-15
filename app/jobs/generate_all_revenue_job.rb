class GenerateAllRevenueJob < ApplicationJob
  queue_as :default

  def perform(_from_date, _to_date)
    from_date = DateTime.parse(_from_date) # FROM DATE
    to_date = DateTime.parse(_to_date) # TO DATE

    puts '******** PROCESSING *******'
    Student.where(is_active: true).each do |student|
      puts "---- Student: #{student.code}" 

      date = from_date
      hash = { }
      fee_balance = 0
      fee = Fee.where(student_id: student.code).last
      rate = student.rate.to_f

      if fee.present? && rate > 1 # This will not allow if student rate is not properly defined.
        fee_balance_amount = fee.balance_amount.to_f

        while (date <= to_date)
          unless date.strftime("%B") == "July" || date.strftime("%B") == "August" # Exclude months of July and August!
            unless FeeDetail.is_valid_fee_date(fee.student_id, date.strftime("%Y-%m-%d")).present?
              hash[date.strftime("%Y-%m-%d")] = 0
              puts fee.student_id
              fee_details = fee.fee_details.create!(fee_date: date.strftime("%Y-%m-%d"), 
                                                    description: "Transportation Fee for #{date.strftime('%B')}-#{date.strftime('%Y')} ", 
                                                    student_id: fee.student_id, 
                                                    balance_amount: rate, 
                                                    amount: rate)

              fee_balance = fee_balance + rate
            end
          end

          date = date.advance(months: 1)
        end

        # if fee_details.errors.any?
        #   puts '******* ERRORS ********'
        #   fee_details.errors.full_messages.each do |message|
        #       puts message
        #   end
        # end

        if fee_balance_amount < 0
          Fee.update_student_balance(fee.id, fee_balance_amount * -1, Time.now.strftime("%Y-%m-%d").to_s)
        end

        fee.update_attributes(balance_amount: fee_balance.to_f + fee_balance_amount)
        puts '-------- Successfully generated ------'
      end  
    end

  end
end
