####################################################
# Name: Andrew Gillespie                           #
# Assignment: 1 - Question 2                       #
# Description: This little bitty is chalk full of  #
# functions to calculate statistical shizznizzle   #
# from an array of any size                        #
# Woo!                                             #
####################################################

a = [ 70, 65, 80, 85, 23]
b = [ 70, 65, 80, 85, 23, 45]

def mean(num_array)
	sum = 0.00
	num_array.each {|x| sum += x} 
	sum / num_array.size
end

def median(num_array)
	ascend = num_array.sort
	median = 0.00
	if ascend.length % 2 == 1
		median += ascend[(ascend.length-1)/2.to_f]
	else
		median += ((ascend[(ascend.length/2)]+ascend[(ascend.length/2)-1]).to_f/2)
  end
  return median
end

def variance(num_array)
  m = mean(num_array)
  sum = 0.00
  num_array.each do |x|
    sum += (x-m)**2
  end
  return sum/num_array.size
end

def std_dev(num_array)
  v = variance(num_array)
  return Math.sqrt(v)
end

random_array = Array.new
100000.times {random_array << rand(1001)}

puts "Mean A: #{mean(a)}, Mean B: #{mean(b)}"
puts "Median A: #{median(a)}, Median B: #{median(b)}"
puts "Variance A: #{variance(a)}, Variance B: #{variance(b)}"
puts "Standard Deviation A: #{std_dev(a)}, Standard Deviation B: #{std_dev(b)}"

puts
puts "The Mean: #{mean(random_array)}"
puts "The Median: #{median(random_array)}"
puts "Variance: #{variance(random_array)}"
puts "The Standard Deviation: #{std_dev(random_array)}"



