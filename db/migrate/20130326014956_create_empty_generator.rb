# This migration comes from generator (originally 20120217091942)
class CreateEmptyGenerator < ActiveRecord::Migration
  def change
    create_table "form_generator_fields", :force => true do |t|
      t.string  "name",            :default => "",    :null => false
      t.integer "category_id"
      t.text    "body",            :default => "",    :null => false
      t.integer "organization_id"
      t.boolean "deleted",         :default => false
      t.integer "builder_id"
    end

    add_index "form_generator_fields", ["category_id"], :name => "index_fields_on_category_id"
    add_index "form_generator_fields", ["organization_id"], :name => "index_fields_on_organization_id"

    create_table "fields_organizations", :id => false, :force => true do |t|
      t.integer "field_id"
      t.integer "organization_id"
    end

    create_table "form_generator_order_versions", :force => true do |t|
      t.string   "description",   :default => "",    :null => false
      t.text     "body",          :default => "",    :null => false
      t.boolean  "published",     :default => false
      t.integer  "major_version", :default => 0
      t.integer  "minor_version", :default => 1
      t.datetime "created_at",                       :null => false
      t.datetime "updated_at",                       :null => false
      t.integer  "order_id"
      t.integer  "skin_id"
      t.integer  "user_id"
      t.boolean  "in_review",     :default => false
      t.boolean  "deleted",       :default => false
      t.integer  "builder_id"
    end

    add_index "form_generator_order_versions", ["order_id"], :name => "index_order_versions_on_order_id"
    add_index "form_generator_order_versions", ["user_id"], :name => "index_order_versions_on_user_id"

    create_table "form_generator_orders", :force => true do |t|
      t.string  "description",     :default => "",    :null => false
      t.text    "body",            :default => "",    :null => false
      t.integer "organization_id"
      t.string  "public_hash"
      t.integer "skin_id",         :default => 1,     :null => false
      t.string  "version",         :default => "0.1"
      t.boolean "to_delete",       :default => false
      t.integer "deleted_by"
      t.boolean "deleted",         :default => false
      t.integer "builder_id"
    end

    add_index "form_generator_orders", ["organization_id"], :name => "index_orders_on_organization_id"

    create_table "form_generator_organizations", :force => true do |t|
      t.string  "name",                          :default => "",    :null => false
      t.text    "server_urls",    :limit => 255, :default => "",    :null => false
      t.string  "latin_name"
      t.boolean "system",                        :default => false
      t.integer "generator_port",                :default => 80
      t.string  "generator_url",                 :default => "",    :null => false
      t.boolean "deleted",                       :default => false
      t.integer "builder_id"
    end

    create_table "organizations_validations", :id => false, :force => true do |t|
      t.integer "validation_id"
      t.integer "organization_id"
    end

    add_index "organizations_validations", ["organization_id", "validation_id"], :name => "index_organizations_validations"

    create_table "form_generator_skins", :force => true do |t|
      t.string  "title",           :default => "",           :null => false
      t.string  "body",            :default => "",           :null => false
      t.integer "organization_id", :default => 1,            :null => false
      t.text    "custom_css"
      t.string  "width",           :default => "100%"
      t.string  "height",          :default => "100%"
      t.boolean "deleted",         :default => false
      t.string  "flow",            :default => "horizontal"
      t.integer "builder_id"
    end

    create_table "form_generator_validations", :force => true do |t|
      t.string  "name",                  :default => "",    :null => false
      t.string  "regexp",                :default => "",    :null => false
      t.string  "default_error_message", :default => "",    :null => false
      t.integer "organization_id",       :default => 1
      t.boolean "deleted",               :default => false
      t.integer "builder_id"
    end
  end
end
