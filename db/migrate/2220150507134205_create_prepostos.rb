class CreatePrepostos < ActiveRecord::Migration
  def self.up
    create_table :prepostos do |t|
      t.references :pessoa, :componente
      t.timestamps
    end
  end

  def self.down
    create_table :prepostos
  end

end
