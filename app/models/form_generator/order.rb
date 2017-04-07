# encoding: UTF-8
require 'form_generator/cream/cream'

module FormGenerator
  class Order < ActiveRecord::Base
    #TODO: отрефакторить этот класс
    include ::FormGenerator::Cream

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

    belongs_to :skin
    has_many :order_versions, :dependent => :destroy

    validates :body, :presence => true

    def published?
      self.order_versions.first.try(:published?)
    end

    def last_version
      self.order_versions.first
    end

    def published_version
      self.order_versions.published.first
    end

    def unpublish_all_versions
      # TODO: Need to make it faster.
      order_versions.each{ |v| v.update_attribute :published, false }
    end

    def set_for_deletion
      update_attribute :to_delete, true
    end

    def in_review?
      self.order_versions.where(:in_review => true).present?
    end

    def set_deleted_by user
      self.update_attribute :deleted_by, user.id
    end

    def restore
      update_attribute :to_delete, false
    end

    def send_to_server
     true
    end

  end
end
