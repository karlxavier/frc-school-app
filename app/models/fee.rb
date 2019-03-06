class Fee < ApplicationRecord
    has_many :fee_details
    has_many :receipts
    belongs_to :school_year

    scope :student_fees, -> (fee_id) { includes(:fee_details).where(id: fee_id).order("fee_details.fee_date ASC") }

    require 'csv'
    require 'date'

    def self.import_2019(file)
        spreadsheet= open_spreadsheet(file)
        spreadsheet.default_sheet = spreadsheet.sheets[0]

        # FeeDetail.destroy_all
        # Fee.destroy_all
        # Receipt.destroy_all
        # ReceiptDetail.destroy_all
        
        headers = Hash.new
        spreadsheet.row(1).each_with_index {|header,i|headers[header] = i}
        ((spreadsheet.first_row + 1)..spreadsheet.last_row).each do |row|
            
            student_id = spreadsheet.row(row)[headers['Code']]
            re_apr_18 = spreadsheet.row(row)[headers['REAPRIL18']]
            re_may_18 = spreadsheet.row(row)[headers['REMAY18']]
            re_jun_18 = spreadsheet.row(row)[headers['REJUN18']]
            re_sep_18 = spreadsheet.row(row)[headers['RESEP18']]
            re_oct_18 = spreadsheet.row(row)[headers['REOCT18']]
            re_nov_18 = spreadsheet.row(row)[headers['RENOV18']]
            re_dec_18 = spreadsheet.row(row)[headers['REDEC18']]
            re_jan_19 = spreadsheet.row(row)[headers['REJAN19']]
            re_feb_19 = spreadsheet.row(row)[headers['REFEB19']]
            re_mar_19 = spreadsheet.row(row)[headers['REMAR19']]
            total_re = spreadsheet.row(row)[headers['TOTAL RE']]

            col_apr_18 = spreadsheet.row(row)[headers['COLAPR18']]
            col_may_18 = spreadsheet.row(row)[headers['COLMAY18']]
            col_jun_18 = spreadsheet.row(row)[headers['COLJUN18']]
            col_jul_18 = spreadsheet.row(row)[headers['COLJUL18']]
            col_aug_18 = spreadsheet.row(row)[headers['COLAUG18']]
            col_sep_18 = spreadsheet.row(row)[headers['COLSEP18']]
            col_oct_18 = spreadsheet.row(row)[headers['COLOCT18']]
            col_nov_18 = spreadsheet.row(row)[headers['COLNOV18']]
            col_dec_18 = spreadsheet.row(row)[headers['COLDEC18']]
            col_jan_19 = spreadsheet.row(row)[headers['COLJAN19']]
            col_feb_19 = spreadsheet.row(row)[headers['COLFEB19']]
            total_col = spreadsheet.row(row)[headers['TOTAL COL']]
            total_bal = spreadsheet.row(row)[headers['TOTAL BAL']]

            total_amount = total_re.present? ? total_re.to_f : 0
            paid_amount = total_col.present? ? total_col.to_f : 0
            balance_amount = total_bal.present? ? total_bal.to_f : 0

            fee = Fee.where(student_id: student_id).first
            advance_amt = 0
            unless fee.present?
                fee = Fee.new
                fee.student_id = student_id
                fee.total_amount = total_amount
                fee.paid_amount = paid_amount
                fee.balance_amount = balance_amount
                fee.school_year_id = 2
                fee.save!
            else
                fee_total_amount = fee.total_amount.present? ? fee.total_amount : 0
                fee_paid_amount = fee.paid_amount.present? ? fee.paid_amount : 0
                fee_balance_amount = fee.balance_amount.present? ? fee.balance_amount : 0

                advance_amt = fee_balance_amount

                fee.update_attributes(total_amount: total_amount + fee_total_amount, 
                    paid_amount: paid_amount + fee_paid_amount, 
                    balance_amount: balance_amount + fee_balance_amount
                )
            end

            if re_apr_18.present?
                unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for April-2018").present?
                    fee.fee_details.create!(fee_date: '2018-04-01', description: 'Transportation Fee for April-2018', student_id: student_id, balance_amount: re_apr_18, amount: re_apr_18)
                end
            end
            if re_may_18.present?
                unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for May-2018").present?
                    fee.fee_details.create!(fee_date: '2018-05-01', description: 'Transportation Fee for May-2018', student_id: student_id, balance_amount: re_may_18, amount: re_may_18)
                end
            end
            if re_jun_18.present?
                unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for June-2018").present?
                    fee.fee_details.create!(fee_date: '2018-06-01', description: 'Transportation Fee for June-2018', student_id: student_id, balance_amount: re_jun_18, amount: re_jun_18)
                end
            end
            if re_sep_18.present?
                unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for September-2018").present?
                    fee.fee_details.create!(fee_date: '2018-09-01', description: 'Transportation Fee for September-2018', student_id: student_id, balance_amount: re_sep_18, amount: re_sep_18)
                end
            end
            if re_oct_18.present?
                unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for October-2018").present?
                    fee.fee_details.create!(fee_date: '2018-10-01', description: 'Transportation Fee for October-2018', student_id: student_id, balance_amount: re_oct_18, amount: re_oct_18)
                end
            end
            if re_nov_18.present?
                unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for November-2018").present?
                    fee.fee_details.create!(fee_date: '2018-11-01', description: 'Transportation Fee for November-2018', student_id: student_id, balance_amount: re_nov_18, amount: re_nov_18)
                end
            end
            if re_dec_18.present?
                unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for December-2018").present?
                    fee.fee_details.create!(fee_date: '2018-12-01', description: 'Transportation Fee for December-2018', student_id: student_id, balance_amount: re_dec_18, amount: re_dec_18)
                end
            end
            if re_jan_19.present?
                unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for January-2019").present?
                    fee.fee_details.create!(fee_date: '2019-01-01', description: 'Transportation Fee for January-2019', student_id: student_id, balance_amount: re_jan_19, amount: re_jan_19)
                end
            end
            if re_feb_19.present?
                unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for February-2019").present?
                    fee.fee_details.create!(fee_date: '2019-02-01', description: 'Transportation Fee for February-2019', student_id: student_id, balance_amount: re_feb_19, amount: re_feb_19)
                end
            end
            if re_mar_19.present?
                unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for March-2019").present?
                    fee.fee_details.create!(fee_date: '2019-03-01', description: 'Transportation Fee for March-2019', student_id: student_id, balance_amount: re_mar_19, amount: re_mar_19)
                end
            end

            if advance_amt < 0
                update_balance_2019(fee.id, advance_amt * -1, "2019-03-06")
            end

            if col_apr_18.present?
                update_balance_2019(fee.id, col_apr_18, "2018-04-01")
            end
            if col_may_18.present?
                update_balance_2019(fee.id, col_may_18, "2018-05-01")
            end
            if col_jun_18.present?
                update_balance_2019(fee.id, col_jun_18, "2018-06-01")
            end
            if col_jul_18.present?
                update_balance_2019(fee.id, col_jul_18, "2018-07-01")
            end
            if col_aug_18.present?
                update_balance_2019(fee.id, col_aug_18, "2018-08-01")
            end
            if col_sep_18.present?
                update_balance_2019(fee.id, col_sep_18, "2018-09-01")
            end
            if col_oct_18.present?
                update_balance_2019(fee.id, col_oct_18, "2018-10-01")
            end
            if col_nov_18.present?
                update_balance_2019(fee.id, col_nov_18, "2018-11-01")
            end
            if col_dec_18.present?
                update_balance_2019(fee.id, col_dec_18, "2018-12-01")
            end
            if col_jan_19.present?
                update_balance_2019(fee.id, col_jan_19, "2019-01-01")
            end
            if col_feb_19.present?
                update_balance_2019(fee.id, col_feb_19, "2019-02-01")
            end

            puts "************************************************************************"
            puts "************************************************************************"
            puts "********************* FINISH NA! ***************************************"
            puts "************************************************************************"
            puts "************************************************************************"

        end
    end

    def self.import_2016(file)
        spreadsheet= open_spreadsheet(file)
        spreadsheet.default_sheet = spreadsheet.sheets[0]

          FeeDetail.destroy_all
          Fee.destroy_all
          Receipt.destroy_all
          ReceiptDetail.destroy_all
      
      headers = Hash.new
      spreadsheet.row(1).each_with_index {|header,i|headers[header] = i}
      ((spreadsheet.first_row + 1)..spreadsheet.last_row).each do |row|
        
          student_id = spreadsheet.row(row)[headers['Code']]
          re_sep_16 = spreadsheet.row(row)[headers['RESEP16']]
          re_oct_16 = spreadsheet.row(row)[headers['REOCT16']]
          re_nov_16 = spreadsheet.row(row)[headers['RENOV16']]
          re_dec_16 = spreadsheet.row(row)[headers['REDEC16']]
          re_jan_17 = spreadsheet.row(row)[headers['REJAN17']]
          re_feb_17 = spreadsheet.row(row)[headers['REFEB17']]
          re_mar_17 = spreadsheet.row(row)[headers['REMAR17']]
          re_apr_17 = spreadsheet.row(row)[headers['REAPR17']]
          re_may_17 = spreadsheet.row(row)[headers['REMAY17']]
          re_jun_17 = spreadsheet.row(row)[headers['REJUN17']]
          re_sep_17 = spreadsheet.row(row)[headers['RESEP17']]
          re_oct_17 = spreadsheet.row(row)[headers['REOCT17']]
          re_nov_17 = spreadsheet.row(row)[headers['RENOV17']]
          re_dec_17 = spreadsheet.row(row)[headers['REDEC17']]
          re_jan_18 = spreadsheet.row(row)[headers['REJAN18']]
          re_feb_18 = spreadsheet.row(row)[headers['REFEB18']]
          re_mar_18 = spreadsheet.row(row)[headers['REMAR18']]
          total_re = spreadsheet.row(row)[headers['TOTAL RE']]

          col_aug_16 = spreadsheet.row(row)[headers['COLAUG16']]
          col_sep_16 = spreadsheet.row(row)[headers['COLSEP16']]
          col_oct_16 = spreadsheet.row(row)[headers['COLOCT16']]
          col_nov_16 = spreadsheet.row(row)[headers['COLNOV16']]
          col_dec_16 = spreadsheet.row(row)[headers['COLDEC16']]
          col_jan_17 = spreadsheet.row(row)[headers['COLJAN17']]
          col_feb_17 = spreadsheet.row(row)[headers['COLFEB17']]
          col_mar_17 = spreadsheet.row(row)[headers['COLMAR17']]
          col_apr_17 = spreadsheet.row(row)[headers['COLAPR17']]
          col_may_17 = spreadsheet.row(row)[headers['COLMAY17']]
          col_jun_17 = spreadsheet.row(row)[headers['COLJUN17']]
          col_jul_17 = spreadsheet.row(row)[headers['COLJUL17']]
          col_aug_17 = spreadsheet.row(row)[headers['COLAUG17']]
          col_sep_17 = spreadsheet.row(row)[headers['COLSEP17']]
          col_oct_17 = spreadsheet.row(row)[headers['COLOCT17']]
          col_nov_17 = spreadsheet.row(row)[headers['COLNOV17']]
          col_dec_17 = spreadsheet.row(row)[headers['COLDEC17']]
          col_jan_18 = spreadsheet.row(row)[headers['COLJAN18']]
          col_feb_18 = spreadsheet.row(row)[headers['COLFEB18']]
          col_mar_18 = spreadsheet.row(row)[headers['COLMAR18']]
          total_col = spreadsheet.row(row)[headers['TOTAL COL']]

          total_bal = spreadsheet.row(row)[headers['TOTAL BAL']]
          
        fee = Fee.new
        fee.student_id = student_id
        fee.total_amount = total_re.present? ? total_re.to_f : 0
        fee.paid_amount = total_col.present? ? total_col.to_f : 0
        fee.balance_amount = total_bal.present? ? total_bal.to_f : 0
        fee.school_year_id = 1
        fee.save!

        if re_sep_16.present?
            unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for September-2016").present?
                fee.fee_details.create!(fee_date: '2016-09-01', description: 'Transportation Fee for September-2016', student_id: student_id, balance_amount: re_sep_16, amount: re_sep_16)
            end
        end
        if re_oct_16.present?
            unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for October-2016").present?
                fee.fee_details.create!(fee_date: '2016-10-01', description: 'Transportation Fee for October-2016', student_id: student_id, balance_amount: re_oct_16, amount: re_oct_16)
            end
        end
        if re_nov_16.present?
            unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for November-2016").present?
                fee.fee_details.create!(fee_date: '2016-11-01', description: 'Transportation Fee for November-2016', student_id: student_id, balance_amount: re_nov_16, amount: re_nov_16)
            end
        end
        if re_dec_16.present?
            unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for December-2016").present?
                fee.fee_details.create!(fee_date: '2016-12-01', description: 'Transportation Fee for December-2016', student_id: student_id, balance_amount: re_dec_16, amount: re_dec_16)
            end
        end
        if re_jan_17.present?
            unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for January-2017").present?
                fee.fee_details.create!(fee_date: '2017-01-01', description: 'Transportation Fee for January-2017', student_id: student_id, balance_amount: re_jan_17, amount: re_jan_17)
            end
        end
        if re_feb_17.present?
            unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for February-2017").present?
                fee.fee_details.create!(fee_date: '2017-02-01', description: 'Transportation Fee for February-2017', student_id: student_id, balance_amount: re_feb_17, amount: re_feb_17)
            end
        end
        if re_mar_17.present?
            unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for March-2017").present?
                fee.fee_details.create!(fee_date: '2017-03-01', description: 'Transportation Fee for March-2017', student_id: student_id, balance_amount: re_mar_17, amount: re_mar_17)
            end
        end
        if re_apr_17.present?
            unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for April-2017").present?
                fee.fee_details.create!(fee_date: '2017-04-01', description: 'Transportation Fee for April-2017', student_id: student_id, balance_amount: re_apr_17, amount: re_apr_17)
            end
        end
        if re_may_17.present?
            unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for May-2017").present?
                fee.fee_details.create!(fee_date: '2017-05-01', description: 'Transportation Fee for May-2017', student_id: student_id, balance_amount: re_may_17, amount: re_may_17)
            end
        end
        if re_jun_17.present?
            unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for June-2017").present?
                fee.fee_details.create!(fee_date: '2017-06-01', description: 'Transportation Fee for June-2017', student_id: student_id, balance_amount: re_jun_17, amount: re_jun_17)
            end
        end
        if re_sep_17.present?
            unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for September-2017").present?
                fee.fee_details.create!(fee_date: '2017-09-01', description: 'Transportation Fee for September-2017', student_id: student_id, balance_amount: re_sep_17, amount: re_sep_17)
            end
        end
        if re_oct_17.present?
            unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for October-2017").present?
                fee.fee_details.create!(fee_date: '2017-10-01', description: 'Transportation Fee for October-2017', student_id: student_id, balance_amount: re_oct_17, amount: re_oct_17)
            end
        end
        if re_nov_17.present?
            unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for November-2017").present?
                fee.fee_details.create!(fee_date: '2017-11-01', description: 'Transportation Fee for November-2017', student_id: student_id, balance_amount: re_nov_17, amount: re_nov_17)
            end
        end
        if re_dec_17.present?
            unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for December-2017").present?
                fee.fee_details.create!(fee_date: '2017-12-01', description: 'Transportation Fee for December-2017', student_id: student_id, balance_amount: re_dec_17, amount: re_dec_17)
            end
        end
        if re_jan_18.present?
            unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for January-2018").present?
                fee.fee_details.create!(fee_date: '2018-01-01', description: 'Transportation Fee for January-2018', student_id: student_id, balance_amount: re_jan_18, amount: re_jan_18)
            end
        end
        if re_feb_18.present?
            unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for February-2018").present?
                fee.fee_details.create!(fee_date: '2018-02-01', description: 'Transportation Fee for February-2018', student_id: student_id, balance_amount: re_feb_18, amount: re_feb_18)
            end
        end
        if re_mar_18.present?
            unless FeeDetail.where(fee_id: fee.id, description: "Transportation Fee for March-2018").present?
                fee.fee_details.create!(fee_date: '2018-03-01', description: 'Transportation Fee for March-2018', student_id: student_id, balance_amount: re_mar_18, amount: re_mar_18)
            end
        end

        if col_aug_16.present?
            update_balance_2016(fee.id, col_aug_16, "2016-08-01")
        end
        if col_sep_16.present?
            update_balance_2016(fee.id, col_sep_16, "2016-09-01")
        end
        if col_oct_16.present?
            update_balance_2016(fee.id, col_oct_16, "2016-10-01")
        end
        if col_nov_16.present?
            update_balance_2016(fee.id, col_nov_16, "2016-11-01")
        end
        if col_dec_16.present?
            update_balance_2016(fee.id, col_dec_16, "2016-12-01")
        end
        if col_jan_17.present?
            update_balance_2016(fee.id, col_jan_17, "2017-01-01")
        end
        if col_feb_17.present?
            update_balance_2016(fee.id, col_feb_17, "2017-02-01")
        end
        if col_mar_17.present?
            update_balance_2016(fee.id, col_mar_17, "2017-03-01")
        end
        if col_apr_17.present?
            update_balance_2016(fee.id, col_apr_17, "2017-04-01")
        end
        if col_may_17.present?
            update_balance_2016(fee.id, col_may_17, "2017-05-01")
        end
        if col_jun_17.present?
            update_balance_2016(fee.id, col_jun_17, "2017-06-01")
        end
        if col_jul_17.present?
            update_balance_2016(fee.id, col_jul_17, "2017-07-01")
        end
        if col_aug_17.present?
            update_balance_2016(fee.id, col_aug_17, "2017-08-01")
        end
        if col_sep_17.present?
            update_balance_2016(fee.id, col_sep_17, "2017-09-01")
        end
        if col_oct_17.present?
            update_balance_2016(fee.id, col_oct_17, "2017-10-01")
        end
        if col_nov_17.present?
            update_balance_2016(fee.id, col_nov_17, "2017-11-01")
        end
        if col_dec_17.present?
            update_balance_2016(fee.id, col_dec_17, "2017-12-01")
        end
        if col_jan_18.present?
            update_balance_2016(fee.id, col_jan_18, "2018-01-01")
        end
        if col_feb_18.present?
            update_balance_2016(fee.id, col_feb_18, "2018-02-01")
        end
        if col_mar_18.present?
            update_balance_2016(fee.id, col_mar_18, "2018-03-01")
        end


      end
  
    end

    def self.update_balance_2016(fee_id, rct_amount, rct_date)

        receipt_amount = rct_amount.to_f
        fees = Fee.find(fee_id)

        student_fees = FeeDetail.student_fees(fee_id)

        if student_fees.present?
            my_receipt = Receipt.create(fee_id: fee_id, amount: receipt_amount, payment_type_id: 3, receipt_date: DateTime.parse(rct_date))

            student_fees.each do |fee|
                fee_balance_amount = fee.balance_amount
                
                    if receipt_amount >= fee_balance_amount
                        balance_amount = fee_balance_amount
                        fee.update_attributes(paid_amount: fee.amount, balance_amount: 0)
                        receipt_amount = receipt_amount - balance_amount

                        my_receipt.receipt_details.create(amount: fee_balance_amount, fee_detail_id: fee.id)
                    elsif receipt_amount <= fee.amount && receipt_amount > 0
                        fee.update_attributes(paid_amount: receipt_amount, balance_amount: fee.amount - receipt_amount)
                        

                        my_receipt.receipt_details.create(amount: receipt_amount, fee_detail_id: fee.id)
                        receipt_amount = 0
                    end
                
            end
        else
            my_receipt = Receipt.create(fee_id: fee_id, amount: receipt_amount * -1, payment_type_id: 3, receipt_date: DateTime.parse(rct_date))
        end
    end

    def self.update_balance_2019(fee_id, rct_amount, rct_date)

        receipt_amount = rct_amount.to_f
        fees = Fee.find(fee_id)

        student_fees = FeeDetail.student_fees(fee_id)

        if student_fees.present?
            my_receipt = Receipt.create(fee_id: fee_id, amount: receipt_amount, payment_type_id: 3, receipt_date: DateTime.parse(rct_date))

            student_fees.each do |fee|
                fee_balance_amount = fee.balance_amount
                
                    if receipt_amount >= fee_balance_amount
                        balance_amount = fee_balance_amount
                        fee.update_attributes(paid_amount: fee.amount, balance_amount: 0)
                        receipt_amount = receipt_amount - balance_amount

                        my_receipt.receipt_details.create(amount: fee_balance_amount, fee_detail_id: fee.id)
                    elsif receipt_amount <= fee.amount && receipt_amount > 0
                        fee.update_attributes(paid_amount: receipt_amount, balance_amount: fee.amount - receipt_amount)
                        

                        my_receipt.receipt_details.create(amount: receipt_amount, fee_detail_id: fee.id)
                        receipt_amount = 0
                    end
                
            end
        else
            my_receipt = Receipt.create(fee_id: fee_id, amount: receipt_amount * -1, payment_type_id: 3, receipt_date: DateTime.parse(rct_date))
        end
    end

	def self.open_spreadsheet(file)
        case File.extname(file.original_filename)
            when ".csv" then Roo::CSV.new(file.path)
            when ".xls" then Roo::Excel.new (file.path)
            when ".xlsx" then Roo::Excelx.new(file.path)
            else raise "Unknown file type: #{file.original_filename}"
        end
    end

end
