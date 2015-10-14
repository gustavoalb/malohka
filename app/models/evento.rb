class Evento < ActiveRecord::Base

  cattr_accessor :form_steps do
    %w(inicio midias atividades periodos organizacao)
  end

  attr_accessor :form_step

  validates :nome, :descricao, :responsavel, presence: true, if: -> { required_for_step?(:inicio) }
  # validates :nome, :descricao, presence: true, if: -> { required_for_step?(:atividades) }
  # validates :identifying_characteristics, :colour, presence: true, if: -> { required_for_step?(:characteristics) }
  # validates :special_instructions, presence: true, if: -> { required_for_step?(:instructions) }

  def required_for_step?(step)
    return true if form_step.nil?
    return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end


  belongs_to :pessoa
  belongs_to :responsavel, class_name: "Funcionario"
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

  scope :ativos, -> {where("status = 'inscricoes_iniciadas' or status = 'acesso_liberado' or status = 'inscricoes_finalizadas'")}
  scope :finalizados, -> {where("status = 'evento_finalizado'",true)}
  scope :disponiveis, -> {where("status = 'inscricoes_iniciadas' or status = 'acesso_liberado'")}
  scope :anteriores, -> {where("status = 'inscricoes_iniciadas' or status = 'evento_finalizado'",true)}
  scope :em_customizacao, -> {where("status = 'em_customizacao'",true)}
  scope :inscricoes_iniciadas, -> {where("status = 'inscricoes_iniciadas'",true)}
  scope :inscricoes_finalizadas, -> {where("status = 'inscricoes_finalizadas'",true)}

  scope :da_pessoa, lambda{|pessoa_id| where("@pessoa_id=?",pessoa_id)}



  state_machine :status, :initial => :em_customizacao do
    event :customizar do
      transition :any => :em_customizacao
    end

    event :liberar_acesso do
      transition :em_customizacao => :acesso_liberado
    end

    event :abrir_incricoes do
      transition :acesso_liberado => :inscricoes_iniciadas
    end

    event :fechar_inscricoes do
      transition :inscricoes_iniciadas => :inscricoes_finalizadas
    end

    event :finalizar do
      transition :inscricoes_finalizadas => :finalizado
    end

    event :arquivar do
      transition :evento_finalizado => :arquivado
    end
  end

end
