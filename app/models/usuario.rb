class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # include CriarPessoa
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :grupos
  belongs_to :pessoa
  has_one :funcionario, :through => :pessoa
  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }
  # validates_presence_of [:pessoa_id], :message=>"Não pode ficar em branco!"

  state_machine :status, :initial => :criado do
    event :validar_usuario_pessoa do
      transition :criado => :usuario_pessoa_validado
    end

    event :abrir_incricoes do
      transition :acesso_liberado => :inscricoes_iniciadas
    end

    event :fechar_inscricoes do
      transition :inscricoes_iniciadas => :inscricoes_finalizadas
    end

    event :finalizar do
      transition :inscricoes_finalizadas => :finalizado
    end

    event :arquivar do
      transition :evento_finalizado => :arquivado
    end
  end

  #roles para retirada
  ROLES = %w[admin ascom aluno funcionario lead iestudantil comum]

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end

  def role_symbols
    roles.map(&:to_sym)
  end
  #roles para retirada

  def grupo?(grupo)
    grupos = []
    self.grupos.each do |g|
      grupos << g.nome.downcase
    end
    grupos.include? grupo.to_s.downcase
  end

end
