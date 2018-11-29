require 'rubygems'
require 'redis'
require 'json'

CHANNEL = 'deploy'.freeze
ALLOWED_COMMANDS = ['deploy']
ALLOWED_PACKAGES = ['front', 'core']
$redis = Redis.new

packages = {
	"front" => ['mkdir front','cd front', 'mkdir angular', 'touch readme.md', 'echo "Front" >> readme.md'],
	"core" => ['mkdir core','cd core', 'mkdir rails', 'touch readme.md', 'echo "Core" >> readme.md']
}

loop do
  msg = STDIN.gets
  commands = msg.split(' ')
  if ALLOWED_COMMANDS.include?(commands[0]) && ALLOWED_PACKAGES.include?(commands[1])
  	$redis.publish CHANNEL, packages[commands[1]].to_json
  else
    	p 'Please enter correct command!'
  end
end