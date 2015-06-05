class AddDuracaoToCursos < ActiveRecord::Migration
  def change
    add_column :cursos, :duracao, :integer
  end
end
