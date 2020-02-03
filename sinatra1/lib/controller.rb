require "gossip"

class ApplicationController < Sinatra::Base
  get "/gossips/new/" do
    erb :new_gossip
  end

  post "/gossips/new/" do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect "/"
  end

  get "/" do
    erb :index, locals: { gossips: Gossip.all }
  end

  get "/gossips/:id/" do
    a = params['id']
    erb :show, locals: { gossip_id: a.to_i, gossip_author: Gossip.find_author(a.to_i), gossip_content: Gossip.find_content(a.to_i) }
  end

  get "/gossips/:id/edit/" do
    a = params['id']
    erb :edit, locals: { id_of_url: a.to_i}
  end
end
