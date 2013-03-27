require 'form_generator/removal/removal'

module FormGenerator
  class Partner < ActiveRecord::Base
    include Removal
    
    has_and_belongs_to_many :orders
    belongs_to :organization
    
    validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 100 }
    attr_accessible :name, :status
    attr_accessible :organization_id, :organization
    attr_accessible :builder_id
    validates_presence_of :organization_id

    
    ACTIVATED = 'a'
    DEACTIVATED = 'd'
    
    STATUSES = ['activated', 'deactivated']
    
    def status_value
      STATUSES[status]
    end
    
    def blocked
      update_attribute :status, 'd'
    end
    
    def unblocked
      update_attribute :status, 'a'
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