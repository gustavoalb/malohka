class Evento < ActiveRecord::Base

  cattr_accessor :form_steps do
    %w(inicio midias atividades periodos organizacao)
  end

  attr_accessor :form_step

  validates :nome, :descricao, presence: true, if: -> { required_for_step?(:inicio) }
  # validates :nome, :descricao, presence: true, if: -> { required_for_step?(:atividades) }
  # validates :identifying_characteristics, :colour, presence: true, if: -> { required_for_step?(:characteristics) }
  # validates :special_instructions, presence: true, if: -> { required_for_step?(:instructions) }

  def required_for_step?(step)
    return true if form_step.nil?
    return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end


  belongs_to :pessoa
  belongs_to :responsavel, class_name: "Pessoa"
  has_many :componentes, :dependent => :destroy
  accepts_nested_attributes_for :componentes, :reject_if => lambda { |a| a[:nome].blank? }, :allow_destroy => true
  has_many :periodos, through: :componentes
  has_many :participacoes, through: :componentes

  #logo
  has_attached_file :logo,
    :path => ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
    :url => "/system/:attachment/:id/:basename_:style.:extension",
  :styles => {
    :thumb    => ['100x100#',  :jpg, :quality => 70],
    :medium   => ["250x250>",  :jpg, :quality => 70],
    :logo   => ["230x240",  :jpg, :quality => 70],
  },
  :convert_options => {
    :thumb    => '-set colorspace sRGB -strip',
    :medium  => '-set colorspace sRGB -strip',
    :logo  => '-set colorspace sRGB -strip',
  }

  validates_attachment :logo,
    # :presence => false,
    :size => { :in => 0..10.megabytes },
    :content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }
  #logo

  #banner
  has_attached_file :banner,
    :path => ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
    :url => "/system/:attachment/:id/:basename_:style.:extension",
  :styles => {
    :thumb    => ['100x100#',  :jpg, :quality => 70],
    :medium   => ["469x125>",  :jpg, :quality => 70],
    :banner   => ["939x343",  :jpg, :quality => 70],
  },
  :convert_options => {
    :thumb    => '-set colorspace sRGB -strip',
    :medium  => '-set colorspace sRGB -strip',
    :banner  => '-set colorspace sRGB -strip',
  }

  validates_attachment :banner,
    # :presence => false,
    :size => { :in => 0..10.megabytes },
    :content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }
  #banner

  scope :em_customizacao, -> {where("status = 'em_customizacao'",true)}
  scope :ativos, -> {where("status = 'inscricoes_iniciadas' or status = 'acesso_liberado'",true)}
  scope :inscricoes_iniciadas, -> {where("status = 'inscricoes_iniciadas'",true)}
  scope :inscricoes_finalizadas, -> {where("status = 'inscricoes_finalizadas'",true)}
  scope :finalizados, -> {where("status = 'evento_finalizado'",true)}

  state_machine :status, :initial => :criado do
    event :customizar do
      transition :criado => :em_customizacao
    end

    event :liberar_acesso do
      transition :em_customizacao => :acesso_liberado
    end

    event :abrir_incricoes do
      transition :acesso_liberado => :inscricoes_iniciadas
    end

    event :fechar_incricoes do
      transition :inscricoes_iniciadas => :inscricoes_finalizadas
    end

    event :finalizar do
      transition :inscricoes_finalizadas => :evento_finalizado
    end
  end

end
