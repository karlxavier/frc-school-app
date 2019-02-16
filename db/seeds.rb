url = "http://sunrise.fortiddns.com:8088/sunrise/orisondata.ashx?head=FullStudent"
@students = HTTParty.get(url)

Fee.destroy_all
FeeDetail.destroy_all
@students['Student'].each do |student|
     @fee = Fee.create( student_id: student['Code'], total_amount: 4000, paid_amount: 0, balance_amount: 4000, fee_rate: 400)
     @fee.fee_details.create(fee_date: '2019-01-01', description: 'Transportation Fee for January-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)
     @fee.fee_details.create(fee_date: '2019-02-01', description: 'Transportation Fee for February-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)
     @fee.fee_details.create(fee_date: '2019-03-01', description: 'Transportation Fee for March-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)

     @fee.fee_details.create(fee_date: '2019-04-01', description: 'Transportation Fee for April-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)
     @fee.fee_details.create(fee_date: '2019-05-01', description: 'Transportation Fee for May-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)
     @fee.fee_details.create(fee_date: '2019-06-01', description: 'Transportation Fee for June-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)
     @fee.fee_details.create(fee_date: '2019-09-01', description: 'Transportation Fee for September-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)

     @fee.fee_details.create(fee_date: '2019-10-01', description: 'Transportation Fee for October-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)
     @fee.fee_details.create(fee_date: '2019-11-01', description: 'Transportation Fee for November-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)
     @fee.fee_details.create(fee_date: '2019-12-01', description: 'Transportation Fee for December-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)
end