# Stateful Vote-Counting Server

## Objectives:
* Stateful
* RESTful
* Register voting member agents
* Cast votes for member agents
* Determine majority winner
* Reset server state
* Accept HTTP GETs and POSTs
* Respond with JSON

### Phase 1
0. General functionality

### Phase 2
0. Testing (Sorry Jakie!)
1. Redo modeling to reduce logic in code
1. Migrate to Postgres
2. Deploy to Heroku

### Phase 3
0. Rewrite in Rails
1. Authentication (Token keys)
2. Account for more edge cases

## Design desicions
* Started using Sinatra because this was suppose to be a "little" webserver
* Used DataMapper for data model layer.  Should of used ActiveRecord (more
  familar)
* Want to rewrite in Rails and maybe use RABL

## Lessons Learned
* Learned to use Postman Chrome extension to send POST requests
* Rack has builtin attack prevention
