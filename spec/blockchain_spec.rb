require 'rspec'
require './lib/classes/blockchain'
require './lib/classes/block'

RSpec.describe "Blockchain" do
  before(:each) do
    @blockchain = Blockchain.new
  end 

  it "exists" do
    expect(@blockchain).to be_a(Blockchain)
  end 

  it "generates Genesis Block" do
    expect(@blockchain.chain).to_not be_empty
    expect(@blockchain.chain[0].data).to eq("Genesis Block")
  end 

  it "can add a block" do
    block = Block.new(1, "06/23/2022", { amount: 17 } )
    @blockchain.add_block(block)

    expect(@blockchain.chain.last).to be(block)
  end 

  it "gets latest block" do
    block = Block.new(1, "06/23/2022", { amount: 17 } )
    block_two = Block.new(2, "06/23/2022", { amount: 5 } )
    
    expect(@blockchain.get_latest_block).to eq(@blockchain.chain.last)
  end 

  it "can check chain validity" do
    @blockchain.add_block(Block.new(1, "06/23/2022", {amount: 3000}))
    @blockchain.add_block(Block.new(2, "06/23/2022", {amount: 1000}))
    
    expect(@blockchain.is_chain_valid).to be true

    @blockchain.chain[1].udata({amount: 4000})

    expect(@blockchain.is_chain_valid).to be false

    @blockchain.chain[1].hash = @blockchain.chain[1].calculate_hash

    expect(@blockchain.is_chain_valid).to be false
  end 
end 
