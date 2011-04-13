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

ActiveRecord::Schema.define(:version => 20110109150856) do

  create_table "avatars", :force => true do |t|
    t.integer  "user_id"
    t.integer  "strength",     :default => 10
    t.integer  "intelligence", :default => 7
    t.integer  "ability",      :default => 9
    t.integer  "endurance",    :default => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "skillPoints",  :default => 0
  end

  create_table "group_members", :force => true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.boolean  "isInvited",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_members", ["group_id"], :name => "index_group_members_on_group_id"
  add_index "group_members", ["user_id"], :name => "index_group_members_on_user_id"

  create_table "groups", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["user_id"], :name => "index_groups_on_user_id"

  create_table "prestories", :force => true do |t|
    t.string   "teaser"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "prestoryquests", :force => true do |t|
    t.integer  "prestories_id"
    t.string   "description"
    t.integer  "position",      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "prestoryquests", ["prestories_id"], :name => "index_prestoryquests_on_prestories_id"

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "teaser"
    t.integer  "prestories_id", :default => 0
  end

  add_index "projects", ["group_id"], :name => "index_projects_on_group_id"
  add_index "projects", ["user_id"], :name => "index_projects_on_user_id"

  create_table "todo_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "todo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "isQueueDone"
    t.boolean  "isProved"
    t.integer  "gold"
    t.integer  "xp"
  end

  add_index "todo_users", ["todo_id"], :name => "index_todo_users_on_todo_id"
  add_index "todo_users", ["user_id"], :name => "index_todo_users_on_user_id"

  create_table "todos", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "group_id"
    t.boolean  "isChecked"
    t.date     "deadline"
    t.date     "startdate"
    t.float    "estimatedTime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rp_description"
    t.string   "rl_description"
    t.string   "rp_title"
    t.integer  "prestories_quest_id", :default => 0
  end

  add_index "todos", ["group_id"], :name => "index_todos_on_group_id"
  add_index "todos", ["project_id"], :name => "index_todos_on_project_id"
  add_index "todos", ["user_id"], :name => "index_todos_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "street"
    t.string   "zip"
    t.string   "city"
    t.string   "country"
    t.string   "phone"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
