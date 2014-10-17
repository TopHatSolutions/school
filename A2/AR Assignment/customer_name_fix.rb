####################################################
# Name: Andrew Gillespie                           #
# Assignment: 2 - Part 1                           #
# Description: This will loop through the customer #
# table and take the first name value of customers #
# with no last name value, and split by ' ' and    #
# populate it properly.                            #
# Woo!                                             #
####################################################
load 'ar.rb'

customers = Customer.all
i = 1
customers.each do |c|
  puts "Entry ##{i}"
  next unless c.last_name == nil
  name = c.first_name.split(' ')
  c.first_name = name.first
  c.last_name = name.last
  if c.save
    puts "Save successful"
  else
    puts "Save failed:"
    c.errors.messages.each do |column, errors|
      errors.each do |error|
        puts "The #{column} property #{error}."
      end
    end
  end
  i = i+1
end

## Add comments
