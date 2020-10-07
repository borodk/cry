require "openssl"

module CRYCoin
  class Block

    property current_hash : String

    def initialize(index = 0, data = "data", previous_hash = "hash")
      @data = data
      @index = index
      @timestamp = Time.utc
      @previous_hash = previous_hash
      @current_hash = hash_block
    end

    def index
      @index
    end

    def previous_hash
      @previous_hash
    end

    def self.first(data = "Thee Genesis Block")
      Block.new(data: data, previous_hash: "0")
    end

    def self.next(previous_node, data = "Transaction Data")
      Block.new(data: "Transaction data number (#{previous_node.index + 1})", index: previous_node.index + 1, previous_hash: previous_node.current_hash)
    end

    private def hash_block
      hash = OpenSSL::Digest.new("SHA256")
      hash.update("#{@index}#{@timestamp}#{@data}#{@previous_hash}")
      hash.hexdigest
    end
  end
end

# testing - creates a simple blockchain with 5 blocks
blockchain = [ CRYCoin::Block.first ]
previous_block = blockchain[0]

5.times do
  new_block  = CRYCoin::Block.next(previous_block)
  blockchain << new_block
  previous_block = new_block
end

puts blockchain