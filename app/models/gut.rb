class Gut < ActiveRecord::Base
  belongs_to :iteracao
  validates_presence_of [:item, :gravidade, :urgencia, :tendencia], :message=>"Não pode ficar em branco!"
  enum gravidade: { 'sem gravidade'=> 1, 'pouco grave'=>2, 'grave'=> 3, 'muito grave'=> 4, 'extremamente grave'=> 5}
  enum urgencia: {'pode esperar'=> 1, 'pouco urgente'=>2, 'urgente, merece atenção no curto prazo'=> 3, 'muito urgente'=> 4, 'necessidade de ação imediata'=> 5}
  enum tendencia: {'não irá mudar'=> 1, 'irá piorar a longo prazo'=>2, 'irá piorar a médio prazo'=> 3, 'irá piorar a curto prazo'=> 4, 'irá piorar rapidamente'=> 5}

  #scope :pendentes, -> {where("status = 'pendente'", true)}
  #scope :pendentes, -> { joins(:iteracao).where("iteracao_id=?", @iteracao_id).where("status = 'pendente'", true) }
  scope :pendentes, -> { joins(:iteracao).where("@iteracao_id=?", 7) }
  #).where("status = pendente", true) }

  def total_gut
    return self[:gravidade] + self[:urgencia] + self[:tendencia]
  end

  state_machine :status, :initial => :pendente do
    event :avaliar do
      transition :pendente => :avaliado
    end

    event :finalizar do
      transition :avaliado => :finalizado
    end

    event :reavaliar do
      transition any => :pendente
    end
  end



end
