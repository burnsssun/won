#!/usr/bin/ruby -wKU

$:.unshift File.dirname(__FILE__) + '/../lib'
require "won/simple"

@a = 3

puts str :index

__END__

@@ index
a shoud be #@a
#{str :a}
@@ a
a is #@a 

