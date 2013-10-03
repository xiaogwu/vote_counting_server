require 'sinatra'
#require 'sinatra/reloader'
require 'data_mapper'
require 'json'
#require 'pry'

# Setup Database
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/vote_counter.db")

# Data Models
class Member
  include DataMapper::Resource
  property :id, Serial
  property :name, String, required: true, unique: true
  property :created_at, DateTime
  property :updated_at, DateTime

end

class Vote
  include DataMapper::Resource
  property :id, Serial
  property :vote, String, required: true
  property :agent, String, required: true, unique: true
  property :created_at, DateTime
  property :updated_at, DateTime

end

DataMapper.finalize.auto_upgrade!

# Routes
post '/member' do
  if params.has_key?("agent")
    m = Member.new
    m.name = params[:agent]
    m.created_at = Time.now
    m.updated_at = Time.now
    m.save
  else
    content_type :json
    { status: :error, message: "Agent name not specified."}.to_json
  end
end

post '/vote' do
  if params.has_key?("agent") && params.has_key?("vote")
      if Member.first(name: params[:agent]) && Member.first(name: params[:vote])
        #binding.pry
        v = Vote.first_or_create(agent: params[:agent])
        v.vote = params[:vote]
        v.agent = params[:agent]
        v.created_at = Time.now
        v.updated_at = Time.now
        v.save
      else
        content_type :json
        { status: :error, message: "Agent name and/or Vote is not a member."}.to_json
      end
  else
    content_type :json
    { status: :error, message: "Agent name and/or Vote not specified."}.to_json
  end
end

get '/victory' do
  #binding.pry
  agents = Member.count
  majority = agents / 2.0
  votes = Vote.all
  votes.each do |v|
    count = Vote.all(vote: v.agent).count
    if count > majority
      content_type :json
      return { winner: v.agent}.to_json
    end
  end
  content_type :json
  { winner: "UNKNOWN" }.to_json
end

post '/rst' do
  Vote.all.destroy
  Member.all.destroy
end

not_found do
  halt 404, 'Request Unknown'
end
