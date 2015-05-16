class PesquisasController < ApplicationController
  load_and_authorize_resource
  before_action :set_pesquisa, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @pesquisas = Pesquisa.all
    respond_with(@pesquisas)
  end

  def show
    respond_with(@pesquisa)
  end

  def new
    @pesquisa = Pesquisa.new
    #3.times { @pesquisa.perguntas.build }
    3.times do
      pergunta = @pesquisa.perguntas.build
      4.times { pergunta.respostas.build }
    end
    #respond_with(@pesquisa)
  end

  def edit
  end

  def create
    @pesquisa = Pesquisa.new(pesquisa_params)
    @pesquisa.save
    respond_with(@pesquisa)
  end

  def update
    @pesquisa.update(pesquisa_params)
    respond_with(@pesquisa)
  end

  def destroy
    @pesquisa.destroy
    respond_with(@pesquisa)
  end

  private
  def set_pesquisa
    @pesquisa = Pesquisa.find(params[:id])
  end

  def pesquisa_params
    params.require(:pesquisa).permit(:nome,
                                     perguntas_attributes: [ :id, :conteudo, :_destroy,
                                                             respostas_attributes: [ :id, :conteudo, :_destroy]
                                                             ])
  end
end
