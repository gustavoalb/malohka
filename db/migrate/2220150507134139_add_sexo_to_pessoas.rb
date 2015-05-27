class AddSexoToPessoas < ActiveRecord::Migration
  def change
    add_column :pessoas, :sexo, :integer
    add_column :pessoas, :mae, :string
    add_column :pessoas, :pai, :string
    add_column :pessoas, :rg_orgao_emissor, :string
  end
end
