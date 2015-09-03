class AddSiglaOrganizacaoToMinistrantes < ActiveRecord::Migration
  def change
    add_column :ministrantes, :sigla_organizacao, :string
    add_column :ministrantes, :contato, :string
  end
end
