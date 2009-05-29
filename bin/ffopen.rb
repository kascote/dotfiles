#!/usr/bin/ruby1.9
require 'uri'
#
#uri = "gvim://open?url=file:///opt/ruby-enterprise/lib/ruby/gems/1.8/gems/activerecord-2.3.2/lib/active_record/reflection.rb&line=156"
uri = ARGV.first

filename = ''
lineno = 0
u = URI.parse(uri)
u.query.split('&').each {|q|
  k,v = q.split('=')
  filename = v if k == 'url'
  lineno = v if k == 'line'
}

system("/usr/bin/gvim --remote-silent #{filename}") 
sleep 1
system("/usr/bin/gvim --remote-send \"#{lineno}G\"")

#File.open('/tmp/test.log', 'w+') {|h| 
#  h.write "/usr/bin/gvim --remote-silent #{filename}\n"
#  h.write  "/usr/bin/gvim --remote-send #{lineno}G\n"
#}

#file = ARGV.first.split('file://').last.split('&').first

#`/usr/bin/gvim --remote-silent "#{file}"`
