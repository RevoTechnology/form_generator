module FormGenerator
  class Product < ActiveRecord::Base
    belongs_to :organization
    
    has_many :product_relations
    attr_accessible :builder_id, :name, :organization_id
    def partners
      self.product_relations.map(:parther)
    end
    
    def orders
      self.product_relations.map(:order)
    end

  	def self.available_for organization
      if organization.system?
        where("1=1")
      else
        puts self.class
        joins(:organization).where("organizations.system = ? OR organization_id = ?", true, organization.id)
      end
    end
  end
end