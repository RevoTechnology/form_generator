FormGenerator::Engine.routes.draw do
  match "api/order.(:format)" => "api#order", :via => [:get, :post, :options]
  match "api/unpublish.(:format)" => "api#unpublish",  :via => [:get, :post, :options]
  match "api/delete.(:format)" => "api#delete",  :via => [:get, :post, :options]

  get "public_data/order/:version_id.:public_hash.js", :controller => "public/js", :action => "public", :as => :public_js_data
  get "public_data/order/:version_id.:public_hash.css", :controller => "public/css", :action => "public", :as => :public_css_data
end
