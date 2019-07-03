module FormGenerator
  class Field < ActiveRecord::Base
    has_and_belongs_to_many :organizations
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
    scope :in_organization, lambda { |organization| where(:organization_id => organization.id) }


    validates :body, :presence => true

    def list_from_categories_json_for_builder
      result = {}
      group_by(&:category_id).each{|c, f| result["category_#{c}"] = f.map{|f| {:name => "field_#{f.id}", :label => f.name }}}
      result.to_json.html_safe
    end

    def list_with_prototypes_json_for_builder
      result = {}
      each{|f| result["field_#{f.id}"] = YAML.load(f.body) }
      result.to_json.html_safe
    end
  end
end
