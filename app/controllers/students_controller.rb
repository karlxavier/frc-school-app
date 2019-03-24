class StudentsController < ApplicationController
     before_action :set_student, only: [:edit, :update]

     def index
          @students = Student.all
     end

     def edit
     end

     def new
          @student = Student.new
     end

     def create
          @student = Student.new(student_params)

          respond_to do |format|
               if @student.save
                    format.html { redirect_to students_path }
               else
                    format.html { render 'new' }
               end
          end
     end

     def update
          respond_to do |format|
               if @student.update_attributes(student_params)
                    format.html { redirect_to students_path }
               else
                    format.html { render 'edit' }
               end
          end
     end

     private

          def student_params
               params.require(:student).permit(:code, :is_active, :rate, :name, 
                                             :status, :gender, :nationality, :birthdate,
                                             :student_class, :division, :address1, :address2,
                                             :father_mobile, :father_email, :mother_name,
                                             :mother_mobile, :joining_date, :parent_name)
          end

          def set_student
               @student = Student.find(params[:id])
          end


end