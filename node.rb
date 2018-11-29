require 'rubygems'
require 'redis'
require 'json'

$redis = Redis.new

$redis.subscribe('deploy') do |on|
  on.message do |channel, msg|
    commands = JSON.parse(msg)
    p "Commands to execute:"
    p "#{commands}"
    p system(commands.join(';'))
    puts "Successful!"
  end
end