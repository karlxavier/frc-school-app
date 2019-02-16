class ReceiptsController < ApplicationController
  
  def new
    @student = ''
    if params[:filter].present?
      url = "http://sunrise.fortiddns.com:8088/sunrise/orisondata.ashx?head=FullStudent"
      @results = HTTParty.get(url)
      @student = (@results['Student'].find { |u| u['Code'] == params[:filter][:code] })
    end
  end

  def generate_receipt
    @fee = Fee.find(params[:fee_id])
    respond_to do |format|
      format.js
    end
  end

  def show
    @receipt = Receipt.find(params[:id])
    @student = @receipt.fee.student_id
  end

  def create
    @receipt = Fee.find(params[:receipt][:fee_id]).receipts.new(receipt_params)

    respond_to do |format|
        if @receipt.save
          @student = @receipt.fee.student_id

          receipt_amount = @receipt.amount
          fees = Fee.find(@receipt.fee_id)

          FeeDetail.student_fees(@receipt.fee_id).each do |fee|
              if receipt_amount >= fee.balance_amount
                    balance_amount = fee.balance_amount
                    fee.update_attributes(paid_amount: fee.amount, balance_amount: 0)
                    @receipt.receipt_details.create(amount: balance_amount, fee_detail_id: fee.id)
                    receipt_amount = receipt_amount - balance_amount
              elsif receipt_amount <= fee.amount && receipt_amount > 0
                    fee.update_attributes(paid_amount: receipt_amount, balance_amount: fee.amount - receipt_amount)
                    @receipt.receipt_details.create(amount: receipt_amount, fee_detail_id: fee.id)
                    receipt_amount = 0
              end
          end

          fees.update_attributes(paid_amount: fees.paid_amount + @receipt.amount, balance_amount: fees.balance_amount - @receipt.amount, paid: true)

          if @student.present?
            if Fee.where(student_id: @student).present?
              @fees = Fee.where(student_id: @student).first
            else
              @fees = nil
            end
          end

          format.js
        else
          if @receipt.errors.any?
              puts '******* ERRORS ********'
              @receipt.errors.full_messages.each do |message|
                  puts message
              end
          end
        end
    end
  end

  private

    def receipt_params
      params.require(:receipt).permit(:amount, :fee_id, :payment_type_id, :payment_reference)
    end

end
