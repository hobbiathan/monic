require 'digest' # SHA256 support
require 'json'
require 'pry'
require 'oj'

class Block
  attr_reader :index, :timestamp, :data, :previousHash
  attr_accessor :hash 

  def initialize(index, timestamp, data, previousHash = '')
    @index = index
    @timestamp = timestamp
    @data = data
    @previousHash = previousHash 
    @hash = self.calculate_hash
  end 

  def calculate_hash
    Digest::SHA256.hexdigest(self.index.to_s + self.timestamp + self.previousHash.to_s + JSON.generate(self.data).to_s).to_s
  end 

  def uprevious(hash)
    @previousHash = hash
  end 

  def udata(data)
    @data = data
  end 
end 

class Blockchain
  attr_reader :chain

  def initialize()
    @chain = [self.create_genesis_block]
  end 

  def create_genesis_block
    return Block.new(0, "06/23/2022", "Genesis Block", "0")
  end 

  def get_latest_block
    self.chain.last
  end

  def add_block(block) 
    block.uprevious(self.get_latest_block.hash)
    block.hash = block.calculate_hash

    self.chain.push(block)
  end 

  def is_chain_valid
    @x = 1
    y = self.chain.size

    until @x == y do
      current_block = self.chain[@x]
      previous_block = self.chain[@x - 1]

      # Check if valid hash
      if current_block.hash != current_block.calculate_hash
        return false 
      end 

      # Check if valid previous hash 
      if current_block.previousHash != previous_block.hash
        return false
      end 

      @x += 1
    end 

    return true
  end 
end 

def self.result_beautify(monic)
  rough = Oj.dump(monic.chain).to_s
  json = JSON.parse(rough)
  json.each do |block|
    puts block 
    puts "\n"
  end 
end 


monic = Blockchain.new
monic.add_block(Block.new(1, "06/23/2022", { amount: 17 } ))
monic.add_block(Block.new(2, "06/23/2022", { amount: 20 } )) 

binding.pry

monic.chain[1].udata({amount: 4000})
monic.chain[1].hash = monic.chain[1].calculate_hash

binding.pry
