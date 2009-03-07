#!/usr/bin/env ruby

lines = File.readlines("/proc/acpi/video/VID/LCD/brightness")
levels = lines[1].split(' ')

if ARGV[0].nil?
  puts "valor actual #{levels[1]}" 
else
  begin
    File.open("/proc/acpi/video/VID/LCD/brightness", "w") {|h| h.write ARGV[0] }
  rescue Errno::EACCES
    puts "no tiene permiso para scribir, debe ejecutar con SUDO"
  rescue Exception => e
    puts e.messsage
  end
end
