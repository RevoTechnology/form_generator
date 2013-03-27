require 'form_generator/removal/removal'
module FormGenerator
  class Category < ActiveRecord::Base
    include Removal

    attr_accessible :name
    attr_accessible :organization_id, :organization

    has_many :fields, :dependent => :destroy

    validates :name, :presence => true
    validates_uniqueness_of :name, :scope => :organization_id

    def self.available_for organization
      if organization.system?
        where("1=1")
      else
        joins(:organization).where("organizations.system = ? OR organization_id = ?", true, organization.id)
      end
    end

    belongs_to :organization
    validates_presence_of :organization_id
    scope :in_organization, lambda {|organization| where(:organization_id => organization.id) }


    # def json_for_builder
    #   map{|c| {:name => "category_#{c.id}", :label => c.name}}.to_json.html_safe
    # end
  end
end