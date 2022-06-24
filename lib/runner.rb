require 'pry'
require 'time'

require './lib/classes/block'
require './lib/classes/blockchain'
require './lib/classes/transaction'


@monic = Blockchain.new

@x = 1
@y = 100

puts "Starting miner..."

until @x == @y do
  @monic.create_transaction(Transaction.new('huberts-address', 'humphreys-address', rand(1000))) 
  @monic.create_transaction(Transaction.new('humphreys-address', 'huberts-address', rand(1000)))

  @monic.mine_pending_transactions("huberts-address")
  puts "Balance of Hubert is #{@monic.get_balance_of_address("huberts-address")}"
  puts "\n"

  @monic.mine_pending_transactions("humphreys-address")
  puts "Balance of Humphrey is #{@monic.get_balance_of_address("humphreys-address")}"
  puts "\n"

  puts "Is chain valid: #{@monic.is_chain_valid}"
  puts "\n\n"

  @x += 1
end 


@monic.create_transaction(Transaction.new('huberts-address', 'address2', 50))
@monic.create_transaction(Transaction.new('address2', 'huberts-address', 100))

puts "Starting miner..."
@monic.mine_pending_transactions("huberts-address")

puts "Balance of Hubert is #{@monic.get_balance_of_address("huberts-address")}"
puts "\n"
puts "Is chain valid: #{@monic.is_chain_valid}"

sleep(0.5)

@monic.create_transaction(Transaction.new('huberts-address', 'address2', 50))    
@monic.create_transaction(Transaction.new('address2', 'huberts-address', 100))

puts "Starting miner..."
@monic.mine_pending_transactions("huberts-address")

puts "Balance of Hubert is #{@monic.get_balance_of_address("huberts-address")}"
puts "\n"
puts "Is chain valid: #{@monic.is_chain_valid}"

