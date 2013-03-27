# encoding: UTF-8
require 'form_generator/cream/cream'
require 'form_generator/removal/removal'
module FormGenerator
  class OrderVersion < ActiveRecord::Base
    #TODO: отрефакторить этот класс
    include Cream, Removal

    attr_accessible :description, :body, :published, :major_version, :minor_version, :order_id, :skin_id, :user_id, :in_review, :deleted, :builder_id, :created_at, :id, :updated_at

    validates :body, :presence => true

    belongs_to :user
    belongs_to :order
    belongs_to :skin

    default_scope order('major_version DESC').order('minor_version DESC')
    scope :published, where(:published => true)
    scope :recent, order("created_at desc").limit(5)

    def version
      "#{major_version}.#{minor_version}"
    end

    def author_name
      user.full_name
    end

    def next
      self.order.order_versions.unscoped.where(["id > ?", id]).where(["order_id = ?", self.order.id]).first
    end

    def previous
      self.order.order_versions.where(["id < ?", id]).first
    end

    def increment_minor
      self.minor_version += 1
    end

    def increment_major
      self.major_version += 1 and self.minor_version = 0
    end

    def set_for_publish_review
      update_attribute :in_review, true
    end

    def remove_from_publish_review
      update_attribute :in_review, false
    end

    def publish
      increment_major if minor_version > 0
      self.published = true

      if save
        order.order_versions.published.where("id != #{id}").each { |v| v.update_attribute :published, false }
        order.update_attribute :version, version
        send_to_server if order.organization.full_server_urls.first != nil
      end
    end


    def rebase
      commit = OrderVersion.stage self
      commit.major_version, commit.minor_version = OrderVersion.get_last_version commit.order
      commit.increment_minor
      commit.published = false

      if commit.save
        OrderVersion.published.where(["id != ?", commit.id]).each { |v| v.update_attribute :published, false }
        commit.order.update_attribute :version, commit.version
      end
    end


    class << self
      def get_last_version order
        last = order.order_versions.order('major_version DESC').order('minor_version DESC').first
        last ? [last.major_version, last.minor_version] : [0, 0]
      end

      def stage_version version
        version.dup
      end

      def stage_order order
        order.order_versions.new :description => order.description,
          :body => order.body,
          :skin_id => order.skin_id
      end

      def stage object
        if object.class.name == "OrderVersion"
          stage_version object
        elsif object.class.name == "Order"
          stage_order object
        end
      end

      def commit order, user, options = {}
        major_version, minor_version = get_last_version order
        commit = stage order
        commit.user_id = user.id

        commit.major_version, commit.minor_version =
          options[:major] ? [major_version + 1, 0] : [major_version, minor_version + 1]
        if commit.save
          # return commit
          order.update_attribute :version, commit.version
        end
      end
    end
  end
end