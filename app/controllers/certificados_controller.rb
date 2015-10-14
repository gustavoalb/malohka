class CertificadosController < ApplicationController
  before_action :set_participacao, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, :with => :certificado_nao_encontrado

  respond_to :html

  def index
    @participacoes = Participacao.all
    respond_with(@participacoes)
  end

  def show
    # @evento = Participacao.find(params[:id])
  end

  private
  def certificado_nao_encontrado
    render :file => "#{Rails.root}/public/nao_existe.html"
  end

  def set_participacao
    # @evento = Evento.find(params[:id])
    @participacao = Participacao.find(params[:id])
  end
end
