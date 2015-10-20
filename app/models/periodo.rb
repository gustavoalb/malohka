class Periodo < ActiveRecord::Base
  belongs_to :componente

  scope :do_evento, lambda{|evento_id| where("@evento_id=?",evento_id)}
  scope :do_componente, lambda{|componente_id| where("componente_id=?",participacao.componente_id)}
end
