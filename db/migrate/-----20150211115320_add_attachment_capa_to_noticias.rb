class AddAttachmentCapaToNoticias < ActiveRecord::Migration
  def self.up
    change_table :noticias do |t|
      t.attachment :capa
    end
  end

  def self.down
    remove_attachment :noticias, :capa
  end
end
