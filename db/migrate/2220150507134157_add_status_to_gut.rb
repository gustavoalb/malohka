class AddStatusToGut < ActiveRecord::Migration
  def change
    add_column :guts, :status, :string
  end
end
