class Student < ApplicationRecord
     has_many :fees
     has_many :receipts, through: :fees
     validates_uniqueness_of :code
     validates_uniqueness_of :name
end
