module CriarPessoa
  extend ActiveSupport::Concern

  included do
    after_create :criar_pessoa
  end

  def criar_pessoa
    #para aluno
    # nova_pessoa = Pessoa.new
    Pessoa.create#new(nome:self.nome,cpf:self.cpf)
    # self.build_pessoa(login:self.email,email:"#{self.cpf}@ifap.edu.br",password:self.cpf.first(8),password_confirmation:self.cpf.first(8),roles_mask:"4",pessoa_id:self.id)
    # nova_pessoa.save
    if Pessoa.create
      # self.pessoa_id = pessoa_id
      puts 'deu certo'
    else
      'nao rolou'
    end
    #para aluno

    #para funcionario
    # self.build_usuario(login:self.email,email:self.email,password:self.cpf.first(8),password_confirmation:self.cpf.first(8),roles_mask:"8",pessoa_id:self.id,validado:true)
    #para funcionario
  end
end
