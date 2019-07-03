module FormGenerator
  class Skin < ActiveRecord::Base
    has_many :orders
    validates :title, :presence => true
    validates_uniqueness_of :title, :scope => :organization_id

    def self.available_for organization
      if organization.system?
        where("1=1")
      else
        puts self.class
        joins(:organization).where("organizations.system = ? OR organization_id = ?", true, organization.id)
      end
    end

    belongs_to :organization
    validates_presence_of :organization_id
    scope :in_organization, lambda { |organization| where(:organization_id => organization.id) }
    validates :body, :presence => true
    validates :width, :presence => true
    validates :height, :presence => true
  end
end
