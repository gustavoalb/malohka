class ValidarUsuarioController < ApplicationController
  skip_before_filter :validar_usuario
  def index
    @datas = []
    2.times do |i|
      ii = i+1
      @datas.push current_usuario.pessoa.nascimento + ii.year
    end
    2.times do |i|
      ii = i+1
      @datas.push current_usuario.pessoa.nascimento + ii.month
    end

    @datas.push current_usuario.pessoa.nascimento
    @datas = @datas.shuffle

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
      # redirect_to @retorno, :notice=> @mensagem
    else
      @retorno = validar_usuario_index_url
      @mensagem = "Você precisa confirmar sua data de nascimento!"
      redirect_to @retorno, :alert=> @mensagem
    end
  end


  def atualizar_pessoa
    @usuario = current_usuario
    @pessoa = @current_usuario.pessoa
    #@aluno = @pessoa.alunos.first
    #@pessoa.id = @aluno.pessoa.id
  end

  def salvar_pessoa
    #@pessoa_id = @aluno.pessoa.id
    @usuario = current_usuario
    @pessoa = @current_usuario.pessoa
    #coloquei
    #@aluno = @pessoa.alunos.first
    @pessoa.update(pessoa_params)
    if @pessoa.save
      redirect_to validar_usuario_atualizar_aluno_url, :notice=> "Informações pessoais atualizadas com sucesso!"
      #redirect_to edit_aluno_url, :notice=> "Informação atualizada com sucesso!"
    else
      render action: 'atualizar_pessoa'
    end
  end


  #veja






  def atualizar_aluno
    @usuario = current_usuario
    @pessoa = @current_usuario.pessoa
    #@aluno = @pessoa.alunos
    @aluno = @pessoa.alunos.first#order("id ASC").paginate :page => params[:page], :per_page => 10
  end

  def salvar_aluno
    @usuario = current_usuario
    @pessoa = @current_usuario.pessoa
    #@aluno = @pessoa.alunos
    @aluno = @pessoa.alunos.first#order("id ASC").paginate :page => params[:page], :per_page => 10
    #@aluno = Aluno.find(params[:id])
    #    @pessoa = @current_usuario.pessoa
    @aluno.update(aluno_params)
    #@aluno.update#_attributes(params[:aluno])
    if @aluno.save
      redirect_to root_url, :notice=> "Informações discentes atualizadas com sucesso!"
    else
      render action: 'atualizar_aluno'
    end
  end






  def pessoa_params
    params.require(:pessoa).permit(:nome, :cpf, :nascimento, :rg, :email, :fator_rh, :foto, :atualizado, :telefone, aluno: [ :matricula ])
  end

  def aluno_params
    params.require(:aluno).permit(:matricula, :ano_ingresso, :curso, :curso_id, :turma_id, :semestre_atual, pessoa: [ :nome,:foto ])
  end

end
