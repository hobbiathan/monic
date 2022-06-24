class Transaction
  attr_reader :fromAddress, :toAddress, :amount

  def initialize(from, to, amount)
    @fromAddress = from
    @toAddress = to
    @amount = amount
  end 
end 
