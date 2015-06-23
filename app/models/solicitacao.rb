class Solicitacao < ActiveRecord::Base
  belongs_to :solicitavel, polymorphic: true, dependent: :destroy

  scope :ie_solicitadas, where('iestudantis.status=?','solicitado')

  scope :do_objeto, lambda{|objeto_id| where("solicitavel_id=?",objeto_id)}
  accepts_nested_attributes_for :solicitavel

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
