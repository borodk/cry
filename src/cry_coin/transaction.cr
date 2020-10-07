require "json"

module CRYCoin
  class Block
    class Transaction
      
      JSON.mapping(
        from: String,
        to: String,
        amount: Int64
      )

      def initialize(@from, @to, @amount)
      end

    end
  end
end