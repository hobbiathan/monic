require 'pry'
require 'time'

require './classes/block'
require './classes/blockchain'


@monic = Blockchain.new

@x = 1
@y = 100

until @x == @y do
  @monic.add_block(Block.new(@x, Time.now.to_s[0..9], { amount: srand(1000) } ))
  @x += 1
  sleep(0.5)
end
