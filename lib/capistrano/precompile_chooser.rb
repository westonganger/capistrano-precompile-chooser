val = nil

opts = ['local','remote','skip']

until val && opts.include?(val)
  puts
  puts "How do you want to compile assets? (#{opts.join('/')})"
  val = STDIN.gets.strip.downcase
end

puts

case val
when "local"
  #import 'config/deploy/local_precompile.cap'
  #import File.expand_path("../tasks/local_precompile.cap")
  load File.expand_path("../tasks/local_precompile.cap")
when "remote"
  require 'capistrano/rails/assets' ### Disable for local precompile
else
  # Do nothing
end
