class Iestudantil < ActiveRecord::Base
  include ESolicitavel
  has_one :solicitacao, as: :solicitavel
  belongs_to :aluno
  has_one :pessoa, through: :aluno
  scope :da_pessoa, lambda{|pessoa_id|
    joins(:aluno).where('alunos.pessoa_id=?',pessoa_id)
  }
  scope :solicitadas, -> {where("status = 'solicitado'",true)}
  #scope :solicitadas, -> {joins(:pessoa).where("pessoas.foto_file_name is not null and status = solicitado",true)}

  scope :com_foto, -> {joins(:pessoa).where("pessoas.foto_file_name is not null and iestudantis.status = 'solicitado'")}
  scope :sem_foto, -> {joins(:pessoa).where("pessoas.foto_file_name is null and iestudantis.status = 'solicitado'")}
  # joins(:periodos).where("inicio BETWEEN ? and ?",Time.parse("11/08/2015 00:00 UTC -3"),Time.parse("11/08/2015 23:59 UTC -3")).order("periodos.inicio").count

  scope :em_lote, -> {where("status = 'em_lote'",true)}
  scope :imprimiveis, -> {where("status = 'para_impressao'",true)}
  scope :impressas, -> {where("status = 'impresso'",true)}
  scope :entregues, -> {where("status = 'entregue'",true)}
  scope :canceladas, -> {where("status = 'cancelado'",true)}
  scope :salsifufu, -> {where("aluno = nil", true)}


  state_machine :status, :initial => :solicitado do
    event :em_lote do
      transition :solicitado => :em_lote
    end

    event :gerar_lote do
      transition :em_lote => :lote_gerado
    end

    event :imprimir do
      transition :lote_gerado => :impresso
    end

    event :entregar do
      transition :impresso => :entregue
    end

    event :cancelar do
      transition any => :cancelado
    end


    after_transition :solicitado => :em_lote do |iestudantil, transition|
      iestudantil.data_lote = DateTime.now
      iestudantil.save
    end


    after_transition :impresso => :entregue do |iestudantil, transition|
      #iestudantil.data_lote = DateTime.now
      iestudantil.save
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
