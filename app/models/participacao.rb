class Participacao < ActiveRecord::Base
  belongs_to :componente
  belongs_to :pessoa
  has_many :alunos, through: :pessoa
  has_many :periodos, through: :componente

  validates_uniqueness_of :componente_id,:scope=>[:componente_id, :pessoa_id]

  scope :da_pessoa, lambda{|pessoa_id| where("@pessoa_id=?",pessoa_id)}
  scope :do_evento, lambda{|evento_id| where("@evento_id=?",evento_id)}
  scope :do_componente, lambda{|componente_id| where("componente_id=?",componente_id)}

  def somar_ch_parcial
    ch = 0
    self.periodos.each do |p|
      ch+= p.qnt_horas.to_i
    end
    return ch
  end

end
