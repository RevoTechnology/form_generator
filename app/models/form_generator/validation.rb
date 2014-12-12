# encoding: UTF-8

module FormGenerator
  class Validation < ActiveRecord::Base
    has_and_belongs_to_many :organizations

    validates :name, :presence => true
    validates_uniqueness_of :name, :scope => :organization_id

    def self.available_for organization
      if organization.system?
        where("1=1")
      else
        puts self.class
        joins(:organization).where("organizations.system = ? OR organization_id = ?", true, organization.id)
      end
    end

    belongs_to :organization
    attr_accessible :organization_id, :organization
    validates_presence_of :organization_id
    scope :in_organization, lambda { |organization| where(:organization_id => organization.id) }

    attr_accessible :name, :regexp, :default_error_message, :id, :deleted

    validates :regexp, :presence => true, :format => { :with => /^\/.+\/$/ }
    validates :default_error_message, :presence => true, :length => { :maximum => 100 }
  end
end