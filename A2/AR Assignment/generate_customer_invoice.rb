####################################################
# Name: Andrew Gillespie                           #
# Assignment: 2 - Part 3                           #
# Description: This little bitty is chalk full of  #
# fun made to loop through the customers database  #
# thingy and generate invoices for customers with  #
# new orders, this will run for all new orders.    #
# Woo!                                             #
####################################################
load 'ar.rb'

customers_with_new_orders = Customer.includes(:orders).where(orders: {status: 'new'})

def currency amount
  sprintf("$%.2f",amount)
end

customers_with_new_orders.each do |c|
  orders_for_customer = Order.all.where(:customer_id => c.id).where(:status => 'new')
  orders_for_customer.each do |o|
    line_items_for_order = o.line_items
    name = "#{c.first_name} #{c.last_name}"
    address = c.address
    city = c.city
    province = c.province.name
    gst = o.gst_rate
    pst = o.pst_rate
    hst = o.hst_rate
    subtotal = 0.00

    puts
    puts "Invoice for #{name}"
    puts "#{address}"
    puts "#{city}, #{province}"
    puts "Order Number: #{o.id}"
    puts
    line_items_for_order.each do |p|
      p_name = p.product.name
      p_quantity = p.quantity
      p_unit_cost = p.price
      p_sub_total = p_quantity*p_unit_cost

      print "#{p_name} "
      puts "." * (50 - p_name.length) + " #{p_quantity} x #{currency(p_unit_cost)} = #{currency(p_sub_total)}"

      subtotal += p_sub_total
    end
    
    pst_amt = pst*subtotal
    gst_amt = gst*subtotal
    hst_amt = hst*subtotal
    grand_total = subtotal+pst_amt+gst_amt+hst_amt

    puts
    puts "Sub Total    : #{currency(subtotal)}"
    puts "PST (#{pst*100}%)  : #{currency(pst_amt)}" unless pst.zero?
    puts "GST (#{gst*100}%)  : #{currency(gst_amt)}" unless gst.zero?
    puts "HST (#{hst*100}%)  : #{currency(hst_amt)}" unless hst.zero?
    puts "Grand Total  : #{currency(grand_total)}"
    puts
    puts "--- <('-'<) " * 7
  end
end
