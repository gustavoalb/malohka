class UsuariosController < ApplicationController
  load_and_authorize_resource

  respond_to :html

  def index
    @usuarios = Usuario.all
  end

  def show
    respond_with(@usuario)
  end

  def edit
    @grupos = Grupo.all.order(:nome)
    @usuario = Usuario.find(params[:id])
  end

  def update
    @usuario.update(usuario_params)
    respond_with(@usuario)
  end

  private
  def usuario_params
    params.require(:usuario).permit!
  end
  # #neceśsário


end
