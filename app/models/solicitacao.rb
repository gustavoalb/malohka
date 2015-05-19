class Solicitacao < ActiveRecord::Base
  belongs_to :solicitavel, polymorphic: true
  #scope :em_aberto, -> {where(finalizado:false)}
  scope :salsifufu, -> {where(finalizado:true)}
  scope :do_objeto, lambda{|objeto_id| where("solicitavel_id=?",objeto_id)}
  #.order(:created_at)}
  accepts_nested_attributes_for :solicitavel
  #accepts_nested_attributes_for :iestudantis

  state_machine :status, :initial => :criado do
    event :finalizar do
      transition :criado => :finalizado
    end

    after_transition :criado => :finalizado do |solicitacao, transition|
      solicitacao.finalizado = true
      solicitacao.save!
    end
  end

  def finalizar_solicitacao
    self.finalizado = true
  end
end
