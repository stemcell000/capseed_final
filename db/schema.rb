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

ActiveRecord::Schema.define(version: 20190424141124) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "fuzzystrmatch"
  enable_extension "pg_stat_statements"
  enable_extension "pg_trgm"
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

  create_table "clone_batches", force: :cascade do |t|
    t.integer  "target_id"
    t.string   "name"
    t.string   "temp_name"
    t.text     "comment"
    t.boolean  "qc_validation",             default: false
    t.integer  "strict_validation",         default: 0
    t.integer  "plasmid_validation",        default: 0
    t.date     "date_as_plasmid"
    t.string   "glyc_stock_box_as_plasmid"
    t.text     "comment_as_plasmid"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "type_id"
    t.integer  "clone_id"
    t.string   "number"
    t.integer  "strand_id"
    t.integer  "origin_id"
    t.integer  "inventory_validation",      default: 0
    t.integer  "nb"
    t.integer  "dismissed",                 default: 0
    t.integer  "plasmid_batches_count",     default: 0,     null: false
  end

  add_index "clone_batches", ["target_id"], name: "index_clone_batches_on_target_id", using: :btree

  create_table "clone_batches_genes", force: :cascade do |t|
    t.integer "clone_batch_id"
    t.integer "gene_id"
  end

  add_index "clone_batches_genes", ["clone_batch_id"], name: "index_clone_batches_genes_on_clone_batch_id", using: :btree
  add_index "clone_batches_genes", ["gene_id"], name: "index_clone_batches_genes_on_gene_id", using: :btree

  create_table "clone_batches_pcr_colonies", force: :cascade do |t|
    t.integer "clone_batch_id"
    t.integer "pcr_colony_id"
  end

  add_index "clone_batches_pcr_colonies", ["clone_batch_id"], name: "index_clone_batches_pcr_colonies_on_clone_batch_id", using: :btree
  add_index "clone_batches_pcr_colonies", ["pcr_colony_id"], name: "index_clone_batches_pcr_colonies_on_pcr_colony_id", using: :btree

  create_table "clone_batches_productions", force: :cascade do |t|
    t.integer "clone_batch_id"
    t.integer "production_id"
  end

  add_index "clone_batches_productions", ["clone_batch_id"], name: "index_clone_batches_productions_on_clone_batch_id", using: :btree
  add_index "clone_batches_productions", ["production_id"], name: "index_clone_batches_productions_on_production_id", using: :btree

  create_table "clone_batches_promoters", force: :cascade do |t|
    t.integer "clone_batch_id"
    t.integer "promoter_id"
  end

  add_index "clone_batches_promoters", ["clone_batch_id"], name: "index_clone_batches_promoters_on_clone_batch_id", using: :btree
  add_index "clone_batches_promoters", ["promoter_id"], name: "index_clone_batches_promoters_on_promoter_id", using: :btree

  create_table "clone_batches_sequencings", force: :cascade do |t|
    t.integer "clone_batch_id"
    t.integer "sequencing_id"
  end

  add_index "clone_batches_sequencings", ["clone_batch_id"], name: "index_clone_batches_sequencings_on_clone_batch_id", using: :btree
  add_index "clone_batches_sequencings", ["sequencing_id"], name: "index_clone_batches_sequencings_on_sequencing_id", using: :btree

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
    t.integer  "primer_f_id"
    t.integer  "primer_r_id"
  end

  add_index "clones", ["assay_id"], name: "index_clones_on_assay_id", using: :btree

  create_table "clones_enzymes", force: :cascade do |t|
    t.integer "clone_id",  null: false
    t.integer "enzyme_id", null: false
  end

  create_table "clones_inserts", force: :cascade do |t|
    t.integer "clone_id"
    t.integer "insert_id"
    t.integer "backbone_id"
  end

  add_index "clones_inserts", ["clone_id"], name: "index_clones_inserts_on_clone_id", using: :btree
  add_index "clones_inserts", ["insert_id"], name: "index_clones_inserts_on_insert_id", using: :btree

  create_table "clones_projects", force: :cascade do |t|
    t.integer "clone_id"
    t.integer "project_id"
  end

  add_index "clones_projects", ["clone_id"], name: "index_clones_projects_on_clone_id", using: :btree
  add_index "clones_projects", ["project_id"], name: "index_clones_projects_on_project_id", using: :btree

  create_table "cmeths", force: :cascade do |t|
    t.string "name"
  end

  create_table "columns", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dosages", force: :cascade do |t|
    t.decimal "titer"
    t.decimal "titer_atcc"
    t.decimal "titer_to_atcc"
    t.integer "virus_production_id"
    t.integer "user_id"
    t.date    "date"
    t.string  "plate_name"
    t.text    "comment"
    t.date    "inactivation"
    t.date    "inactivation_atcc"
    t.date    "inactivation_standard"
    t.boolean "accepted"
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
    t.integer  "dismissed",      default: 0
  end

  add_index "inserts", ["clone_batch_id"], name: "index_inserts_on_clone_batch_id", using: :btree

  create_table "origins", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pcr_colonies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "clone_batch_qc_id"
    t.integer  "user_id"
    t.text     "comment"
    t.date     "date"
    t.string   "result"
    t.boolean  "conclusion"
    t.string   "primer_r"
    t.string   "primer_f"
    t.integer  "primer_f_id"
    t.integer  "primer_r_id"
  end

  create_table "pcr_colonies_qc_attachments", force: :cascade do |t|
    t.integer "pcr_colony_id"
    t.integer "qc_attachment_id"
  end

  add_index "pcr_colonies_qc_attachments", ["pcr_colony_id"], name: "index_pcr_colonies_qc_attachments_on_pcr_colony_id", using: :btree
  add_index "pcr_colonies_qc_attachments", ["qc_attachment_id"], name: "index_pcr_colonies_qc_attachments_on_qc_attachment_id", using: :btree

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
    t.date     "date"
    t.boolean  "trash",             default: false
    t.string   "barcode"
  end

  add_index "plasmid_batches", ["clone_batch_id"], name: "index_plasmid_batches_on_clone_batch_id", using: :btree
  add_index "plasmid_batches", ["unit_id"], name: "index_plasmid_batches_on_unit_id", using: :btree

  create_table "plasmid_batches_productions", force: :cascade do |t|
    t.integer "plasmid_batch_id"
    t.integer "production_id"
    t.decimal "volume",           default: 0.0
    t.decimal "starting_volume"
  end

  add_index "plasmid_batches_productions", ["plasmid_batch_id"], name: "index_plasmid_batches_productions_on_plasmid_batch_id", using: :btree
  add_index "plasmid_batches_productions", ["production_id"], name: "index_plasmid_batches_productions_on_production_id", using: :btree

  create_table "primers", force: :cascade do |t|
    t.string   "name"
    t.text     "sequence"
    t.text     "comment"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "sequencing_id"
    t.boolean  "available",     default: true
  end

  create_table "productions", force: :cascade do |t|
    t.string   "name"
    t.boolean  "display"
    t.integer  "step",              default: 0
    t.text     "comment"
    t.integer  "row_order"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "target"
    t.integer  "last_step",         default: 0
    t.date     "order_date"
    t.float    "percentage",        default: 0.0
    t.boolean  "locked",            default: false
    t.integer  "strict_validation"
    t.boolean  "pool"
    t.date     "today_date"
    t.decimal  "production_volume"
    t.string   "cbtag"
    t.string   "pbtag"
    t.boolean  "disable_switch",    default: false
    t.integer  "position"
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

  create_table "qc_attachments_sequencings", force: :cascade do |t|
    t.integer "qc_attachment_id"
    t.integer "sequencing_id"
  end

  add_index "qc_attachments_sequencings", ["qc_attachment_id"], name: "index_qc_attachments_sequencings_on_qc_attachment_id", using: :btree
  add_index "qc_attachments_sequencings", ["sequencing_id"], name: "index_qc_attachments_sequencings_on_sequencing_id", using: :btree

  create_table "rows", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sequencings", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "name"
    t.string   "primer"
    t.integer  "clone_batch_qc_id"
    t.integer  "user_id"
    t.date     "date_rec"
    t.date     "date_send"
    t.text     "comment"
    t.string   "result"
    t.boolean  "conclusion"
  end

  create_table "statistics", force: :cascade do |t|
    t.float    "value"
    t.string   "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sterilitytests", force: :cascade do |t|
    t.integer  "sterility"
    t.date     "date"
    t.integer  "virus_production_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
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

  create_table "targets", force: :cascade do |t|
    t.string "name"
  end

  create_table "types", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.integer  "order_set"
  end

  create_table "units", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "username"
    t.string   "role"
    t.string   "firstname"
    t.string   "lastname"
    t.boolean  "actual_member",          default: true
    t.boolean  "cloning_notify",         default: true
    t.boolean  "production_notify",      default: true
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "virus_batches", force: :cascade do |t|
    t.string   "name"
    t.integer  "virus_production_id"
    t.integer  "box_id"
    t.integer  "row_id"
    t.integer  "column_id"
    t.date     "date"
    t.float    "volume"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.text     "comment"
    t.integer  "vol_unit_id"
    t.boolean  "trash",               default: false
    t.string   "barcode"
    t.date     "date_of_thawing"
  end

  create_table "virus_productions", force: :cascade do |t|
    t.integer  "production_id"
    t.integer  "user_id"
    t.integer  "vol_unit_id"
    t.decimal  "vol"
    t.text     "comment"
    t.string   "gel_prot"
    t.boolean  "invoice"
    t.text     "hek_result"
    t.string   "animal"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.date     "date_of_production"
    t.string   "number"
    t.string   "plasmid_tag"
    t.string   "plasmid_batch_tag"
    t.string   "rev_plasmid_tag"
    t.string   "rev_plasmid_batch_tag"
    t.integer  "nb"
    t.string   "genes_tag"
    t.string   "promoters_tag"
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
