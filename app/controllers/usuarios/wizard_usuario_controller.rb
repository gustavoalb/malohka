class Usuario::WizardUsuarioController < ApplicationController
  include Wicked::Wizard

  before_action :setup_wizard

  steps *Usuario.form_steps

  def show
    # @usuario = current_usuario
    render_wizard
  end

  def update
    @usuario = current_usuario
    @usuario.attributes = params[:usuario]
    render_wizard @usuario
  end



end
