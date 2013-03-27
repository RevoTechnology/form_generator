# This migration comes from generator (originally 20120911133755)
class AddBodyToOrganization < ActiveRecord::Migration
  def change
    add_column :form_generator_organizations, :body, :text
  end
end
