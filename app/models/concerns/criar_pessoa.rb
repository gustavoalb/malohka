module CriarPessoa
  extend ActiveSupport::Concern

  included do
    after_create :criar_pessoa
  end

  def criar_pessoa
    #para aluno
    p = Pessoa.new(:nome=>self.nome,:cpf=>self.cpf,:email=>self.email)
    # nova_pessoa.save
    if p.save
      self.pessoa_id = p.id
      self.roles_mask = 4
      self.save
      return 'deu certo'
    else
      return 'nao rolou'
    end
  end
end
