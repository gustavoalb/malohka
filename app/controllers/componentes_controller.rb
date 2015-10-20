class ComponentesController < ApplicationController
  # load_and_authorize_resource
  before_action :set_componente, only: [:show, :edit, :update, :destroy]

  respond_to :html
  def index
    @componentes = Componente.order("inicio asc")
    @componentess = Componente.order("inicio asc")
    @responsavel_id = current_usuario.funcionario.id
  end

  def show
    respond_with(@componente)
  end

  def edit
  end

  def update
    @componente = Componente.find params[:id]

    respond_to do |format|
      if @componente.update_attributes(params[:componente])
        format.html { redirect_to(@componente, :notice => 'User was successfully updated.') }
        format.json { respond_with_bip(@componente) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@componente) }
      end
    end
  end

  private
  def set_componente
    @componente = Componente.find(params[:id])
    #@pagina = Pagina.find_by_permalink!(params[:id])
  end

  def componente_params
    params.require(:componente).permit(:tipo, :objetivos, :inicio, :responsavel_id, :nome, :descricao, :vagas, {:publico_ids => []}, {:ministrante_ids => []}, {:ministrante_ids => []}, :publico, :tipo_componente, :local, :status, :_destroy, periodos_attributes: [:id, :componente_id, :inicio, :qnt_horas, :_destroy])
  end
  # prepostos_attributes: [ :id, :evento_id, :pessoa_id, {:responsaveis_delegado_ids => []}, :componente_id, :_destroy],
end
