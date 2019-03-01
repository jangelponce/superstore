class Product < ApplicationRecord
	belongs_to :container
	belongs_to :category
	has_many :order_products
end
