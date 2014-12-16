module FormGenerator
  class ApplicationController < ActionController::Base
    protect_from_forgery except: :public
  end
end