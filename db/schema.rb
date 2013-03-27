# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130325131800) do

  create_table "applications", :force => true do |t|
  end

  create_table "categories", :force => true do |t|
    t.string  "name",            :default => "",    :null => false
    t.integer "organization_id", :default => 1
    t.boolean "deleted",         :default => false
  end

  create_table "categories_organizations", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "organization_id"
  end

  add_index "categories_organizations", ["category_id", "organization_id"], :name => "index_categories_organizations"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "dictionary_cities", :force => true do |t|
    t.string  "name",                 :default => "", :null => false
    t.integer "dictionary_region_id",                 :null => false
  end

  add_index "dictionary_cities", ["dictionary_region_id"], :name => "index_dictionary_cities_on_dictionary_region_id"

  create_table "dictionary_districts", :force => true do |t|
    t.string "name", :default => "", :null => false
  end

  create_table "dictionary_regions", :force => true do |t|
    t.string  "name",                   :default => "", :null => false
    t.integer "dictionary_district_id",                 :null => false
  end

  add_index "dictionary_regions", ["dictionary_district_id"], :name => "index_dictionary_regions_on_dictionary_district_id"

  create_table "dictionary_streets", :force => true do |t|
    t.string  "name",                  :default => "", :null => false
    t.integer "dictionary_city_id",                    :null => false
    t.integer "dictionary_zipcode_id",                 :null => false
  end

  add_index "dictionary_streets", ["dictionary_city_id"], :name => "index_dictionary_streets_on_dictionary_city_id"
  add_index "dictionary_streets", ["dictionary_zipcode_id"], :name => "index_dictionary_streets_on_dictionary_zipcode_id"

  create_table "dictionary_zipcodes", :force => true do |t|
    t.integer "number", :null => false
  end

  create_table "fias_addrobjs", :force => true do |t|
    t.string  "aoid",       :limit => 36
    t.string  "aoguid",     :limit => 36
    t.string  "offname",    :limit => 120
    t.string  "shortname",  :limit => 10
    t.integer "aolevel"
    t.string  "parentguid", :limit => 36
    t.integer "centstatus"
    t.string  "postalcode", :limit => 6
    t.string  "regioncode", :limit => 1
    t.string  "autocode",   :limit => 1
    t.string  "areacode",   :limit => 3
    t.string  "citycode",   :limit => 3
    t.string  "ctarcode",   :limit => 3
    t.string  "placecode",  :limit => 3
    t.string  "streetcode", :limit => 4
    t.string  "extrcode",   :limit => 4
    t.string  "sextcode",   :limit => 3
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
  end

  create_table "fias_shortnames", :force => true do |t|
    t.integer "level"
    t.string  "socrname", :limit => 40
    t.string  "scname",   :limit => 10
  end

  create_table "fields", :force => true do |t|
    t.string  "name",            :default => "",    :null => false
    t.integer "category_id"
    t.text    "body",            :default => "",    :null => false
    t.integer "organization_id"
    t.boolean "deleted",         :default => false
    t.integer "builder_id"
  end

  add_index "fields", ["category_id"], :name => "index_fields_on_category_id"
  add_index "fields", ["organization_id"], :name => "index_fields_on_organization_id"

  create_table "fields_organizations", :id => false, :force => true do |t|
    t.integer "field_id"
    t.integer "organization_id"
  end

  create_table "order_versions", :force => true do |t|
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

  add_index "order_versions", ["order_id"], :name => "index_order_versions_on_order_id"
  add_index "order_versions", ["user_id"], :name => "index_order_versions_on_user_id"

  create_table "orders", :force => true do |t|
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

  add_index "orders", ["organization_id"], :name => "index_orders_on_organization_id"

  create_table "organizations", :force => true do |t|
    t.string  "name",                          :default => "",    :null => false
    t.text    "server_urls",    :limit => 255, :default => "",    :null => false
    t.string  "latin_name"
    t.boolean "system",                        :default => false
    t.integer "generator_port",                :default => 80
    t.string  "generator_url",                 :default => "",    :null => false
    t.boolean "deleted",                       :default => false
    t.integer "builder_id"
    t.text    "body"
  end

  create_table "organizations_validations", :id => false, :force => true do |t|
    t.integer "validation_id"
    t.integer "organization_id"
  end

  add_index "organizations_validations", ["organization_id", "validation_id"], :name => "index_organizations_validations"

  create_table "partners", :force => true do |t|
    t.string  "name",            :default => "",    :null => false
    t.integer "organization_id",                    :null => false
    t.boolean "deleted",         :default => false
    t.string  "status"
    t.integer "builder_id"
  end

  create_table "product_relations", :force => true do |t|
    t.integer "product_id", :null => false
    t.integer "order_id",   :null => false
    t.integer "partner_id", :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "name",            :default => "", :null => false
    t.integer  "organization_id",                 :null => false
    t.integer  "builder_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skins", :force => true do |t|
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

  create_table "users", :force => true do |t|
    t.string   "email",               :default => "",    :null => false
    t.string   "encrypted_password",  :default => "",    :null => false
    t.boolean  "admin",               :default => false, :null => false
    t.string   "first_name",          :default => "",    :null => false
    t.string   "last_name",           :default => "",    :null => false
    t.string   "middle_name",         :default => "",    :null => false
    t.datetime "remember_created_at"
    t.integer  "organization_id"
    t.boolean  "organization_admin",  :default => false
    t.boolean  "supervisor",          :default => false
    t.string   "phone"
    t.boolean  "deleted",             :default => false
    t.boolean  "demo",                :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["organization_id"], :name => "index_users_on_organization_id"

  create_table "validations", :force => true do |t|
    t.string  "name",                  :default => "",    :null => false
    t.string  "regexp",                :default => "",    :null => false
    t.string  "default_error_message", :default => "",    :null => false
    t.integer "organization_id",       :default => 1
    t.boolean "deleted",               :default => false
    t.integer "builder_id"
  end

end
