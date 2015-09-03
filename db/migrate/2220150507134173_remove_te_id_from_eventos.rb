class RemoveTeIdFromEventos < ActiveRecord::Migration
  def change
    remove_column :eventos, :te, :datetime
    remove_column :eventos, :in, :datetime
  end
end
