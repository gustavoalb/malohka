class Iteracao < ActiveRecord::Base
  has_many :guts
  validates_presence_of :nome, :message=>"Não pode ficar em branco!"
  accepts_nested_attributes_for :guts,  :allow_destroy => true

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
