class Student < ApplicationRecord
     has_many :fees, class_name: 'Fee', primary_key: 'code', foreign_key: 'student_id'
     has_many :fee_details, through: :fees
    # has_many :fees
     has_many :receipts, through: :fees
     validates_uniqueness_of :code
     validates_uniqueness_of :name

     scope :all_students, -> { includes(:fees, :fee_details).order("students.name ASC") }

    #  belongs_to :student, class_name: 'Student', primary_key: 'code', foreign_key: 'student_id'

end
