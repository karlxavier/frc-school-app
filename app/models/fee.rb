class Fee < ApplicationRecord
    has_many :fee_details
    has_many :receipts

    scope :student_fees, -> (fee_id) { includes(:fee_details).where(id: fee_id).order("fee_details.fee_date ASC") }

    require 'csv'

  	def self.import(file)
  		spreadsheet= open_spreadsheet(file)
	    spreadsheet.default_sheet = spreadsheet.sheets[0]

	    headers = Hash.new
	    spreadsheet.row(1).each_with_index {|header,i|headers[header] = i}
	    ((spreadsheet.first_row + 1)..spreadsheet.last_row).each do |row|
	      
            student_id = spreadsheet.row(row)[headers['StudentID']]
            paid_amount = spreadsheet.row(row)[headers['PaidAmount']]
            balance_amount = spreadsheet.row(row)[headers['BalanceAmount']]
            
            temp_detail = TempDetail.new
            temp_detail.student_id = student_id
            temp_detail.paid_amount = paid_amount
            temp_detail.balance_amount = balance_amount
            temp_detail.save

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
