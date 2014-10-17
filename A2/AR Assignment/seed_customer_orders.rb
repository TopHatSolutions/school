####################################################
# Name: Andrew Gillespie                           #
# Assignment: 2 - Part 2                           #
# Description: This code will take an array of cu- #
# stomers and loop through, creating an order and  #
# filling the order with line items from a product #
# array. The current array holds product ids only. #
# Woo!                                             #
####################################################
load 'ar.rb'

array_of_customers = [
                        Customer.where(:province_id => 1).limit(1).take,
                        Customer.where(:province_id => 3).limit(1).take,
                        Customer.where(:province_id => 5).limit(1).take
                      ]
first_product = Product.first

array_of_products = [
                      [first_product.id + 0, first_product.id + 3, first_product.id + 6, first_product.id + 9],
                      [first_product.id + 1, first_product.id + 4, first_product.id + 7, first_product.id + 10],
                      [first_product.id + 2, first_product.id + 5, first_product.id + 8, first_product.id + 11]
                    ]
i = 0
array_of_customers.each do |customer|
  order = customer.orders.build

  order.status = 'new'
  order.pst_rate = Province.find(customer.province_id).pst
  order.gst_rate = Province.find(customer.province_id).gst
  order.hst_rate = Province.find(customer.province_id).hst

  if order.save
    puts "Order Saved."
    product_list = array_of_products[i]
    product_list.each do |p|
      product = Product.find(p)
      #puts product.name
      line_item = order.line_items.build
      line_item.product = product
      line_item.quantity = rand(0..10)
      line_item.price = product.price

      if line_item.save
        puts "#{product.name} Saved."
      else
        puts "Error: "
        line_item.errors.messages.each do |column, errors|
          errors.each do |error|
            puts "The #{column} property #{error}."
          end
        end
      end
    end
  else
    puts "Error: "
    order.errors.messages.each do |column, errors|
      errors.each do |error|
        puts "The #{column} property #{error}."
      end
    end
  end
  i += 1
end

puts "Give a customer another order."
customer = array_of_customers[rand(0...array_of_customers.size)]
puts "#{customer.first_name} gets another order."
order = customer.orders.build

order.status = 'new'
order.pst_rate = Province.find(customer.province_id).pst
order.gst_rate = Province.find(customer.province_id).gst
order.hst_rate = Province.find(customer.province_id).hst

if order.save
  puts "Order Saved."
  product_list = array_of_products[rand(0...array_of_products.size)]
  product_list.each do |p|
    product = Product.find(p)
    line_item = order.line_items.build
    line_item.product = product
    line_item.quantity = rand(0..10)
    line_item.price = product.price

    if line_item.save
      puts "#{product.name} Saved."
    else
      puts "Error: "
      line_item.errors.messages.each do |column, errors|
        errors.each do |error|
          puts "The #{column} property #{error}."
        end
      end
    end
  end
else
  puts "Error: "
  order.errors.messages.each do |column, errors|
    errors.each do |error|
      puts "The #{column} property #{error}."
    end
  end
end

array_of_customers.each do |c|
  orders = Order.where(:customer_id => c.id).all
  puts "#{c.first_name} has #{orders.count} orders"
end
