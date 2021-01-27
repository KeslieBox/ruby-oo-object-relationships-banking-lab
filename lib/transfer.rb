class Transfer
  attr_accessor :sender, :receiver, :status, :amount

  @@all = []
  
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def self.all
    @@all
  end

  def valid?
    if self.sender.balance > 50 && self.sender.valid? && self.receiver.valid?
      true
    else
      false
    end
  end

  def execute_transaction
    if self.status == "pending" && self.valid? && self.sender.balance >= @amount
        self.sender.balance -= @amount
        self.receiver.balance += @amount 
        self.status = "complete" 
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end    
  end

  def reverse_transfer
    if self.status == "complete"
      self.sender.balance += @amount
      self.receiver.balance -= @amount 
    # binding.pry
    self.status = "reversed"
    end
  end
end
