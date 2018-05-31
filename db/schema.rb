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

ActiveRecord::Schema.define(:version => 20180531061119) do

  create_table "book_relationships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.integer  "status_id",  :limit => 255, :default => 1
    t.string   "rating"
    t.string   "review"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "book_relationships", ["book_id"], :name => "index_book_relationships_on_book_id"
  add_index "book_relationships", ["user_id", "book_id"], :name => "index_book_relationships_on_user_id_and_book_id", :unique => true
  add_index "book_relationships", ["user_id", "status_id"], :name => "index_book_relationships_on_user_id_and_status"
  add_index "book_relationships", ["user_id"], :name => "index_book_relationships_on_user_id"

  create_table "books", :force => true do |t|
    t.string   "title"
    t.string   "isbn_number"
    t.string   "author"
    t.string   "synopsis"
    t.string   "published_year"
    t.string   "language"
    t.string   "cover"
    t.string   "publisher"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "books", ["isbn_number"], :name => "index_books_on_isbn_number"

  create_table "status_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "name"
    t.string   "perishable_token"
    t.boolean  "admin",             :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
