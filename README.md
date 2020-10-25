# 😢 cry 😢

crystal language cryptocurrency demo

## Installation

TODO: Write installation instructions here

## Usage

#### Run  
PORT=3000 crystal run src/server.cr  
PORT=3001 crystal run src/server.cr  

#### Register second node to first node:  
curl -X POST http://0.0.0.0:3000/nodes/register -H "Content-Type: application/json" -d '{"nodes": ["http://0.0.0.0:3001"]}'

#### Add transaction:   
curl -X POST http://0.0.0.0:3001/transactions/new -H "Content-Type: application/json" -d '{"from": "fnu", "to":"batman", "amount": 777}'  

#### Mine transactions into a block on the second node:  
curl http://0.0.0.0:3001/mine  

#### View pending transactions:  
curl http://0.0.0.0:3001/pending  

#### View blockchain:  
curl http://0.0.0.0:3000/chain  
curl http://0.0.0.0:3001/chain  

#### Update blockchain (resolve first node):  
curl http://0.0.0.0:3000/nodes/resolve  

## Development

TODO: Write development instructions here