require 'pry'

require './classes/block'
require './classes/blockchain'


monic = Blockchain.new
monic.add_block(Block.new(1, "06/23/2022", { amount: 17 } ))
monic.add_block(Block.new(2, "06/23/2022", { amount: 20 } )) 

# binding.pry

monic.chain[1].udata({amount: 4000})
monic.chain[1].hash = monic.chain[1].calculate_hash

# binding.pry
