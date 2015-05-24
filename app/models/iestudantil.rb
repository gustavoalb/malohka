class Iestudantil < ActiveRecord::Base
  include ESolicitavel
  has_one :solicitacao, as: :solicitavel, dependent: :destroy
  belongs_to :aluno
  scope :da_pessoa, lambda{|pessoa_id|
    joins(:aluno).where('alunos.pessoa_id=?',pessoa_id)
  }
  #accepts_nested_attributes_for :solicitacao
  #validates_uniqueness_of :aluno_id, :message => 'Você só pode pedir uma Iestudantil para essa matrícula', :if => :entregue?


  state_machine :status, :initial => :solicitado do
    event :imprimir do
      transition :solicitado => :impresso
    end

    event :cancelar do
      transition any => :cancelado
    end

    event :entregar do
      transition :impresso => :entregue
    end

    after_transition :solicitado => :impresso do |carteira, transition|
      carteira.impresso = true
      carteira.save
    end

    after_transition :impresso => :entregue do |carteira, transition|
      carteira.entregue = true
      s = carteira.solicitacao
      s.finalizar
      carteira.save
      s.save
    end
  end



  # state_machine :status, :initial => :solicitado do
  #   event :imprimir do
  #     transition :solicitado => :impresso
  #   end

  #   event :entregar do
  #     transition :impresso => :entregue
  #   end

  #   event :cancelar do
  #     transition any => :cancelado
  #   end

  #   after_transition :solicitado => :impresso do |carteira, transition|
  #     carteira.impresso = true
  #     carteira.save
  #   end

  #   after_transition :impresso => :entregue do |carteira, transition|
  #     carteira.entregue = true
  #     carteira.save
  #     s = carteira.solicitacao
  #     s.finalizar
  #   end
  # end

  def carteira_entregue?
    return self.entregue?
  end

  def imprimir_carteira
    self.impresso = true
  end

  def entregar_carteira
    self.entregue = true
  end

end
