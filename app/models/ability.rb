class Ability
  include CanCan::Ability

  def initialize(usuario)
    usuario ||= Usuario.new # guest user

    if usuario.role? :admin
      can :manage, :all
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
      #can :read, Noticia
      #can [:read, :create ], Solicitacao
    elsif usuario.role? :funcionario
      can :read, Noticia
      can :read, Evento
      can :read, Solicitacao
    elsif usuario.role? :aluno
      can [:read, :create, :destroy ], Solicitacao
      can :read, Noticia
      #can [:read, :update], Pagina
      can :access, :ckeditor
      can [:read, :create, :destroy], Ckeditor::Picture, assetable_id: usuario.id
      can [:read, :create, :destroy], Ckeditor::AttachmentFile, assetable_id: usuario.id
      can [:manage, :edit, :update], Aluno, pessoa_id: usuario.pessoa_id
      cannot [:destroy, :create], Aluno
      # can [:manage], Nivel
      # can [:manage], Turma
      # can [:manage], Curso
      #Evento ainda não liberado :~(
      #can :read, Evento
    end
  end

end
