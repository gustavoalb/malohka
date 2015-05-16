class Ability
  include CanCan::Ability

  def initialize(usuario)
    usuario ||= Usuario.new # guest user

    if usuario.role? :admin
      can :manage, :all
    elsif usuario.role? :ascom
      can :manage, Noticia
      #Evento ainda não liberado :~(
      #can :read, Evento
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
    elsif usuario.role? :aluno
      #can [ :read, :update ], Aluno
      can :read, Noticia
      #Evento ainda não liberado :~(
      #can :read, Evento
      can [:read, :create ], Solicitacao
    end
  end

end
