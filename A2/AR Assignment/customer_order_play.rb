load 'ar.rb'

customer = Customer.first
order = customer.orders.build

puts customer.orders
puts customer.inspect
puts Province.find(customer.province_id).inspect

order.status = 'new'
order.pst_rate = Province.find(customer.province_id).pst
order.gst_rate = Province.find(customer.province_id).gst
order.hst_rate = Province.find(customer.province_id).hst

puts order.inspect

if order.save
  puts "Saved."
else
  puts "Error: "
  order.errors.messages.each do |column, errors|
    errors.each do |error|
      puts "The #{column} property #{error}."
    end
  end
end

product1 = Product.first
line_item1 = order.line_items.build

line_item1.product = product1
line_item1.quantity = 12
line_item1.price = product1.price

if line_item1.save
  puts "Saved."
else
  puts "Error: "
  line_item1.errors.messages.each do |column, errors|
    errors.each do |error|
      puts "The #{column} property #{error}."
    end
  end
end
