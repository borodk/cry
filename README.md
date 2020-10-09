# cry

TODO: Write a description here

## Installation

TODO: Write installation instructions here

## Usage

REGISTER 2ND NODE TO FIRST NODE:
curl -X POST http://0.0.0.0:3000/nodes/register -H "Content-Type: application/json" -d '{"nodes": ["http://0.0.0.0:3001"]}'
New nodes have been added: Set{"http://0.0.0.0:3001"}%

ADD TRANSACTIONS:
curl -X POST http://0.0.0.0:3000/transactions/new -H "Content-Type: application/json" -d '{"from": "odin", "to":"tom", "amount": 11.11}'
curl -X POST http://0.0.0.0:3001/transactions/new -H "Content-Type: application/json" -d '{"from": "fnu", "to":"batman", "amount": 777}'

MINE:
curl http://0.0.0.0:3001/mine

VIEW PENDING TRANSACTIONS:
curl http://0.0.0.0:3001/pending

VIEW CHAIN:
curl http://0.0.0.0:3000/chain
curl http://0.0.0.0:3001/chain

UPDATE CHAIN:
curl http://0.0.0.0:3000/nodes/resolve

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/your-github-user/cry/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [your-name-here](https://github.com/your-github-user) - creator and maintainer
