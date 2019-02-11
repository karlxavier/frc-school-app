class FeeDetail < ApplicationRecord
    belongs_to :fee

    scope :student_fees, -> (fee_id) { where(fee_id: fee_id).where("balance_amount > ?", 0).order(fee_date: :asc) }
    scope :student_all_fees, -> (fee_id) { where(fee_id: fee_id).order(fee_date: :asc) }
end