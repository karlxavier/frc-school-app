class ReceiptDetail < ApplicationRecord
     belongs_to :receipt
     belongs_to :fee_detail

     validates_uniqueness_of :receipt_id, scope: %i[fee_detail_id amount]
end
