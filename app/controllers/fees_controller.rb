class FeesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_user_guest

  def index
    @student = ''
    @student_api = ""
    if params[:filter].present?
      @student = Student.where(code: params[:filter][:code]).first
      if @student.present?
        if Fee.where(student_id: @student.code, temp: false).present?
          @fees = Fee.where(student_id: @student.code, temp: false).first

          session[:ParentName] = @student.parent_name
          session[:FatherMobile] = @student.father_mobile
          session[:BusArea] = @student.address1
          session[:FatherEmail] = @student.father_email

          session[:StudentName] = @student.name
          session[:StudentCode] = @student.code
          session[:StudentClass] = @student.student_class
          session[:StudentDivision] = @student.division
        else
          @fees = nil
        end
      else
        url = "http://sunrise.fortiddns.com:8088/sunrise/orisondata.ashx?head=FullStudent"
        @results = HTTParty.get(url)
        @student_api = (@results['Student'].find { |u| u['Code'] == params[:filter][:code] })
        
        if @student_api.present?
          if Fee.where(student_id: @student_api['Code'], temp: false).present?
            @fees = Fee.where(student_id: @student_api['Code'], temp: false).first

            student = Student.new
            student.code = @student_api['Code']
            student.name = @student_api['Name']
            student.parent_name = @student_api['ParentName']
            student.father_mobile = @student_api['FatherMobile']
            student.address1 = @student_api['BusArea']
            student.father_email = @student_api['FatherEmail']
            student.student_class = @student_api['StudentClass']
            student.division = @student_api['StudentDivision']
            student.save

            session[:ParentName] = @student_api['ParentName']
            session[:FatherMobile] = @student_api['FatherMobile']
            session[:BusArea] = @student_api['BusArea']
            session[:FatherEmail] = @student_api['FatherEmail']

            session[:StudentName] = @student_api['Name']
            session[:StudentCode] = @student_api['Code']
            session[:StudentClass] = @student_api['Class']
            session[:StudentDivision] = @student_api['Division']
          else
            @fees = nil
          end
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

  def reminders
    if params[:fees].present?
      fees = Fee.balance_fees_email(params[:fees])
      fees_json = fees.to_json(:include => {:student => {:only => [:name, :father_email]}, :fee_details => {:except => [:created_at, :updated_at] }})
      SendEmailJob.set(wait: 20.seconds).perform_later(fees_json)
      redirect_to reminders_path
    else
      
    end
    @balance_students = Fee.balance_students
  end

  private

    def fee_params
        params.require(:fee).permit(:total_amount, :balance_amount, :fee_rate, :paid)
    end

    def is_user_guest
      if current_user.is_guest?
        redirect_to reports_collections_path
      end
    end

end
