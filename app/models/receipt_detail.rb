class ReceiptDetail < ApplicationRecord
     belongs_to :receipt
     belongs_to :fee_detail
end
