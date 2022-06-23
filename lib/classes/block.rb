require 'digest'
require 'json'

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
