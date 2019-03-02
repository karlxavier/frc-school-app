class FeesController < ApplicationController
  before_action :authenticate_user!

  def index
    @student = ''
    if params[:filter].present?
      url = "http://sunrise.fortiddns.com:8088/sunrise/orisondata.ashx?head=FullStudent"
      @results = HTTParty.get(url)
      @student = (@results['Student'].find { |u| u['Code'] == params[:filter][:code] })
      
      if @student.present?
        if Fee.where(student_id: @student['Code']).present?
          @fees = Fee.where(student_id: @student['Code']).first

          session[:ParentName] = @student['ParentName']
          session[:FatherMobile] = @student['FatherMobile']
          session[:BusArea] = @student['BusArea']
          session[:FatherEmail] = @student['FatherEmail']

          session[:StudentName] = @student['Name']
          session[:StudentCode] = @student['Code']
          session[:StudentClass] = @student['Class']
          session[:StudentDivision] = @student['Division']
        else
          @fees = nil
        end
      end
    end
  end

  def new
    @student = ''
    if params[:filter].present?
      url = "http://sunrise.fortiddns.com:8088/sunrise/orisondata.ashx?head=FullStudent"
      @results = HTTParty.get(url)
      @student = (@results['Student'].find { |u| u['Code'] == params[:filter][:code] })
    end
  end

  def edit
    @fee = Fee.find(params[:id])
    respond_to do |format|
          format.js
    end
  end

  def update
    @fee = Fee.find(params[:id])
    respond_to do |format|
      if @fee.update_attributes(fee_params)

        updated_balance_amount = 0
        @fee.fee_details.each do |fee_detail|
          fee_detail.update_attributes(amount: @fee.fee_rate, balance_amount: @fee.fee_rate, chargeable: true)
          updated_balance_amount = updated_balance_amount + @fee.fee_rate
        end
        @fee.update_attributes(total_amount: updated_balance_amount, balance_amount: updated_balance_amount)

        @student = @fee.student_id

        if @student.present?
          if Fee.where(student_id: @student).present?
            @fees = Fee.where(student_id: @student).first
          else
            @fees = nil
          end
        end

        format.js
      end
    end
  end

  def import_csv
    Fee.import(params[:file])
    redirect_to root_path
  end

  private

    def fee_params
        params.require(:fee).permit(:total_amount, :balance_amount, :fee_rate, :paid)
    end

end
