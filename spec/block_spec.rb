require 'rspec'
require './lib/classes/block'

RSpec.describe "Block" do
  before(:each) do
    @block = Block.new(0, "06/23/2022", {amount: 3000})
  end 

  it 'exists' do
    expect(@block).to be_a(Block)
  end 

  it 'can read attributes' do
    expect(@block.index).to eq(0)
    expect(@block.timestamp).to eq("06/23/2022")
    expect(@block.data).to eq({amount: 3000})
    expect(@block.previousHash).to eq('')
  end

  it 'calculates hash' do
    @block.calculate_hash
    expect(@block.hash).to eq(@block.hash)
  end 

  # These exist for validity checking in the blockchain class - they should, however, not exist within a genuine blockchain, since you're not supposed to modify these things
  context 'helper testing' do
    it 'can change previous hash' do
      @block.uprevious("a")
      expect(@block.previousHash).to eq("a")
    end 

    it 'can change previous data' do
      @block.udata({amount: 300000})
      expect(@block.data).to eq({amount: 300000})
    end 

    it 'can mine block' do
      prev_hash = @block.hash
      @block.mine_block(3)
      expect(@block.hash).to_not eq(prev_hash)
      expect(@block.hash[0..2]).to eq("000")
    end 
  end 
end 
