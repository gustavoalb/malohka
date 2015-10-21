class PublicosController < ApplicationController
  load_and_authorize_resource
  before_action :set_publico, only: [:show, :edit, :update, :destroy]

  # GET /publicos
  # GET /publicos.json
  def index
    @publicos = Publico.all
  end

  # GET /publicos/1
  # GET /publicos/1.json
  def show
  end

  # GET /publicos/new
  def new
    @publico = Publico.new
  end

  # GET /publicos/1/edit
  def edit
  end

  # POST /publicos
  # POST /publicos.json
  def create
    @publico = Publico.new(publico_params)

    respond_to do |format|
      if @publico.save
        format.html { redirect_to @publico, notice: 'Publico was successfully created.' }
        format.json { render :show, status: :created, location: @publico }
      else
        format.html { render :new }
        format.json { render json: @publico.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publicos/1
  # PATCH/PUT /publicos/1.json
  def update
    respond_to do |format|
      if @publico.update(publico_params)
        format.html { redirect_to @publico, notice: 'Publico was successfully updated.' }
        format.json { render :show, status: :ok, location: @publico }
      else
        format.html { render :edit }
        format.json { render json: @publico.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publicos/1
  # DELETE /publicos/1.json
  def destroy
    @publico.destroy
    respond_to do |format|
      format.html { redirect_to publicos_url, notice: 'Publico was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_publico
    @publico = Publico.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def publico_params
    params.require(:publico).permit(:nome, :descricao)
  end
end
