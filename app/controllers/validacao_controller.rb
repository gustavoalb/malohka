class ValidacaoController < ApplicationController
  include Wicked::Wizard

  before_action :setup_wizard

  steps :inicio, :dados_pessoais, :dados_discentes, :confirmacao

  def show
    @usuario = current_usuario
    @pessoa = @current_usuario.pessoa
    @aluno = @pessoa.alunos.first
    if @pessoa.status == 'atualizado'
      #respond_with(@solicitacoes)#
      redirect_to root_path, :alert => "Seus dados já foram atualizados! :D"
    elsif @pessoa.status == 'pendente'
      render_wizard
    end

  end

  def update
    @usuario = current_usuario
    @pessoa = @current_usuario.pessoa
    @aluno = @pessoa.alunos.first

    case step
    when :dados_pessoais
      @pessoa.update(pessoa_params)
      render_wizard @pessoa

    when :confirmacao

    when :dados_discentes
      @aluno.update(aluno_params)
      render_wizard @aluno
    end
    if @aluno.save
      @pessoa.atualizar
      @aluno.atualizar
    end
  end


  def turmas
    @nivel = Nivel.find(params[:nivel]) if !params[:nivel].blank?
    if @nivel
      @turmas = @nivel.turmas.collect{|c|[c.nome,c.id]}
      render :partial => 'turmas'
    else
      render nothing: true
    end
  end


  # #necessário
  def pessoa_params
    params.require(:pessoa).permit(:nome, :sexo, :mae, :pai, :cpf, :nascimento, :rg, :rg_orgao_emissor,:email, :fator_rh, :foto, :atualizado, :telefone, :atualizado, :status, aluno: [ :matricula ])
  end
  # #neceśsário

  def aluno_params
    params.require(:aluno).permit(:matricula, :ano_ingresso, :turma_id, :curso_id, :semestre_atual, :curso, :nivel_id, :status, :ativo, pessoa: [ :nome,:foto ])
  end

  private
  def finish_wizard_path
    solicitacoes_path
  end


  # def set_steps
  #   if params[:flow] == "twitter"
  #     self.steps = [:ask_twitter, :ask_email]
  #   elsif params[:flow] == "facebook"
  #     self.steps = [:ask_facebook, :ask_email]
  #   end
  # end



end
