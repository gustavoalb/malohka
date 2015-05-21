class Pessoa < ActiveRecord::Base
  include CriarUsuario
  has_one :usuario
  has_many :alunos
  validates_presence_of [:nome, :cpf], :message=>"Não pode ficar em branco!"

  has_attached_file :foto,
    :path => ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
    :url => "/system/:attachment/:id/:basename_:style.:extension",
  :styles => {
    :thumb    => ['100x100#',  :jpg, :quality => 70],
    :medium   => ["250x250>",  :jpg, :quality => 70],
    :foto   => ["66x84",  :jpg, :quality => 70],
  },
  :convert_options => {
    :thumb    => '-set colorspace sRGB -strip',
    :medium  => '-set colorspace sRGB -strip',
    :foto  => '-set colorspace sRGB -strip',
  }

  validates_attachment :foto,
    #    :presence => true,
    :size => { :in => 0..10.megabytes },
    :content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }
end
