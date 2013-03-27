# This migration comes from generator (originally 20120911133756)
class AddBodyToProduct < ActiveRecord::Migration
  def change
    add_column :form_generator_products, :body, :text
    add_column :form_generator_products, :created_at, :datetime
    add_column :form_generator_products, :updated_at, :datetime
  end
end
