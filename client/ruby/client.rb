#!/usr/bin/env ruby

$LOAD_PATH.push('./lib')

require 'grpc'
require 'customer_service_services_pb'

def main
  stub = Protocol::CustomerService::Stub.new("#{ENV["SERVER_IP"]}:#{ENV["SERVER_PORT"]}", :this_channel_is_insecure)
  if ARGV.size == 2
    stub.add_person(Protocol::Person.new(name: ARGV[0], age: ARGV[1].to_i))
  else
    stub.list_person(Protocol::RequestType.new).each do |x|
      puts "name=#{x.name}, age=#{x.age}"
    end
  end
end

main
