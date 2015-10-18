class Usuarios::WizardUsuarioController < ApplicationController
  include Wicked::Wizard

  steps :inico, :dados_pessoais, :finalizacao


  def show
    @usuario = current_usuario
    render_wizard
  end

  def update
    @user = current_user
    @user.attributes = params[:user]
    render_wizard @user
  end



end
