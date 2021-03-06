class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  before_filter :authenticate_usuario!,  :except => :principal
  helper_method :meus_alunos
  # before_filter :validar_usuario

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => "Você não tem autorização para acessar esta área"
  end

  before_action do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  def current_ability
    @current_ability ||= Ability.new(current_usuario)
  end

  def after_sign_in_path_for(resource)
    if current_usuario.validado?
      root_url
    else
      validar_usuario_index_path
    end
  end

  private
  def meus_alunos
    @alunos ||= Aluno.where(pessoa_id:current_usuario.pessoa.id)
  end

  def validar_usuario
    if usuario_signed_in?
      if current_usuario.validado?
        #exit
      else
        redirect_to validar_usuario_index_url
      end
    end
  end

  def atualizar_usuario
    if current_usuario.validado?
      if current_usuario.pessoa and  current_usuario.pessoa.atualizado?
        redirect_to root_url
      else
        redirect_to validar_usuario_atualizar_pessoa_url
      end
    end
  end

  protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :roles_mask, :validado, roles: []) }
  #   devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, roles: []) }
  # end


  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :validado, :status, :nome, :cpf) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :status, :validado) }
  end



end
