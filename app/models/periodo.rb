class Periodo < ActiveRecord::Base
  belongs_to :evento

  #validates_date :inicio, :on => :create, :on_or_after => :today
  #validates_datetime :termino, :after => :inicio, message:"O término precisa ser depois do parâmetro indicado como inicial"

  def nome
    self.evento.nome
  end
end
