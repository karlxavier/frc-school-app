class FeeDetail < ApplicationRecord
    belongs_to :fee
    has_many :receipt_details
    # before_save :update_fee_total_balance

    scope :student_fees, -> (fee_id) { where(fee_id: fee_id, chargeable: true).where("balance_amount > ?", 0).order(fee_date: :asc) }
    scope :student_all_fees, -> (fee_id) { where(fee_id: fee_id).order(fee_date: :asc) }

    def update_fee_total_balance
        fee = Fee.find(self.fee_id)
        fee_balance_amount = fee.fee_rate - self.amount

        fee.total_amount = fee_balance_amount
        fee.balance_amount = fee_balance_amount
        fee.save
        
        # fee.fee_details.collect { |oi| oi.valid? ? oi.amount : 0 }.sum
        puts '********** fee'
        puts fee.fee_details.collect { |oi| oi.valid? ? oi.amount : 0 }.sum
        puts self.amount
    end


    require 'csv'

  	def self.import(file)
  		spreadsheet= open_spreadsheet(file)
	    spreadsheet.default_sheet = spreadsheet.sheets[0]

	    headers = Hash.new
	    spreadsheet.row(1).each_with_index {|header,i|headers[header] = i}
	    ((spreadsheet.first_row + 1)..spreadsheet.last_row).each do |row|
	      
            student_id = spreadsheet.row(row)[headers['Code']]
            month_year = spreadsheet.row(row)[headers['FeeDate']]
            amount = spreadsheet.row(row)[headers['Amt']]
            
            temp_master = TempMaster.new
            temp_master.student_id = student_id
            temp_master.month_year = month_year
            temp_master.amount = amount
            temp_master.save

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