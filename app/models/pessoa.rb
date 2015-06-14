require 'tempfile'
class Pessoa < ActiveRecord::Base
  include CriarUsuario
  has_one :usuario
  has_many :alunos
  validates_presence_of [:nome, :cpf], :message=>"Não pode ficar em branco!"
  # validates :fator_rh, :presence => true, :on => :update
  # validates :rg, :presence => true, :on => :update
  # validates :telefone, :presence => true, :on => :update
  # validates :email, :presence => true, :on => :update
  # validates :sexo, :presence => true, :on => :update
  # validates :mae, :presence => true, :on => :update

  enum fator_rh: {'A+'=> 1, 'A-'=>2, 'B+'=> 3, 'B-'=> 4, 'AB+'=> 5, 'AB-'=> 6, 'O+'=> 7, 'O-'=> 8, 'Nem faço ideia'=> 9}
  enum sexo: {'Masculino'=> 1, 'Feminino'=>2}

  has_attached_file :foto,
    :path => ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
    :url => "/system/:attachment/:id/:basename_:style.:extension",
  :styles => {
    :thumb    => ['100x100#',  :jpg, :quality => 70],
    :medium   => ["250x250>",  :jpg, :quality => 70],
    :foto   => ["278x355",  :jpg, :quality => 70],
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

  def set_picture(data)
    temp_file = Tempfile.new(['temp', '.jpg'], :encoding => 'ascii-8bit')
    begin
      temp_file.write(data)
      self.foto = temp_file ## assumes has_attached_file :picture
    ensure
      temp_file.close
      temp_file.unlink
    end
  end

  state_machine :status, :initial => :pendente do
    event :atualizar do
      transition :pendente => :atualizado
    end
    event :decair do
      transition :atualizado => :pendente
    end

    after_transition :pendente => :atualizado do |pessoa, transition|
      pessoa.atualizado = true
      pessoa.save!
    end
  end

end
