class AddItemToGut < ActiveRecord::Migration
  def change
    add_column :guts, :item, :string
    add_column :guts, :status, :string
  end
end
