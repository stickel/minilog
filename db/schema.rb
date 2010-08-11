# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100811043741) do

  create_table "comments", :force => true do |t|
    t.integer  "post_id"
    t.string   "name"
    t.string   "email"
    t.string   "url"
    t.text     "comment"
    t.text     "comment_raw"
    t.string   "ip"
    t.boolean  "is_approved", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "title",      :limit => 128
    t.string   "permalink",  :limit => 128
    t.text     "body"
    t.text     "body_raw"
    t.boolean  "is_active",                 :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "page_order"
    t.boolean  "in_nav"
  end

  create_table "people", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
    t.text     "information"
    t.text     "information_raw"
  end

  add_index "people", ["login"], :name => "index_people_on_login", :unique => true

  create_table "posts", :force => true do |t|
    t.integer  "person_id",                                        :null => false
    t.string   "permalink",      :limit => 128
    t.string   "title"
    t.text     "summary"
    t.text     "body"
    t.text     "body_raw"
    t.boolean  "is_active",                     :default => true
    t.boolean  "comment_status",                :default => false
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts_tags", :id => false, :force => true do |t|
    t.integer "post_id"
    t.integer "tag_id"
  end

  create_table "preferences", :force => true do |t|
    t.string "title",       :null => false
    t.string "name",        :null => false
    t.text   "description", :null => false
    t.text   "value",       :null => false
  end

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "uploads", :force => true do |t|
    t.integer  "post_id"
    t.string   "caption"
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.string   "upload_file_size"
    t.datetime "upload_updated_at"
  end

end
