class Fee < ApplicationRecord
    has_many :fee_details
    has_many :receipts

    scope :student_fees, -> (fee_id) { includes(:fee_details).where(id: fee_id).order("fee_details.fee_date ASC") }
end
