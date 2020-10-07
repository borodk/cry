require "./proof_of_work"
require "./transaction"

module CRYCoin
  class Block
    include ProofOfWork

    JSON.mapping(
      index: Int32,
      current_hash: String,
      nonce: Int32,
      previous_hash: String,
      transactions: Array(Transaction),
      timestamp: Time
    )

    def initialize(index = 0, transactions = [] of Transaction, previous_hash = "hash")
      @transactions = transactions
      @index = index
      @timestamp = Time.utc
      @previous_hash = previous_hash
      @nonce = proof_of_work
      @current_hash = calc_hash_with_nonce(@nonce)
    end

    def self.first()
      Block.new(previous_hash: "0")
    end

    def self.next(previous_block, transactions = [] of Transaction)
      Block.new(
        transactions: transactions,
        index: previous_block.index + 1, 
        previous_hash: previous_block.current_hash
      )
    end

  end
end