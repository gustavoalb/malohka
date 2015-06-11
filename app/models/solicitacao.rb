class Solicitacao < ActiveRecord::Base
  belongs_to :solicitavel, polymorphic: true, dependent: :destroy

  #scope :em_aberto, -> {where(finalizado:false)}
  scope :ie_solicitadas, where('iestudantis.status=?','solicitado')

  # scope :da_pessoa, lambda{|pessoa_id|
  #    joins(:aluno).where('alunos.pessoa_id=?',pessoa_id)
  #  }

  #scope :solicitadas, -> {where("status = 'solicitado'",true)}

  # scope :solicitadas, -> {where("status = 'solicitado'",true)}
  #   scope :imprimiveis, -> {where("status = 'para_impressao'",true)}
  #   scope :entregues, -> {where("status = 'entregue'",true)}
  #   scope :canceladas, -> {where("status = 'cancelado'",true)}


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
