####################################################
# Name: Andrew Gillespie                           #
# Assignment: 1 - Question 1                       #
# Description: This little bitty is chalk full of  #
# fun made to loop through the customers database  #
# thingy and generate invoices from the associated #
# information.                                     #
# Woo!                                             #
####################################################

orders_by_customer_id = {
  101 => [
  { :product_id => 13, :quantity => 2  },
  { :product_id => 35, :quantity => 16 },
  { :product_id => 11, :quantity => 3  }],
  24 => [
  { :product_id => 11, :quantity => 3  },
  { :product_id => 35, :quantity => 4  }],
  36 => [
  { :product_id => 25, :quantity => 17 },
  { :product_id => 42, :quantity => 2  },
  { :product_id => 35, :quantity => 7  }]
}
products_by_id = {
  11 => { :name => "teddy bear", :price => 14.23 },
  25 => { :name => "toy ghosts", :price => 4.34  },
  13 => { :name => "giant newt", :price => 56.00 },
  42 => { :name => "sandcastle", :price => 12.45 },
  35 => { :name => "shoe phone", :price => 86.00 }
}
customers_by_id = {
  101 => { :name => 'John Smith', :address => '128 Good St.', :city => 'Winnipeg', :province => 'MB' },
  24  => { :name => 'Ralph Woodhorse', :address => '67 Pylon Way', :city => 'Calgary', :province => 'AB' },
  36  => { :name => 'Mary Contra', :address => '342 Modem Drive', :city => 'Regina', :province => 'SK' }
}
SALES_TAX_BY_PROVINCE = { 'MB' => 0.07, 'AB' => 0, 'BC' => 0.07, 'SK' => 0.05}
GST = 0.05
def currency amount
  sprintf("$%.2f",amount)
end

# Question Answer
customers_by_id.each do |cust, info|
	subtotal = 0.00
	pst = SALES_TAX_BY_PROVINCE[info[:province]]
	
	puts
	puts "Invoice for #{info[:name]}"
	puts "#{info[:address]}"
	puts "#{info[:city]}, #{info[:province]}"
	puts
	orders_by_customer_id[cust].each do |item|
		p_id = item[:product_id]
		p_name = products_by_id[p_id][:name]
		p_quantity = item[:quantity]
		p_unit_cost = products_by_id[p_id][:price]
		p_sub_total = p_quantity*p_unit_cost
		
		puts "#{p_name} ................. #{p_quantity} x #{currency(p_unit_cost)} = #{currency(p_sub_total)}"
		
		subtotal += p_sub_total
	end
	
	pst_amt = pst*subtotal
	gst_amt = GST*subtotal
	grand_total = subtotal+pst_amt+gst_amt
	
	puts
	puts "Sub Total    : #{currency(subtotal)}"
	puts "PST (#{pst*100}%)  : #{currency(pst_amt)}" unless pst == 0
	puts "GST (#{GST*100}%)  : #{currency(gst_amt)}"
	puts "Grand Total  : #{currency(grand_total)}"
	puts
	
end