require "kemal"
require "uuid"

require "./cry"
require "./cry_coin/consensus"

# Generate a unique global address for this node
node_id = UUID.random.to_s

# Create blockchain
blockchain = CRYCoin::Blockchain.new

# Send blockchain as json object
get "/chain" do
  blockchain.chain
  { chain: blockchain.chain }.to_json
end

# Mine a new block
get "/mine" do
  blockchain.mine
  "Block with index=#{blockchain.chain.last.index} is mined."
end

# Send pending transactions as json object
get "/pending" do
  { transactions: blockchain.uncommitted_transactions }.to_json
end

# Add a new transaction
post "/transactions/new" do |env|
  transaction = CRYCoin::Block::Transaction.new(
    from: env.params.json["from"].as(String),
    to:  env.params.json["to"].as(String),
    amount:  env.params.json["amount"].as(Int64)
  )

  blockchain.add_transaction(transaction)

  "Transaction #{transaction} has been added to the node"
end

post "/nodes/register" do |env|
  nodes = env.params.json["nodes"].as(Array)

  raise "Empty array" if nodes.empty?

  nodes.each do |node|
    blockchain.register_node(node.to_s)
  end

  "New nodes have been added: #{blockchain.nodes}"
end

get "/nodes/resolve" do
  if blockchain.resolve
    "Successfully update the chain"
  else
    "Current chain is up-to-date"
  end
end

Kemal.config.port = ENV["PORT"].to_i || 3000
Kemal.run