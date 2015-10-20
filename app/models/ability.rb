class Ability
  include CanCan::Ability

  def initialize(usuario)
    usuario ||= Usuario.new # guest user

    if usuario.role? :admin
      can :manage, :all
      #if usuario.grupo? :funcionario
      # can :manage, :all
    elsif usuario.role? :ascom
      can :manage, Noticia
      can :manage, Pagina
    elsif usuario.role? :lead
      can [:update, :read, :new, :create], Noticia
      can [:update, :read, :new, :create], Pagina
      # Utilizado para acessar o ckeditor pelo cancan
      can :access, :ckeditor
      can [:read, :create, :destroy], Ckeditor::Picture, assetable_id: usuario.id
      can [:read, :create, :destroy], Ckeditor::AttachmentFile, assetable_id: usuario.id
    elsif usuario.role? :iestudantil
      can [ :read, :update ], Aluno
    elsif usuario.role? :funcionario
      can :read, Noticia
      can [:minha_area, :lista_frequencia], Pessoa
      can [:read, :registrar_participacao], Evento
      can [:manage, :read, :edit, :update, :frequencia], Evento, responsavel_id: usuario.funcionario.id
      cannot [:destroy, :create], Evento
      can [:manage,:create, :edit, :update], Componente, responsavel_id: usuario.funcionario.id
      cannot [:destroy], Componente
      #can :read, Solicitacao
    elsif usuario.role? :aluno
      can [:read, :create, :destroy ], Solicitacao
      can :read, Noticia
      can [:read, :registrar_participacao], Evento
      #can :read, Participacao
      can :access, :ckeditor
      can [:read, :create, :destroy], Ckeditor::Picture, assetable_id: usuario.id
      can [:read, :create, :destroy], Ckeditor::AttachmentFile, assetable_id: usuario.id
      can [:manage, :edit, :update], Aluno, pessoa_id: usuario.pessoa_id
      cannot [:destroy, :create], Aluno
      can [:manage, :edit, :update], Pessoa, usuario: usuario.pessoa_id
      cannot [:destroy, :create], Pessoa
      # can [:manage, :read, :edit, :update], Usuario, :usuario_id => usuario.id
      # cannot [:destroy, :create], Usuario
      # can [:manage], Nivel
      # can [:manage], Turma
      # can [:manage], Curso
      #Evento ainda não liberado :~(
      #can :read, Evento
    elsif usuario.role? :comum
      can :read, Noticia
      can :read, Evento
    end
  end

end
