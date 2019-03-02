class FeeDetailsController < ApplicationController

     def new
          @fee_detail = FeeDetail.new
          respond_to do |format|
               format.js
          end
     end

     def edit
          @fee_detail = FeeDetail.find(params[:id])
          respond_to do |format|
               format.js
          end
     end

     def update
          @fee_detail = FeeDetail.find(params[:id])
          respond_to do |format|
               if @fee_detail.update_attributes(fee_detail_params)
                    @student = @fee_detail.student_id

                    fee = Fee.find(@fee_detail.fee_id)
                    fee_balance_amount = fee.total_amount - @fee_detail.amount
                    fee.update_attributes(total_amount: fee_balance_amount, balance_amount: fee_balance_amount)

                    if @student.present?
                      if Fee.where(student_id: @student).present?
                        @fees = Fee.where(student_id: @student).first
                      else
                        @fees = nil
                      end
                    end
          
                    format.js
               else
                    if @fee_detail.errors.any?
                         puts '******* ERRORS ********'
                         @fee_detail.errors.full_messages.each do |message|
                             puts message
                         end
                    end
               end
          end
     end

     def import_csv
      FeeDetail.import(params[:file])
      redirect_to root_path
     end

     private

          def fee_detail_params
               params.require(:fee_detail).permit(:amount, :chargeable, :student_id, :fee_date, :description)
          end

end