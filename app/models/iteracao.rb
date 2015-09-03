class Iteracao < ActiveRecord::Base
  has_many :guts
  validates_presence_of :nome, :message=>"Não pode ficar em branco!"
  accepts_nested_attributes_for :guts,  :allow_destroy => true

  scope :penden, -> {where("gut.status = 'pendente'",true)}
  scope :do, lambda{|iteracao_id|
    joins(:gut).where('guts.iteracao_id=?',iteracao_id)
  }
  #scope :ies, where('guts.status=?','pendente')
  #scope :with_cd_player, joins(:guts).where("guts.gravidade = 4")#where("guts.gravidade = 4")
  #scope :with_cd_players, -> { joins(:guts).where("guts.status = 'pendente'") }


  state_machine :status, :initial => :sob_avaliacao do
    event :avaliar do
      transition :sob_avaliacao => :avaliado
    end

    event :finalizar do
      transition :avaliado => :finalizado
    end

    event :reavaliar do
      transition any => :sob_avaliacao
    end
  end


end
