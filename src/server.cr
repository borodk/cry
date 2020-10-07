require "kemal"
require "uuid"

require "./cry"

# Generate a unique global address for this node
node_id = UUID.random.to_s

# Create blockchain
blockchain = CRYCoin::Blockchain.new

get "/chain" do
  # Send blockchain as json object
  blockchain.chain
  { chain: blockchain.chain }.to_json
end

get "/mine" do
  # Mine a new block
  blockchain.mine
  "Block with index=#{blockchain.chain.last.index} is mined."
end

get "/pending" do
  # Send pending transactions as json object
  { transactions: blockchain.uncommitted_transactions }.to_json
end

post "/transactions/new" do |env|
  # Add a new transaction
  transaction = CRYCoin::Block::Transaction.new(
    from: env.params.json["from"].as(String),
    to:  env.params.json["to"].as(String),
    amount:  env.params.json["amount"].as(Int64)
  )

  blockchain.add_transaction(transaction)

  "Transaction #{transaction} has been added to the node"
end

Kemal.run