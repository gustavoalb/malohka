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

ActiveRecord::Schema.define(version: 2220150507134193) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alunos", force: :cascade do |t|
    t.string   "matricula",      limit: 255
    t.integer  "ano_ingresso"
    t.integer  "turma_id"
    t.integer  "curso_id"
    t.string   "semestre_atual", limit: 255
    t.string   "curso",          limit: 255
    t.integer  "pessoa_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nivel_id"
    t.string   "status",         limit: 255
    t.boolean  "ativo"
    t.integer  "periodo_atual"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
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

  create_table "componentes", force: :cascade do |t|
    t.integer  "evento_id"
    t.string   "nome",            limit: 255
    t.text     "descricao"
    t.string   "status",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vagas"
    t.integer  "tipo_componente"
    t.integer  "local"
  end

  create_table "componentes_ministrantes", force: :cascade do |t|
    t.integer "ministrante_id"
    t.integer "componente_id"
  end

  create_table "componentes_publicos", force: :cascade do |t|
    t.integer "publico_id"
    t.integer "componente_id"
  end

  create_table "cursos", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.string   "codigo",     limit: 255
    t.integer  "nivel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "duracao"
  end

  create_table "eventos", force: :cascade do |t|
    t.string   "nome",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "descricao"
    t.string   "status",              limit: 255
    t.integer  "responsavel_id"
    t.integer  "pessoa_id"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.text     "organizacao"
    t.text     "parceiros"
    t.text     "apoio"
  end

  create_table "funcionarios", force: :cascade do |t|
    t.string   "matricula",  limit: 255
    t.string   "cargo",      limit: 255
    t.integer  "cargo_id"
    t.date     "data_posse"
    t.integer  "pessoa_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grupos", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.string   "descricao",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grupos_usuarios", force: :cascade do |t|
    t.integer "usuario_id"
    t.integer "grupo_id"
  end

  create_table "guts", force: :cascade do |t|
    t.integer  "iteracao_id"
    t.integer  "gravidade"
    t.integer  "urgencia"
    t.integer  "tendencia"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "item",        limit: 255
    t.string   "status",      limit: 255
  end

  create_table "iestudantis", force: :cascade do |t|
    t.integer  "aluno_id"
    t.string   "status",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "data_lote"
    t.datetime "data_impressao"
    t.datetime "data_entrega"
    t.datetime "data_finalizacao"
    t.integer  "solicitacao_id"
  end

  create_table "iteracoes", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.string   "status",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ministrantes", force: :cascade do |t|
    t.integer  "pessoa_id"
    t.string   "nome",              limit: 255
    t.string   "organizacao",       limit: 255
    t.text     "biografia"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "titulo"
    t.string   "foto_file_name"
    t.string   "foto_content_type"
    t.integer  "foto_file_size"
    t.datetime "foto_updated_at"
    t.string   "sigla_organizacao"
    t.string   "contato"
  end

  create_table "niveis", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.string   "codigo",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "noticias", force: :cascade do |t|
    t.string   "titulo",       limit: 255
    t.text     "conteudo"
    t.datetime "publicado_em"
    t.boolean  "publicado"
    t.boolean  "destaque"
    t.boolean  "pauta"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",       limit: 255
  end

  create_table "paginas", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.string   "tipo",       limit: 255
    t.string   "tipo_id",    limit: 255
    t.string   "permalink",  limit: 255
    t.text     "conteudo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "paginas", ["permalink"], name: "index_paginas_on_permalink", using: :btree

  create_table "participacoes", force: :cascade do |t|
    t.integer  "pessoa_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "componente_id"
    t.boolean  "frequencia",    default: false
  end

  create_table "perguntas", force: :cascade do |t|
    t.integer  "pesquisa_id"
    t.text     "conteudo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "periodos", force: :cascade do |t|
    t.datetime "inicio"
    t.datetime "termino"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "componente_id"
    t.string   "qnt_horas"
  end

  create_table "pesquisas", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pessoas", force: :cascade do |t|
    t.string   "nome",              limit: 255
    t.string   "cpf",               limit: 255
    t.string   "rg",                limit: 255
    t.date     "nascimento"
    t.string   "email",             limit: 255
    t.string   "foto_file_name",    limit: 255
    t.string   "foto_content_type", limit: 255
    t.integer  "foto_file_size"
    t.datetime "foto_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "atualizado",                    default: false
    t.string   "telefone",          limit: 255
    t.integer  "fator_rh"
    t.string   "status",            limit: 255
    t.integer  "sexo"
    t.string   "mae",               limit: 255
    t.string   "pai",               limit: 255
    t.string   "rg_orgao_emissor",  limit: 255
  end

  create_table "photos", force: :cascade do |t|
    t.string   "descricao",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name",    limit: 255
    t.integer  "image_file_size"
    t.string   "image_content_type", limit: 255
    t.datetime "image_updated_at"
  end

  create_table "publicos", force: :cascade do |t|
    t.string   "nome"
    t.string   "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "publicos_componentes", force: :cascade do |t|
    t.integer "publico_id"
    t.integer "componente_id"
  end

  create_table "respostas", force: :cascade do |t|
    t.integer  "pergunta_id"
    t.string   "conteudo",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "semi_estaticas", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "solicitacoes", force: :cascade do |t|
    t.integer  "solicitante_id"
    t.integer  "solicitavel_id"
    t.string   "solicitavel_type", limit: 255
    t.boolean  "finalizado",                   default: false
    t.string   "status",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count",             default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "turmas", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.string   "codigo",     limit: 255
    t.integer  "turno"
    t.integer  "curso_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nivel_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "login",                  limit: 255
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
