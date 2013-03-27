module FormGenerator
  class ProductRelation < ActiveRecord::Base
  	belongs_to :partner
  	belongs_to :order
  	belongs_to :product
  	
    attr_accessible :product_id, :order_id, :partner_id
  end
end