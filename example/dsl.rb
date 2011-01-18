#!/usr/bin/ruby -wKU
$:.unshift File.dirname(__FILE__) + '/../lib'
require "won"

inline "main.str"

@a = 3
puts str_obj self, :local_variables, :parent => self

puts str :local_variables, :parent => self

file 'temp' do
  @a = 3
  puts str :local_variables, :parent => self
end

# file './generated/temp.c' do
#   str :main, :int_vars => [ 'a', 'b']
# end

__END__

@@ local_variables
============================
#{local_variables.join(',')}
self:   #{self}
parent: #{parent}
a: #{@a}
============================
