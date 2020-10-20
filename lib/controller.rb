require 'bundler'
Bundler.require

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id/' do
    "Voici le numéro du potin que tu veux : #{params['id']}!"
    erb :show, locals: {gossips: Gossip.find(params['id'].to_i)}
  end

  get '/gossips/:id/edit/' do
    erb :edit
  end

  post '/gossips/:id/edit/' do
    Gossip.update(params['id'].to_i, params["gossip_author"], params["gossip_content"])
    redirect '/'
  end
end