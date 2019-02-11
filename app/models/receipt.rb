class Receipt < ApplicationRecord
     belongs_to :fee
     has_many :fee_details, through: :fee
     before_create :update_balance

     scope :receipt_fees, -> (fee_id) { includes(:fee, :fee_details).where(fee_id: fee_id).order("fee_details.fee_date ASC") }

     private

          def update_balance

               receipt_amount = self.amount #00
               fees = Fee.find(self.fee_id)

               FeeDetail.student_fees(self.fee_id).each do |fee|
                    if receipt_amount >= fee.balance_amount
                         puts '******* if'
                         fee.update_attributes(paid_amount: fee.amount, balance_amount: 0)
                         receipt_amount = receipt_amount - fee.amount
                    elsif receipt_amount <= fee.amount && receipt_amount > 0
                         puts '******* elsif'
                         fee.update_attributes(paid_amount: receipt_amount, balance_amount: fee.amount - receipt_amount)
                         receipt_amount = 0
                    end
               end

               fees.update_attributes(paid_amount: fees.paid_amount + self.amount, balance_amount: fees.total_amount - self.amount)
          end
end
