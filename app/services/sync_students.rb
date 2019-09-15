class SyncStudents
  class << self

    def sync
      url = "http://sunrise.fortiddns.com:8088/sunrise/orisondata.ashx?head=FullStudent"
      @students = HTTParty.get(url)

      if @students.present?
        @students['Student'].each do |student|
          @student = Student.where(code: student['Code']).first

          if @student.present?
            fees = Fee.where(student_id: student['Code']).last
            bus_rate = 0

            if fees.present?
              fee_details = FeeDetail.where(fee_id: fees.id)
              bus_rate = fee_details.present? ? fee_details.last.amount : 0
            else
              Fee.create!(student_id: student['Code'], total_amount: 0, paid_amount: 0, balance_amount: 0, school_year_id: 3)
            end

            @student.student_class = student['Class']
            @student.division = student['Division']
            @student.is_active = student['StudentStatus'] == 'Studying' ? true : false
            @student.rate = bus_rate
            @student.save

          else
            joining_date = DateTime.strptime(student['JoiningDate'], '%m/%d/%Y')

            Student.create(code: student['Code'],
              name: student['Name'],
              parent_name: student['ParentName'],
              status: student['StudentStatus'],
              is_active: student['StudentStatus'] == 'Studying' ? true : false,
              gender: student['Sex'],
              nationality: student['Nationality'],
              birthdate: student['DOB'],
              roll_no: student['Roll_no'],
              student_class: student['Class'],
              division: student['Division'],
              address1: student['Address1'],
              address2: student['Address2'],
              father_mobile: student['FatherMobile'],
              father_email: student['FatherEmail'],
              mother_name: student['MotherName'],
              joining_date: joining_date,
            )
          end
        end
      end
    end

  end
end
