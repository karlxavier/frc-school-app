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

  def create
    @receipt = Fee.find(params[:receipt][:fee_id]).receipts.new(receipt_params)

    respond_to do |format|
        if @receipt.save
          @student = @receipt.fee.student_id
          # if params[:filter].present?
          #   url = "http://sunrise.fortiddns.com:8088/sunrise/orisondata.ashx?head=FullStudent"
          #   @results = HTTParty.get(url)
          #   @student = (@results['Student'].find { |u| u['Code'] == params[:filter][:code] })
          # end

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
      params.require(:receipt).permit(:amount, :fee_id, :payment_type_id)
    end

end
