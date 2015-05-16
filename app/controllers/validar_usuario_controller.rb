class ValidarUsuarioController < ApplicationController
  skip_before_filter :validar_usuario
  def index
    @datas = []
    3.times do |i|
      ii = i+1
      @datas.push current_usuario.pessoa.nascimento + ii.year
    end

    @datas.push current_usuario.pessoa.nascimento

  end

  def salvar_usuario
    @retorno = nil
    @mensagem = nil
    data = params[:usuario][:data]
    if data.to_date == current_usuario.pessoa.nascimento
      current_usuario.validado = true
      @current_usuario.save
      @retorno = root_url
      @mensagem = "Usuário validado com sucesso!"
    else
      @retorno = validar_usuario_index_url
      @mensagem = "Você precisa confirmar sua data de nascimento"
    end
    redirect_to @retorno, :alert=> @mensagem
  end
end
