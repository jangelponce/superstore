class OrderProduct < ApplicationRecord
	belongs_to :order 
	belongs_to :ship_mode
	belongs_to :province
	belongs_to :product
end
