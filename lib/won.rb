
libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'won/simple'
include Won::Simple

require "won/helper"
include Won::Helper

require 'fileutils'
include FileUtils

inline true



