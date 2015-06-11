class AddTeToEventos < ActiveRecord::Migration
  def change
    add_column :eventos, :te, :datetime
    add_column :eventos, :in, :datetime
  end
end
