namespace :importer do
	task :sales, [:file] => [:environment] do |t, args|
		require 'csv'
		csv = CSV.read(args[:file], headers: true)
		csv.each_with_index do |row, i|
			puts "====== Processing record #{i + 1} of #{csv.length} ======"
			# setting vars
			row_row_id               = row["Row ID"]
			row_order_id             = row["Order ID"]
			row_order_date           = Date.strptime(row["Order Date"], '%m/%d/%Y') 
			row_order_priority       = row["Order Priority"]
			row_order_quantity       = row["Order Quantity"]
			row_sales                = row["Sales"]
			row_discount             = row["Discount"]
			row_ship_mode            = row["Ship Mode"]
			row_profit               = row["Profit"]
			row_unit_price           = row["Unit Price"]
			row_shipping_cost        = row["Shipping Cost"]
			row_customer_name        = row["Customer Name"]
			row_province             = row["Province"]
			row_region               = row["Region"]
			row_customer_segment     = row["Customer Segment"]
			row_product_category     = row["Product Category"]
			row_product_sub_category = row["Product Sub-Category"]
			row_product_name         = row["Product Name"]
			row_product_container    = row["Product Container"]
			row_product_base_margin  = row["Product Base Margin"]
			row_ship_date            = Date.strptime(row["Ship Date"], '%m/%d/%Y')
			row_order_id             = row["Order ID"]

			region = Region.where(name: row_region).first_or_create do |r|
				puts "Region: #{row_region} not found, creating"
				r.name = row_region
			end

			province = Province.where(name: row_province).first_or_create do |r|
				puts "Province: #{row_province} not found, creating"
				r.name = row_province
				r.region_id = region.id
			end

			category = Category.where(name: row_product_category).first_or_create do |r|
				puts "Category: #{row_product_category} not found, creating"
				r.name = row_product_category
			end

			sub_category = Category.where(name: row_product_sub_category).first_or_create do |r|
				puts "SubCategory: #{row_product_sub_category} not found, creating"
				r.name      = row_product_sub_category
				r.parent_id = category.id
			end

			ship_mode = ShipMode.where(name: row_ship_mode).first_or_create do |r|
				puts "ShipMode: #{row_ship_mode} not found, creating"
				r.name = row_ship_mode
			end

			segment = Segment.where(name: row_customer_segment).first_or_create do |r|
				puts "Segment: #{row_customer_segment} not found, creating"
				r.name = row_customer_segment
			end

			customer = Customer.where(name: row_customer_name).first_or_create do |r|
				puts "Customer: #{row_customer_name} not found, creating"
				r.name       = row_customer_name
				r.segment_id = segment.id
			end

			container = Container.where(name: row_product_container).first_or_create do |r|
				puts "Container: #{row_product_container} not found, creating"
				r.name = row_product_container
			end

			product = Product.where(name: row_product_name).first_or_create do |r|
				puts "Product: #{row_product_name} not found, creating"
				r.name         = row_product_name
				r.unit_price   = row_unit_price
				r.category_id  = category.id
				r.container_id = container.id
				r.base_margin  = row_product_base_margin
			end

			order = Order.where(id: row_order_id).first_or_create do |r|
				puts "Order: #{row_order_id} not found, creating"
				r.id             = row_order_id
				r.order_date     = row_order_date
				r.priority = row_order_priority
				r.customer_id    = customer.id
			end

			puts "OrderProduct: creating"
			order_product = OrderProduct.create({
				product_id:    product.id, 
				order_id:      order.id,
				quantity:      row_order_quantity,
				sales:         row_sales,
				discount:      row_discount,
				ship_mode_id:  ship_mode.id,
				profit:        row_profit,
				shipping_cost: row_shipping_cost,
				ship_date:     row_ship_date,
				province_id:   province.id
			})
		end

		puts "Done"

	end 
end