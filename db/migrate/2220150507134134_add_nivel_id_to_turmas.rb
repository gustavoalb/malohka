class AddNivelIdToTurmas < ActiveRecord::Migration
  def change
    add_column :turmas, :nivel_id, :integer
  end
end
