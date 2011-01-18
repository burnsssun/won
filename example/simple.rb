#!/usr/bin/ruby -wKU

$:.unshift File.dirname(__FILE__) + '/../lib'
require "won/simple"
include Won::Simple

inline 'main.str'

@a = 3

# File.open( 'test.tmp', 'w' ) do |f|
#   local_var = 'local!!!'
#   f.write( str( :index, binding ) )
#   f.write( str( :locals, binding ) )
# end

local_var = 'local!!!!'

puts str :index
puts str :aaaa
puts str 'aaaa' 
puts str :locals

file 'xxx.tmp' do 
  local_var = 'gogogo'
  str :locals
end

file 'test.c.tmp' do
  int_vars = [ 'a', 'b']
  str :main, binding
end

data = { :name=> 'filer', :age=>14 }
puts str :data, data
puts str data

@templates.delete(:Hash)

template :hash do
  %q{hash Miss #{name}}
end

puts str data

puts str :'hash/mark2', data

data2 = { :view=> :beijing, :name=> 'filer', :age=>14 }
puts str data2

__END__

@@ index
a shoud be #@a
#{str :a}
@@ a
a is #@a 
@@ locals
#{local_var}
@@ aaaa
aaaa
@@ data
#{name}
#{age}
@@ Hash
Hash #{name} found!!!
@@ hash/mark2
hash/mark2 #{name}
@@ beijing
beijing #{name} #{age}
