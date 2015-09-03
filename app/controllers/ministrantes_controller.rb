class MinistrantesController < ApplicationController
  load_and_authorize_resource
  before_action :set_ministrante, only: [:show, :edit, :update, :destroy]

  # GET /ministrantes
  # GET /ministrantes.json
  def index
    @ministrantes = Ministrante.all
  end

  # GET /ministrantes/1
  # GET /ministrantes/1.json
  def show
  end

  # GET /ministrantes/new
  def new
    @ministrante = Ministrante.new
  end

  # GET /ministrantes/1/edit
  def edit
  end

  # POST /ministrantes
  # POST /ministrantes.json
  def create
    @ministrante = Ministrante.new(ministrante_params)

    respond_to do |format|
      if @ministrante.save
        format.html { redirect_to @ministrante, notice: 'Ministrante was successfully created.' }
        format.json { render :show, status: :created, location: @ministrante }
      else
        format.html { render :new }
        format.json { render json: @ministrante.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ministrantes/1
  # PATCH/PUT /ministrantes/1.json
  def update
    respond_to do |format|
      if @ministrante.update(ministrante_params)
        format.html { redirect_to @ministrante, notice: 'Ministrante was successfully updated.' }
        format.json { render :show, status: :ok, location: @ministrante }
      else
        format.html { render :edit }
        format.json { render json: @ministrante.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ministrantes/1
  # DELETE /ministrantes/1.json
  def destroy
    @ministrante.destroy
    respond_to do |format|
      format.html { redirect_to ministrantes_url, notice: 'Ministrante was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ministrante
    @ministrante = Ministrante.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ministrante_params
    params.require(:ministrante).permit(:pessoa_id, :foto,:titulo, :nome, :organizacao, :sigla_organizacao, :contato, :biografia)
  end
end
