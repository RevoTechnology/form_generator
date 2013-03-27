module FormGenerator
  module Removal  
    def soft_delete
      update_attribute :deleted, true
    end

    # If you want to see deleted objects(users, categories, fields, etc.), write in console Object.unscoped.where(:deleted => true)
    def self.included(base)
      base.class_eval do
        default_scope where(:deleted => false)
      end
    end
  end
end