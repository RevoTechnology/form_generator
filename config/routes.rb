FormGenerator::Engine.routes.draw do
  # root :to => 'frontend#index'
  match "api/order.(:format)" => "api#order"
  match "api/unpublish.(:format)" => "api#unpublish"
  match "api/delete.(:format)" => "api#delete"

  match '/:organization_latin_name/=:public_hash(/:partner/:product)', :controller => "public/forms", :action => "show", :as => :public_form
  match "/send_data", :controller => "public/forms", :action => "send_data", :as => :send_data

  namespace :public do
    match 'dictionary/zip_code/data', :controller => "dictionaries", :action => "zip_code_data", :as => :zip_code_data
    match 'dictionary/suggestion/:parameter', :controller => "dictionaries", :action => "suggestion", :as => :suggestion

    match 'dictionary/region', :controller => "dictionaries", :action => "region", :as => :suggest_region
    match 'dictionary/city', :controller => "dictionaries", :action => "city", :as => :suggest_city
    match 'dictionary/street', :controller => "dictionaries", :action => "street", :as => :suggest_street
    match 'dictionary/fias', :controller => "dictionaries", :action => "fias", :as => :suggest_fias
  end

  match "public_data/order/:version_id.:public_hash.js", :controller => "public/js", :action => "public", :as => :public_js_data
  match "public_data/order/:version_id.:public_hash.css", :controller => "public/css", :action => "public", :as => :public_css_data

  match "preview_data/order/:id/version/:version_id.js", :controller => "public/js", :action => "preview", :as => :preview_js_data
  match "preview_data/order/:id/version/:version_id.css", :controller => "public/css", :action => "preview", :as => :preview_css_data
end
