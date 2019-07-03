module FormGenerator
  class FrontendController < ApplicationController
    protect_from_forgery except: :public
  end
end
