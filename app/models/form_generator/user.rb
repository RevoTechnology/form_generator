require 'form_generator/removal/removal'

module FormGenerator
  class User < ActiveRecord::Base
    include Removal

    def self.available_for organization
      if organization.system?
        where("1=1")
      else
        joins(:organization).where("organization_id = ?", organization.id)
      end
    end

    belongs_to :organization
    attr_accessible :organization_id, :organization
    validates_presence_of :organization_id
    scope :in_organization, lambda {|organization| where(:organization_id => organization.id) }





    attr_accessible :email, :first_name, :last_name, :middle_name, :password, :phone, :remember_me, :password_confirmation
    attr_accessible :admin, :deleted, :demo, :id, :organization_admin, :supervisor

    after_create :set_organization_admin_for_first_user_in_organization

    devise :database_authenticatable, :rememberable

    validates :last_name, :presence => true
    validates :first_name, :presence => true
    validates :middle_name, :presence => true
    validates :email, :presence => true
    validates :email, :uniqueness => true
    #validates :email, :format => { :with => /^[a-zA-Z0-9]+[a-zA-Z0-9\.\_\%\-\+]*[a-zA-Z0-9]+@(?:[a-zA-Z0-9\-]+\.)+[A-Za-z]{2,6}$/ }

    scope :except_admin, where(:admin => false)
    scope :admin, where(:admin => true)
    scope :except_organization_admin, where(:organization_admin => false)
    scope :organization_admin, where(:organization_admin => true)
    scope :except_user, lambda{ |user| where{{id.not_eq => user.id}} }
    scope :from_organization, lambda{ |organization| where{{organization_id.eq => organization.id}} }
    scope :supervisor, where(:supervisor => true)
    scope :demo, where(:demo => true)

  #  scope :admins, where("organization_admin = 't' OR supervisor = 't'")
  #  scope :not_admins, where("organization_admin = 'f' AND supervisor = 'f'")

    def full_name
      [last_name, first_name, middle_name].join(" ")
    end

    def set_admin
      remove_all_rights
      update_attribute :admin, true
    end

    def remove_admin
      update_attribute :admin, false
    end

    def set_organization_admin
      remove_all_rights
      update_attribute :organization_admin, true
    end

    def remove_organization_admin
      update_attribute :organization_admin, false
    end

    def set_supervisor_role
      remove_all_rights
      update_attribute :supervisor, true
    end

    def remove_supervisor_role
      update_attribute :supervisor, false
    end

    def remove_organization_admin
      update_attribute :organization_admin, false
    end

    def not_system_organization_admin?
      self.organization_admin? && !self.admin?
    end

    def simple_user?
      !self.organization_admin? && !self.admin? && !self.supervisor?
    end

    def set_demo_role
      update_attribute :demo, true
    end

    def remove_demo_role
      update_attribute :demo, false
    end

    private
      def remove_all_rights
        update_attribute :supervisor, false
        update_attribute :organization_admin, false
        update_attribute :admin, false
      end

      def set_organization_admin_for_first_user_in_organization
        set_organization_admin if self.organization.users.count == 1
      end

      # handle_asynchronously :send_password
  end
end