#!usr/bin/env ruby

o = [('a'..'z'), ('0'..'9')].map { |i| i.to_a }.flatten
string = (0...8).map { o[rand(o.length)] }.join
print string
#print "\n"
