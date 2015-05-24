class AddAtualizadoToPessoa < ActiveRecord::Migration
  def change
    add_column :pessoas, :atualizado, :boolean,default: false
    add_column :pessoas, :telefone, :string
    add_column :pessoas, :fator_rh, :integer
  end
end
