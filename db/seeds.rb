url = "http://sunrise.fortiddns.com:8088/sunrise/orisondata.ashx?head=FullStudent"
@students = HTTParty.get(url)

@students['Student'].each do |student|
     @fee = Fee.create( student_id: student['Code'], total_amount: 1200, paid_amount: 0, balance_amount: 1200)
     @fee.fee_details.create(fee_date: '2019-01-01', description: 'Transportation Fee for January-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)
     @fee.fee_details.create(fee_date: '2019-02-01', description: 'Transportation Fee for February-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)
     @fee.fee_details.create(fee_date: '2019-03-01', description: 'Transportation Fee for March-2019', student_id: student['Code'], amount: 400, paid_amount: 0, balance_amount: 400)
end