class PessoasController < ApplicationController
  #require 'will_paginate/array'
  load_and_authorize_resource
  before_action :set_pessoa, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @q = Pessoa.ransack(params[:q])
    @pessoas = @q.result(distinct: true).paginate(:page => params[:page], :per_page => 10).order("nome ASC")
  end

  def show
    respond_with(@pessoa)
  end

  def new
    @pessoa = Pessoa.new
    respond_with(@pessoa)
  end

  def foto
    @pessoa = Pessoa.find(params[:pessoa_id])
  end

  def edit
  end

  def create
    @pessoa = Pessoa.new(pessoa_params)
    @pessoa.save
    respond_with(@pessoa)
  end

  def update
    @pessoa.update(pessoa_params)
    respond_with(@pessoa)
  end

  def destroy
    @pessoa.destroy
    respond_with(@pessoa)
  end

  def upload_foto
    @pessoa = Pessoa.find(params[:pessoa_id])
    @pessoa.set_picture(request.raw_post)
    if @pessoa.save(:validate => false)
      render :nothing=>true
    else
      render :text => "Foto não foi salva"
    end

  end

  private
  def set_pessoa
    @pessoa = Pessoa.find(params[:id])
  end

  def pessoa_params
    params.require(:pessoa).permit(:nome, :sexo, :mae, :pai, :cpf, :nascimento, :rg, :rg_orgao_emissor,:email, :fator_rh, :foto, :atualizado, :telefone, :atualizado, :status)
  end
end
