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

ActiveRecord::Schema.define(version: 2220150507134134) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alunos", force: true do |t|
    t.string   "matricula"
    t.integer  "ano_ingresso"
    t.integer  "turma_id"
    t.integer  "curso_id"
    t.string   "semestre_atual"
    t.string   "curso"
    t.integer  "pessoa_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "cursos", force: true do |t|
    t.string   "nome"
    t.string   "codigo"
    t.integer  "nivel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eventos", force: true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "iestudantis", force: true do |t|
    t.boolean  "impresso",   default: false
    t.boolean  "entregue",   default: false
    t.integer  "aluno_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "niveis", force: true do |t|
    t.string   "nome"
    t.string   "codigo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "noticias", force: true do |t|
    t.string   "titulo"
    t.text     "conteudo"
    t.datetime "publicado_em"
    t.boolean  "publicado"
    t.boolean  "destaque"
    t.boolean  "pauta"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  create_table "paginas", force: true do |t|
    t.string   "nome"
    t.string   "tipo"
    t.string   "tipo_id"
    t.string   "permalink"
    t.text     "conteudo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "paginas", ["permalink"], name: "index_paginas_on_permalink", using: :btree

  create_table "perguntas", force: true do |t|
    t.integer  "pesquisa_id"
    t.text     "conteudo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "periodos", force: true do |t|
    t.integer  "evento_id"
    t.datetime "inicio"
    t.datetime "termino"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pesquisas", force: true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pessoas", force: true do |t|
    t.string   "nome"
    t.string   "cpf"
    t.string   "rg"
    t.date     "nascimento"
    t.string   "email"
    t.string   "foto_file_name"
    t.string   "foto_content_type"
    t.integer  "foto_file_size"
    t.datetime "foto_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "respostas", force: true do |t|
    t.integer  "pergunta_id"
    t.string   "conteudo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "solicitacoes", force: true do |t|
    t.integer  "solicitante_id"
    t.integer  "solicitavel_id"
    t.string   "solicitavel_type"
    t.boolean  "finalizado",       default: false
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "turmas", force: true do |t|
    t.string   "nome"
    t.string   "codigo"
    t.integer  "turno"
    t.integer  "curso_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nivel_id"
  end

  create_table "usuarios", force: true do |t|
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
    t.string   "login"
    t.integer  "tipo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roles_mask"
    t.boolean  "validado"
    t.integer  "pessoa_id"
  end

  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true, using: :btree
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree

end
