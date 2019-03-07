# CALCULATE RECEIPTS AND FEES
# TempDetail.all.each do |summary|

# end

# CREATE ALL STUDENT MASTER
require 'date'

url = "http://sunrise.fortiddns.com:8088/sunrise/orisondata.ashx?head=FullStudent"
@students = HTTParty.get(url)

Student.destroy_all
@students['Student'].each do |student|

     joining_date = DateTime.strptime(student['JoiningDate'], '%m/%d/%Y')
     # formatted_date = joining_date.strftime('%m/%d/%Y')

     Student.create(code: student['Code'],
     name: student['Name'],
     parent_name: student['ParentName'],
     status: student['StudentStatus'],
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


# code: nil, name: nil, parent_name: nil, status: nil, gender: nil, nationality: nil, birthdate: nil, 
# roll_no: nil, student_class: nil, division: nil, address1: nil, address2: nil, father_mobile: nil, 
# father_email: nil, mother_name: nil, mother_mobile: nil, bus_mode: nil, bus_time_in: nil, bus_time_out: nil, 
# religion: nil, joining_date: nil


# CREATE ALL STUDENT TRANSPORTATION FEES
# url = "http://sunrise.fortiddns.com:8088/sunrise/orisondata.ashx?head=FullStudent"
# @students = HTTParty.get(url)

# Fee.destroy_all
# FeeDetail.destroy_all
# @students['Student'].each do |student|
#      @fee = Fee.create( student_id: student['Code'], total_amount: 4000, paid_amount: 0, balance_amount: 4000, fee_rate: 400)
#      @fee.fee_details.create(fee_date: '2016-09-01', description: 'Transportation Fee for September-2016', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)

#      @fee.fee_details.create(fee_date: '2019-01-01', description: 'Transportation Fee for January-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)
#      @fee.fee_details.create(fee_date: '2019-02-01', description: 'Transportation Fee for February-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)
#      @fee.fee_details.create(fee_date: '2019-03-01', description: 'Transportation Fee for March-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)

#      @fee.fee_details.create(fee_date: '2019-04-01', description: 'Transportation Fee for April-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)
#      @fee.fee_details.create(fee_date: '2019-05-01', description: 'Transportation Fee for May-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)
#      @fee.fee_details.create(fee_date: '2019-06-01', description: 'Transportation Fee for June-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)
#      @fee.fee_details.create(fee_date: '2019-09-01', description: 'Transportation Fee for September-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)

#      @fee.fee_details.create(fee_date: '2019-10-01', description: 'Transportation Fee for October-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)
#      @fee.fee_details.create(fee_date: '2019-11-01', description: 'Transportation Fee for November-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)
#      @fee.fee_details.create(fee_date: '2019-12-01', description: 'Transportation Fee for December-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)
# end

