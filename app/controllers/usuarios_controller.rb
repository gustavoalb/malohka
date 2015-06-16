class UsuariosController < ApplicationController
  load_and_authorize_resource

  respond_to :html

  def index
    # @usuarios = Usuario.all
    @q = Usuario.ransack(params[:q])
    #alunos = @q.result(distinct: true).paginate(:page => params[:page], :per_page => 20).order("ano_ingresso ASC")#.paginate(:page => params[:page], :per_page => 5)
    #respond_with(@alunos)
    #@alunos = meus_alunos
    @usuarios = @q.result(distinct: true).paginate(:page => params[:page], :per_page => 10).order("id ASC")
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
