class Periodo < ActiveRecord::Base
  belongs_to :evento

  def nome
    self.evento.nome
  end
end
