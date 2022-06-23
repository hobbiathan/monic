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


