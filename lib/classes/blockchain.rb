require 'time'
require 'pry'
require './lib/classes/block'
require './lib/classes/transaction'

class Blockchain
  attr_reader :chain, :difficulty, :miningReward
  attr_accessor :pendingTransactions

  def initialize()
    @chain = [self.create_genesis_block]
    @difficulty = 5
    @pendingTransactions = [];
    @miningReward = 100
  end 

  def create_genesis_block
    return Block.new(Time.now.to_s[0..9], ["Genesis Block"], "0")
  end 

  def get_latest_block
    self.chain.last
  end

  def add_block(block) 
    block.uprevious(self.get_latest_block.hash)
    block.mine_block(self.difficulty)
    self.chain.push(block)
  end 

  def mine_pending_transactions(mining_reward_address)
    block = Block.new(Time.now.to_s[0..9], self.pendingTransactions, self.chain.last.hash)
    block.mine_block(self.difficulty)

    puts "Block succesfully mined!"
    self.chain.push(block)

    self.pendingTransactions = [
      Transaction.new(nil, mining_reward_address, self.miningReward)
    ]
  end 

  def create_transaction(transaction)
    self.pendingTransactions.push(transaction)
  end 

  def get_balance_of_address(address)
    balance = 0

    self.chain.drop(1).each do |block|
      block.transactions.each do |trans|
        if trans.fromAddress == address
          balance -= trans.amount
        end

        if trans.toAddress == address
          balance += trans.amount
        end 
      end 
    end 

    return balance
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


