class Evento < ActiveRecord::Base
  has_many :periodos, :dependent => :destroy
  accepts_nested_attributes_for :periodos,  :allow_destroy => true
  validates_presence_of :nome, :message=>"Não pode ficar em branco!"

  def inicio_evento
    self.periodos.first.inicio
  end

  def termino_evento
    self.periodos.first.termino
  end

end
