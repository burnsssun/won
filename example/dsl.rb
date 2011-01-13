#!/usr/bin/ruby -wKU
$:.unshift File.dirname(__FILE__) + '/../lib'
require "won"

inline "main.str"

p str :packet_list

file './generated/temp.c' do
  str :main, :int_vars => [ 'a', 'b']
end

__END__

@@ packet_list
=== this is packet_list ===
