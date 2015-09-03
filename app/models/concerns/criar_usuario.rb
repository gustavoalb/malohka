module CriarUsuario
  extend ActiveSupport::Concern

  included do
    after_create :criar_usuario
  end

  def criar_usuario
    #para aluno
    #self.build_usuario(login:self.email,email:"#{self.cpf}@ifap.edu.br",password:self.cpf.first(8),password_confirmation:self.cpf.first(8),roles_mask:"4",pessoa_id:self.id)
    #para aluno
    #para funcionario
    self.build_usuario(login:self.email,email:self.email,password:self.cpf.first(8),password_confirmation:self.cpf.first(8),roles_mask:"8",pessoa_id:self.id)
    #para funcionario
  end
end
