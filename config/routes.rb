FormGenerator::Engine.routes.draw do
  match "api/order.(:format)" => "api#order"
  match "api/unpublish.(:format)" => "api#unpublish"
  match "api/delete.(:format)" => "api#delete"

  match "public_data/order/:version_id.:public_hash.js", :controller => "public/js", :action => "public", :as => :public_js_data
  match "public_data/order/:version_id.:public_hash.css", :controller => "public/css", :action => "public", :as => :public_css_data
end
