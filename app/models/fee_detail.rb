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
end