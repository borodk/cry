require "openssl"

module CRYCoin
  module ProofOfWork
    
    # Increment until a valid hash is found
    # A valid hash is one that begins with the value of the difficulty variable
    private def proof_of_work(difficulty = "00")
      nonce = 0
      loop do
        hash = calc_hash_with_nonce(nonce)
        if hash[0..1] == difficulty
          return nonce
        else
          nonce += 1
        end
      end
    end

    private def calc_hash_with_nonce(nonce = 0)
      sha = OpenSSL::Digest.new("SHA256")
      sha.update("#{nonce}#{@index}#{@timestamp}#{@transactions}#{@previous_hash}")
      sha.hexdigest
    end

  end
end