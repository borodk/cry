require "./proof_of_work"

module CRYCoin
  class Block
    include ProofOfWork

    property current_hash : String
    property index : Int32
    property nonce : Int32
    property previous_hash : String

    def initialize(index = 0, data = "data", previous_hash = "hash")
      @data = data
      @index = index
      @timestamp = Time.utc
      @previous_hash = previous_hash
      @nonce = proof_of_work
      @current_hash = calc_hash_with_nonce(@nonce)
    end

    def self.first(data = "Thee Genesis Block")
      Block.new(data: data, previous_hash: "0")
    end

    def self.next(previous_node, data = "Transaction Data")
      Block.new(
        data: "Transaction data number (#{previous_node.index + 1})", 
        index: previous_node.index + 1, 
        previous_hash: previous_node.current_hash
      )
    end

  end
end

# testing - creates a simple blockchain with 5 blocks
blockchain = [ CRYCoin::Block.first ]
puts blockchain.inspect
previous_block = blockchain[0]

5.times do |i|
  new_block  = CRYCoin::Block.next(previous_block)
  blockchain << new_block
  previous_block = new_block
  puts new_block.inspect
end