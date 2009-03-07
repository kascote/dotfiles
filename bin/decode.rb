#!/usr/bin/env ruby
require 'base64'

File.open( ARGV[1], 'w' ) {|h| h.write Base64.decode64( File.read(ARGV[0]) ) }
