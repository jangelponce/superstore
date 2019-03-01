class Customer < ApplicationRecord
	has_many :orders
	belongs_to :segment
end
