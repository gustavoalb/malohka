class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_usuario!,  :except => :principal
  helper_method :meus_alunos
  before_filter :validar_usuario
  #rescue_from CanCan::AccessDenied do |exception|
  # redirect_to :back, :alert => "Você não tem autorização para acessar esta área"
  #    redirect_to :back, :alert => exception.message
  #render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
  #end

  rescue_from CanCan::AccessDenied do |exception|
    if !ENV['HTTP_REFERER'].blank?
      redirect_to :back, :alert => "Você não tem autorização para acessar esta área"
    else
      respond_to do |format|
        #format.html { render template: "erros/erro_acesso", layout: 'layouts/application', status: 403 }
        format.html { render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false }
        format.all { render nothing: true, status: 403 }
      end
    end
  end


  before_filter :configure_permitted_parameters, if: :devise_controller?

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

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, roles: []) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, roles: []) }
    #devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :roles, :roles_maskroles: []) }
  end
end
