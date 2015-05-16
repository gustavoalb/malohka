module CriarUsuario
  extend ActiveSupport::Concern

  included do
    after_create :criar_usuario, only: :create
  end

  def criar_usuario
    #não está permitindo fazer o update da data de nascimento
    self.build_usuario(login:self.email,email:"#{self.cpf}@ifap.edu.br",password:self.cpf.reverse,password_confirmation:self.cpf.reverse,roles_mask:"4",pessoa_id:self.id)
  end
end
