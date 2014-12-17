module FormGenerator
  class Organization < ActiveRecord::Base
    attr_accessible :system
    attr_accessible :name, :latin_name
    attr_accessible :server_urls, :generator_url, :generator_port
    attr_accessible :builder_id, :deleted, :id
    attr_accessible :body

    has_many :orders #, :dependent => :destroy
    has_many :skins #, :dependent => :destroy
    has_many :fields #, :dependent => :destroy
    has_and_belongs_to_many :fields
    has_and_belongs_to_many :validations

    validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 100 }
    # validates :server_url, :format => { :with => /^(https?:\/\/)?(www\.)?([\w\d\-\_\.]+)+(\.([\w\d]{1,6}))+(\/[\w\W\d\.\/]+)*$/ }, :allow_blank => true
    # validates :server_port, :format => { :with => /^(6553[0-5]|655[0-2]\d|65[0-4]\d\d|6[0-4]\d{3}|[1-5]\d{4}|[1-9]\d{0,3}|0)$/ }, :allow_blank => true
    validates :generator_url, :format => { :with => /\A(https?:\/\/)?(www\.)?([\w\d\-\_\.]+)+(\.([\w\d]{1,6}))?+(\/[\w\W\d\.\/]+)*\z/ }, :allow_blank => true
    validates :generator_port, :format => { :with => /\A(6553[0-5]|655[0-2]\d|65[0-4]\d\d|6[0-4]\d{3}|[1-5]\d{4}|[1-9]\d{0,3}|0)\z/ }, :allow_blank => true

    scope :not_system, ->{ where(:system => false) }
    scope :is_system, ->{ where(:system => true) }

    #default_scope where(:deleted => false)

    def supervisor
      users.where(:supervisor => true).first
    end

    def full_server_urls
      server_urls.try( :split, "\n").try( :map, &:strip )
    end

    def full_generator_url
      [correct_generator_url, correct_generator_port].join(":")
    end

    def correct_generator_url
      (generator_url.include?("http://") || generator_url.include?("https://")) ? generator_url : "http://#{generator_url}"
    end

    def correct_generator_port
      (generator_port.nil? || generator_port == 80) ? nil : generator_port
    end

    # def soft_delete
    #     update_attribute :deleted, true
    #   end
  end
end
