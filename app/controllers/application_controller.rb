class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_usuario!,  :except => :principal


  # rescue_from CanCan::AccessDenied do |exception|
  #   flash[:error] = "Access denied!"
  #   redirect_to :back
  # end

  # rescue_from CanCan::AccessDenied do |exception|
  #   authorize! :read, All, :alert => exception.default_message = "Você não pode acessar esta área!"
  #redirect_to main_app.root_url, :alert => exception.default_message = "Você não pode acessar esta área!"
  #end
  #before_filter :validar_usuario
  rescue_from CanCan::AccessDenied do |exception|
    #flash[:error] = "Accesso negado."
    #redirect_to main_app.root_url
    render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
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
  def validar_usuario
    if usuario_signed_in?
      if current_usuario.validado?
        exit
      else
        redirect_to validar_usuario_index_url
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
