#!/usr/bin/env ruby

require 'yaml'
require 'net/http'

REDIRECT = '302'
data     = YAML.load_file('data.yml')
uri      = URI.parse(data['url'])
devices  = data['devices']

devices.each do |device|
  name = device['name']
  mac_address = device['mac-address']

  res = Net::HTTP.post_form(uri, 'MacFilterAction' => 1, 'NewMacFilter' => mac_address)

  msg = if res.code == REDIRECT
    '%s (%s) blocked' % [name, mac_address]
  else
    '%s NOT blocked' % name
  end

  puts msg
end
