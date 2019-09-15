class RevenuesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_user_guest

  def index
    @student = ''
    @student_api = ""
    if params[:filter].present?
      @student = Student.where(code: params[:filter][:code]).first
      if @student.present?
        if Fee.where(student_id: @student.code).present?
          @fees = Fee.where(student_id: @student.code).first

          session[:ParentName] = @student.parent_name
          session[:FatherMobile] = @student.father_mobile
          session[:BusArea] = @student.address1
          session[:FatherEmail] = @student.father_email

          session[:StudentName] = @student.name
          session[:StudentCode] = @student.code
          session[:StudentClass] = @student.student_class
          session[:StudentDivision] = @student.division
        else
          # @fees = nil
          @fees = Fee.create!(student_id: @student.code, total_amount: 0, paid_amount: 0, balance_amount: 0, school_year_id: 3)
        end
      else
        url = "http://sunrise.fortiddns.com:8088/sunrise/orisondata.ashx?head=FullStudent"
        @results = HTTParty.get(url)
        @student_api = (@results['Student'].find { |u| u['Code'] == params[:filter][:code] })
        
        if @student_api.present?
          puts '**************** not present'
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

          if Fee.where(student_id: @student_api['Code']).present?
            @fees = Fee.where(student_id: @student_api['Code']).first
          else
            # @fees = nil
            @fees = Fee.create!(student_id: student.code, total_amount: 0, paid_amount: 0, balance_amount: 0, school_year_id: 3)
          end
        end
      end
    end
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