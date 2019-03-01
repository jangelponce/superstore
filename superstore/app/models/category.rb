class Category < ApplicationRecord
	has_many :products
	belongs_to :parent, :class_name => "Category", optional: true
	has_many   :children, :class_name => "Category"

	def treeying_descendents_and_self
		[self] + treeying_descendents
	end

	def treeying_descendents
		children.map do |child|
			[child.id] + child.treeying_descendents
		end.flatten
	end

end
