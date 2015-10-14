class AddDepartamentoToFuncionario < ActiveRecord::Migration
  def change
    add_column :funcionarios, :departamento, :string
    add_column :funcionarios, :decreto, :string
  end
end
