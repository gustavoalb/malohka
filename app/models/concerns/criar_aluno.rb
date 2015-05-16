module CriarAluno
  extend ActiveSupport::Concern

  included do
    before_create :criar_aluno
  end

  def criar_aluno
    self.build_aluno(nome:self.nome)
  end
end
