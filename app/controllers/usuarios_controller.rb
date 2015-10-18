class UsuariosController < ApplicationController
  load_and_authorize_resource#,  except: [:show]
  # before_filter :authenticate_usuario!,  :except => :show
  # load_and_authorize_resource, :except => [:show]
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

  def new
    @user = User.new
  end

  def create
    @usuario = Usuario.new(params[:usuario])
    if @usuario.save
      session[:usuario_id] = @usuario.id
      redirect_to wizard_usuario_path, notice: "Estamos contentes por ter você aqui! :^)"
      # redirect_to evento_wizard_evento_path(@evento, :inicio)
      # redirect_to usuarios_path, notice: "Thank you for signing up."
    else
      render :new
    end
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
