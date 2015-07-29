class Iestudantil < ActiveRecord::Base
  include ESolicitavel
  has_one :solicitacao, as: :solicitavel
  belongs_to :aluno
  scope :da_pessoa, lambda{|pessoa_id|
    joins(:aluno).where('alunos.pessoa_id=?',pessoa_id)
  }
  scope :solicitadas, -> {where("status = 'solicitado'",true)}
  scope :imprimiveis, -> {where("status = 'para_impressao'",true)}
  scope :impressas, -> {where("status = 'impresso'",true)}
  scope :entregues, -> {where("status = 'entregue'",true)}
  scope :canceladas, -> {where("status = 'cancelado'",true)}
  scope :salsifufu, -> {where("aluno = nil", true)}


  state_machine :status, :initial => :solicitado do
    event :em_lote do
      transition :solicitado => :para_impressao
    end

    event :imprimir do
      transition :para_impressao => :impresso
    end

    event :entregar do
      transition :impresso => :entregue
    end

    event :cancelar do
      transition any => :cancelado
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
