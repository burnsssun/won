
libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)



# require 'won/base'
# include Won::Delegator

require 'won/simple'
include Won::Simple

require 'fileutils'
include FileUtils

inline true

