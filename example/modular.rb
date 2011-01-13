#!/usr/bin/ruby -wKU

require "../lib/won"



app = Won::Base.new

app.inline_templates = true

#p app.templates

puts app.str :main, :a => 1, :b=> 3

__END__

@@ main

#include "stdio.h"

int main()
{
  int #{a}, #{b};
  
}

