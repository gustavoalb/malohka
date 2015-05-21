class TurmasController < ApplicationController
  load_and_authorize_resource
  before_action :set_turma, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    #@turmas = Turma.all.order("turno ASC, curso_id ASC")
    # respond_with(@turmas)

    @q = Turma.ransack(params[:q])
    @turmas = @q.result(distinct: true)


  end

  def show
    respond_with(@turma)
  end

  def new
    @turma = Turma.new
    respond_with(@turma)
  end

  def edit
  end

  def create
    @turma = Turma.new(turma_params)
    @turma.save
    respond_with(@turma)
  end

  def update
    @turma.update(turma_params)
    respond_with(@turma)
  end

  def destroy
    @turma.destroy
    respond_with(@turma)
  end

  def cursos
    @nivel = Nivel.find(params[:nivel]) if !params[:nivel].blank?
    if @nivel
      @cursos = @nivel.cursos.collect{|c|[c.nome,c.id]}
      render :partial => 'cursos'
    else
      render nothing: true
    end
  end

  private
  def set_turma
    @turma = Turma.find(params[:id])
  end

  def turma_params
    params.require(:turma).permit(:nome, :codigo, :turno, :curso_id, :nivel_id)
  end
end
