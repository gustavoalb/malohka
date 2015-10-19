class AddResponsavelIdToComponentes < ActiveRecord::Migration
  def change
    add_column :componentes, :responsavel_id, :integer
  end
end
