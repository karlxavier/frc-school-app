class FeeDetailsController < ApplicationController
  before_action :authenticate_user!

    def index
      @student = ''
      @student_api = ""
      if params[:filter].present?
        @student = Student.where(code: params[:filter][:code]).first
        if @student.present?
          @fees = @student.fees.last
          if @fees.present?
            # @fees = Fee.where(student_id: @student.code).first
  
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

     def new
          @fee_detail = FeeDetail.new
          respond_to do |format|
               format.js
          end
     end

     def edit
          @fee_detail = FeeDetail.find(params[:id])
          # respond_to do |format|
          #      format.js
          # end
     end

     def update
          @fee_detail = FeeDetail.find(params[:id])
          # respond_to do |format|
               if @fee_detail.update_attributes(fee_detail_params)
                    @fee_detail.update_attributes(balance_amount: @fee_detail.amount)
                    @student = @fee_detail.student_id

                    fee = Fee.find(@fee_detail.fee_id)
                    fee_balance_amount = fee.fee_details.sum(:balance_amount)
                    fee.update_attributes(total_amount: fee_balance_amount, balance_amount: fee_balance_amount)

                    if @student.present?
                      if Fee.where(student_id: @student).present?
                        @fees = Fee.where(student_id: @student).first
                      else
                        @fees = nil
                      end
                    end
          
                    redirect_to fee_details_path
               else
                    if @fee_detail.errors.any?
                         puts '******* ERRORS ********'
                         @fee_detail.errors.full_messages.each do |message|
                             puts message
                         end
                    end
               end
          # end
     end

     def create
      puts '************ create'
      from_date = DateTime.parse(params[:fee_detail][:created_at]) # FROM DATE
      to_date = DateTime.parse(params[:fee_detail][:updated_at]) # TO DATE

      date = from_date
      hash = { }
      fee_balance = 0

      if params[:fee_detail].has_key?(:fee_id)
        fee = Fee.find(params[:fee_detail][:fee_id])
        rate = params[:fee_detail][:amount].to_f
        fee_balance_amount = fee.balance_amount.to_f

        while (date <= to_date)
          unless date.strftime("%B") == "July" || date.strftime("%B") == "August" # Exclude months of July and August!
            hash[date.strftime("%Y-%m-%d")] = 0
            puts fee.student_id
            fee_details = fee.fee_details.create!(fee_date: date.strftime("%Y-%m-%d"), description: "Transportation Fee for #{date.strftime('%B')}-#{date.strftime('%Y')} ", student_id: fee.student_id, balance_amount: rate, amount: rate)

            fee_balance = fee_balance + rate
          end

          date = date.advance(months: 1)
        end

        if fee_balance_amount < 0
          puts '*********** fee_balance_amount < 0'
          Fee.update_student_balance(fee.id, fee_balance_amount * -1, Time.now.strftime("%Y-%m-%d").to_s)
        end
        fee.update_attributes(balance_amount: fee_balance.to_f + fee_balance_amount, student_id: fee.student_id)
        if fee.errors.any?
          puts '******* ERRORS ********'
          fee.errors.full_messages.each do |message|
              puts message
          end
        end
        
        respond_to do |format|
          @fees = Fee.where(student_id: fee.student_id).first
          @student = Student.where(code: fee.student_id).first
          format.js
        end
      end

     end

    def destroy
      @fee_detail = FeeDetail.find(params[:id])
      fee = Fee.find(@fee_detail.fee_id)
      if @fee_detail.destroy

          # fee = Fee.find(@fee_detail.fee_id)
          fee_balance_amount = fee.fee_details.sum(:balance_amount)
          fee.update_attributes(total_amount: fee_balance_amount, balance_amount: fee_balance_amount)

          @student = fee.student
          @fees = Fee.where(student_id: fee.student_id).first

          flash.now[:notice] = "Fee successfully deleted."
      else
          flash.now[:error] = "Cannot delete this brand, associations still exist."
      end
      render action: :index
    end

     def import_csv
      FeeDetail.import(params[:file])
      redirect_to root_path
     end

    def generate_revenue
      @fee = Fee.find(params[:fee_id])
      respond_to do |format|
        format.js
      end
    end

    def generate_all_revenue
      respond_to do |format|
        format.js
      end
    end

    def create_all_revenue
      puts '************* create_all_revenue'
      puts params[:fee_detail][:created_at]
      puts params[:fee_detail][:updated_at]
      respond_to do |format|
        GenerateAllRevenueJob.set(wait: 10.seconds).perform_later(params[:fee_detail][:created_at], params[:fee_detail][:updated_at])
        format.js
      end
    end

     private

          def fee_detail_params
               params.require(:fee_detail).permit(:fee_id, :amount, :chargeable, :student_id, :fee_date, :description, :january, :created_at, :updated_at)
          end

end