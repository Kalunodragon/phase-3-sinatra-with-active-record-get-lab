class ApplicationController < Sinatra::Base

  # add routes
  set :default_content_type, 'application/json'

  get '/bakeries' do
    all = Bakery.all
    all.to_json
  end

  get '/bakeries/:id' do
    found = Bakery.find(params[:id])
    found.to_json(include: :baked_goods)
  end

  get '/baked_goods/:value' do
    type = if params[:value] == 'by_price'
              BakedGood.all.order(price: :DESC)
           elsif params[:value] == 'most_expensive'
              BakedGood.all.order(price: :DESC).first
           end
    type.to_json
  end

end
