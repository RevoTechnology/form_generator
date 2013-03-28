FormGenerator::Engine.routes.draw do
  namespace "api" do
    match "order.(:format)" => "api#order"
    match "unpublish.(:format)" => "api#unpublish"
    match "delete.(:format)" => "api#delete"
  end

  match "public_data/order/:version_id.:public_hash.js", :controller => "public/js", :action => "public", :as => :public_js_data
  match "public_data/order/:version_id.:public_hash.css", :controller => "public/css", :action => "public", :as => :public_css_data
end
