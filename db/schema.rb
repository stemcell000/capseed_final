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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171115161418) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"
  enable_extension "fuzzystrmatch"
  enable_extension "unaccent"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "assays", force: :cascade do |t|
    t.string   "name"
    t.boolean  "display"
    t.integer  "step",       default: 0
    t.text     "comment"
    t.integer  "row_order"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "locked",     default: false
    t.integer  "last_step",  default: 0
    t.date     "today_date"
    t.float    "percentage", default: 0.0
    t.integer  "user_id"
  end

  create_table "assays_projects", force: :cascade do |t|
    t.integer "assay_id"
    t.integer "project_id"
  end

  add_index "assays_projects", ["assay_id", "project_id"], name: "index_assays_projects_on_assay_id_and_project_id", unique: true, using: :btree
  add_index "assays_projects", ["assay_id"], name: "index_assays_projects_on_assay_id", using: :btree
  add_index "assays_projects", ["project_id"], name: "index_assays_projects_on_project_id", using: :btree

  create_table "boxes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clone_attachments", force: :cascade do |t|
    t.integer  "clone_id"
    t.string   "attachment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clone_batch_as_plasmid_attachments", force: :cascade do |t|
    t.integer  "clone_batch_id"
    t.string   "attachment"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "clone_batch_attachments", force: :cascade do |t|
    t.integer  "clone_batch_id"
    t.string   "attachment"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "clone_batch_qcs", force: :cascade do |t|
    t.integer  "clone_batch_id"
    t.date     "date_send"
    t.date     "date_rec"
    t.text     "result"
    t.boolean  "conclusion"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
    t.integer  "pcr_colony_id"
    t.string   "primer1"
    t.string   "primer2"
    t.date     "date_send2"
    t.integer  "sequencing_id"
    t.integer  "primer_id"
    t.string   "name"
  end

  add_index "clone_batch_qcs", ["clone_batch_id"], name: "index_clone_batch_qcs_on_clone_batch_id", using: :btree

  create_table "clone_batch_qcs_batches", force: :cascade do |t|
    t.integer "clone_batch_id"
    t.integer "clone_batch_qc_id"
  end

  add_index "clone_batch_qcs_batches", ["clone_batch_id"], name: "index_clone_batch_qcs_batches_on_clone_batch_id", using: :btree
  add_index "clone_batch_qcs_batches", ["clone_batch_qc_id"], name: "index_clone_batch_qcs_batches_on_clone_batch_qc_id", using: :btree

  create_table "clone_batch_qcs_qc_attachments", force: :cascade do |t|
    t.integer "clone_batch_qc_id"
    t.integer "qc_attachment_id"
  end

  add_index "clone_batch_qcs_qc_attachments", ["clone_batch_qc_id"], name: "index_clone_batch_qcs_qc_attachments_on_clone_batch_qc_id", using: :btree
  add_index "clone_batch_qcs_qc_attachments", ["qc_attachment_id"], name: "index_clone_batch_qcs_qc_attachments_on_qc_attachment_id", using: :btree

  create_table "clone_batches", force: :cascade do |t|
    t.string   "name"
    t.string   "temp_name"
    t.text     "comment"
    t.boolean  "qc_validation",             default: false
    t.integer  "strict_validation",         default: 0
    t.integer  "plasmid_validation",        default: 0
    t.date     "date_as_plasmid"
    t.string   "glyc_stock_box_as_plasmid"
    t.string   "origin_as_plasmid"
    t.text     "comment_as_plasmid"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "type_id"
    t.integer  "clone_id"
    t.string   "number"
    t.integer  "strand_id"
    t.integer  "production_id"
  end

  create_table "clones", force: :cascade do |t|
    t.integer  "assay_id"
    t.string   "name"
    t.string   "bbnb"
    t.integer  "batch_nb"
    t.string   "primerinsfor"
    t.string   "primerinsrev"
    t.text     "comment"
    t.text     "comment_batch"
    t.integer  "strict_validation", default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "cmeth_id"
  end

  add_index "clones", ["assay_id"], name: "index_clones_on_assay_id", using: :btree

  create_table "clones_enzymes", force: :cascade do |t|
    t.integer "clone_id",  null: false
    t.integer "enzyme_id", null: false
  end

  create_table "clones_inserts", force: :cascade do |t|
    t.integer "clone_id"
    t.integer "insert_id"
  end

  add_index "clones_inserts", ["clone_id"], name: "index_clones_inserts_on_clone_id", using: :btree
  add_index "clones_inserts", ["insert_id"], name: "index_clones_inserts_on_insert_id", using: :btree

  create_table "cmeths", force: :cascade do |t|
    t.string "name"
  end

  create_table "columns", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enzymes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "formats", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "genes", force: :cascade do |t|
    t.string  "name"
    t.integer "clone_batch_id"
  end

  create_table "inserts", force: :cascade do |t|
    t.integer  "clone_batch_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number"
  end

  add_index "inserts", ["clone_batch_id"], name: "index_inserts_on_clone_batch_id", using: :btree

  create_table "pcr_colonies", force: :cascade do |t|
    t.string "name"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "pg_search_documents", ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id", using: :btree

  create_table "plasmid_batch_attachments", force: :cascade do |t|
    t.integer  "plasmid_batch_id"
    t.string   "attachment"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "plasmid_batch_qcs", force: :cascade do |t|
    t.integer  "plasmid_batch_id"
    t.string   "dig_other"
    t.text     "comments"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.boolean  "conclusion"
    t.integer  "pcr_colony_id"
    t.string   "primer1"
    t.string   "primer2"
    t.date     "date_send"
    t.string   "sma1"
  end

  add_index "plasmid_batch_qcs", ["plasmid_batch_id"], name: "index_plasmid_batch_qcs_on_plasmid_batch_id", using: :btree

  create_table "plasmid_batch_qcs_batches", force: :cascade do |t|
    t.integer "plasmid_batch_id"
    t.integer "plasmid_batch_qc_id"
  end

  add_index "plasmid_batch_qcs_batches", ["plasmid_batch_id"], name: "index_plasmid_batch_qcs_batches_on_plasmid_batch_id", using: :btree
  add_index "plasmid_batch_qcs_batches", ["plasmid_batch_qc_id"], name: "index_plasmid_batch_qcs_batches_on_plasmid_batch_qc_id", using: :btree

  create_table "plasmid_batch_qcs_qc_attachments", force: :cascade do |t|
    t.integer "plasmid_batch_qc_id"
    t.integer "qc_attachment_id"
  end

  add_index "plasmid_batch_qcs_qc_attachments", ["plasmid_batch_qc_id"], name: "index_plasmid_batch_qcs_qc_attachments_on_plasmid_batch_qc_id", using: :btree
  add_index "plasmid_batch_qcs_qc_attachments", ["qc_attachment_id"], name: "index_plasmid_batch_qcs_qc_attachments_on_qc_attachment_id", using: :btree

  create_table "plasmid_batches", force: :cascade do |t|
    t.integer  "clone_batch_id"
    t.integer  "unit_id"
    t.string   "format"
    t.decimal  "concentration"
    t.text     "comment"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "qc_validation",     default: false
    t.integer  "strict_validation"
    t.decimal  "volume"
    t.integer  "vol_unit_id"
    t.integer  "row_id"
    t.integer  "column_id"
    t.integer  "format_id"
    t.string   "name"
    t.string   "number"
    t.integer  "user_id"
    t.integer  "box_id"
  end

  add_index "plasmid_batches", ["clone_batch_id"], name: "index_plasmid_batches_on_clone_batch_id", using: :btree
  add_index "plasmid_batches", ["unit_id"], name: "index_plasmid_batches_on_unit_id", using: :btree

  create_table "primers", force: :cascade do |t|
    t.string "name"
    t.string "number"
    t.text   "sequence"
  end

  create_table "productions", force: :cascade do |t|
    t.string   "name"
    t.boolean  "display"
    t.integer  "step",              default: 0
    t.text     "comment"
    t.integer  "row_order"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "clone_batch_id"
    t.integer  "last_step",         default: 0
    t.date     "today_date"
    t.float    "percentage",        default: 0.0
    t.boolean  "locked",            default: false
    t.integer  "strict_validation"
    t.boolean  "pool"
  end

  create_table "productions_projects", force: :cascade do |t|
    t.integer "production_id"
    t.integer "project_id"
  end

  add_index "productions_projects", ["production_id"], name: "index_productions_projects_on_production_id", using: :btree
  add_index "productions_projects", ["project_id"], name: "index_productions_projects_on_project_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "promoters", force: :cascade do |t|
    t.string  "name"
    t.integer "clone_batch_id"
  end

  create_table "qc_attachments", force: :cascade do |t|
    t.integer  "clone_batch_qc_id"
    t.string   "attachment"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "rows", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sequencings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "statistics", force: :cascade do |t|
    t.float    "value"
    t.string   "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "strands", force: :cascade do |t|
    t.string "name"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "types", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "units", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
    t.string   "role"
    t.string   "firstname"
    t.string   "lastname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "virus_productions", force: :cascade do |t|
    t.integer "production_id"
    t.integer "user_id"
    t.integer "vol_unit_id"
    t.date    "date_order"
    t.date    "date_production"
    t.integer "plate_nb"
    t.decimal "vol"
    t.boolean "sterility"
    t.text    "plate_id"
    t.decimal "titer"
    t.decimal "titer_atcc"
    t.decimal "titer_to_atcc"
    t.text    "comment"
    t.integer "get_prot"
    t.boolean "invoice"
    t.string  "batch_end"
    t.boolean "l2"
    t.text    "hek_result"
  end

  add_index "virus_productions", ["production_id"], name: "index_virus_productions_on_production_id", using: :btree
  add_index "virus_productions", ["user_id"], name: "index_virus_productions_on_user_id", using: :btree
  add_index "virus_productions", ["vol_unit_id"], name: "index_virus_productions_on_vol_unit_id", using: :btree

  create_table "vol_units", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

end
