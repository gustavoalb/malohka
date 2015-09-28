class Periodo < ActiveRecord::Base
  belongs_to :componente, dependent: :destroy

  #belongs_to :componente#, :dependent => :destroy
  # has_many :participacoes
  #has_many :pessoas,     :through => :participacoes

  #vai entrar #belongs_to :participacao


  #has_many :participacoes
  #has_many :pessoas, :through => :participacoes

  ################validates :qnt_horas, numericality: true
  #validates_date :inicio, :on => :create, :on_or_after => :today
  #validates_datetime :termino, :after => :inicio, message:"O término precisa ser depois do parâmetro indicado como inicial"

  # def nome
  #   self.evento.nome
  # end
end
