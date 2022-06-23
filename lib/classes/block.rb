require 'digest'
require 'json'

class Block
  attr_reader :index, :timestamp, :data, :previousHash
  attr_accessor :hash, :nonce 

  def initialize(index, timestamp, data, previousHash = '')
    @index = index
    @timestamp = timestamp
    @data = data
    @previousHash = previousHash 
    @hash = self.calculate_hash
    @nonce = 0
  end 

  def calculate_hash
    Digest::SHA256.hexdigest(self.index.to_s + self.timestamp + self.previousHash.to_s + JSON.generate(self.data).to_s + self.nonce.to_s).to_s
  end 

  def mine_block(difficulty)

    # Keep recalculating hash until first `x` amount of characters in hash is equal to the difficulty integer as zeros 
    while self.hash[0..difficulty - 1] != Array.new(difficulty) { |c| "0" }.join do
     self.nonce += 1
      self.hash = self.calculate_hash
   end

    puts "Block mined: #{self.hash}" 
  end 

  def uprevious(hash)
    @previousHash = hash
  end 

  def udata(data)
    @data = data
  end 
end 
