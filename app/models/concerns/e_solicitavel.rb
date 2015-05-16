module ESolicitavel
  extend ActiveSupport::Concern

  included do
    before_create :criar_solicitacao
  end

  def criar_solicitacao
    self.build_solicitacao(solicitante_id:self.aluno.id)
  end
end
