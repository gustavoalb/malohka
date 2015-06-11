class AddIToEventos < ActiveRecord::Migration
  def change
    add_column :eventos, :I, :datetime
    add_column :eventos, :t, :datetime
  end
end
