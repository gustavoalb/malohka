class CursosController < ApplicationController
  load_and_authorize_resource
  before_action :set_curso, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    #cursos = Curso.all.order("nivel_id ASC, nome DESC")
    #respond_with(@cursos)
    @q = Curso.ransack(params[:q])
    @cursos = @q.result(distinct: true)
  end

  def show
    respond_with(@curso)
  end

  def new
    @curso = Curso.new
    respond_with(@curso)
  end

  def edit
  end

  def create
    @curso = Curso.new(curso_params)
    @curso.save
    respond_with(@curso)
  end

  def update
    @curso.update(curso_params)
    respond_with(@curso)
  end

  def destroy
    @curso.destroy
    respond_with(@curso)
  end

  private
  def set_curso
    @curso = Curso.find(params[:id])
  end

  def curso_params
    params.require(:curso).permit(:nome, :codigo, :nivel_id)
  end
end
