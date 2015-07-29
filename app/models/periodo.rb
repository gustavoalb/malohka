class Periodo < ActiveRecord::Base
  belongs_to :evento
  #has_many :pessoas, :through => :periodos
  has_many :participacoes
  has_many :pessoas,
    :through => :participacoes

  validates :qnt_horas, numericality: true
  #validates_date :inicio, :on => :create, :on_or_after => :today
  #validates_datetime :termino, :after => :inicio, message:"O término precisa ser depois do parâmetro indicado como inicial"

  def nome
    self.evento.nome
  end
end
