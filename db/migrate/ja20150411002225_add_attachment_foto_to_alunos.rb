class AddAttachmentFotoToAlunos < ActiveRecord::Migration
  def self.up
    change_table :alunos do |t|
      t.attachment :foto
      t.integer :curso_id
      t.string :semestre_atual
    end
  end

  def self.down
    remove_attachment :alunos, :foto
  end
end
