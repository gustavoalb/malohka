class ReparticoesController < ApplicationController
  load_and_authorize_resource
  before_action :set_reparticao, only: [:show, :edit, :update, :destroy]

  # GET /reparticoes
  # GET /reparticoes.json
  def index
    @reparticoes = Reparticao.all
  end

  # GET /reparticoes/1
  # GET /reparticoes/1.json
  def show
  end

  # GET /reparticoes/new
  def new
    @reparticao = Reparticao.new
  end

  # GET /reparticoes/1/edit
  def edit
  end

  # POST /reparticoes
  # POST /reparticoes.json
  def create
    @reparticao = Reparticao.new(reparticao_params)

    respond_to do |format|
      if @reparticao.save
        format.html { redirect_to @reparticao, notice: 'Reparticao was successfully created.' }
        format.json { render :show, status: :created, location: @reparticao }
      else
        format.html { render :new }
        format.json { render json: @reparticao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reparticoes/1
  # PATCH/PUT /reparticoes/1.json
  def update
    respond_to do |format|
      if @reparticao.update(reparticao_params)
        format.html { redirect_to @reparticao, notice: 'Reparticao was successfully updated.' }
        format.json { render :show, status: :ok, location: @reparticao }
      else
        format.html { render :edit }
        format.json { render json: @reparticao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reparticoes/1
  # DELETE /reparticoes/1.json
  def destroy
    @reparticao.destroy
    respond_to do |format|
      format.html { redirect_to reparticoes_url, notice: 'Reparticao was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_reparticao
    @reparticao = Reparticao.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def reparticao_params
    params.require(:reparticao).permit(:nome, :sigla, :orgao_id, :descricao, :data_criacao)
  end
end
