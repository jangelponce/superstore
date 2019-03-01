class Province < ApplicationRecord
	has_many :order_products
	belongs_to :region
end
