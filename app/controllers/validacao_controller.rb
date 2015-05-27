class ValidacaoController < ApplicationController
  include Wicked::Wizard

  #before_action :set_steps
  before_action :setup_wizard

  steps :inicio, :dados_pessoais, :dados_discentes, :confirmacao

  def show
    @usuario = current_usuario
    @pessoa = @current_usuario.pessoa
    @aluno = @pessoa.alunos.first
    render_wizard
  end

  def update
    @usuario = current_usuario
    @pessoa = @current_usuario.pessoa
    @aluno = @pessoa.alunos.first
    #@pessoa.update(pessoa_params)
    #@aluno.update(aluno_params)

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
    params.require(:pessoa).permit(:nome, :cpf, :nascimento, :rg, :email, :fator_rh, :foto, :atualizado, :telefone, aluno: [ :matricula ])
  end
  # #neceśsário

  def aluno_params
    params.require(:aluno).permit(:matricula, :ano_ingresso, :curso, :curso_id, :turma_id, :semestre_atual,:nivel_id, pessoa: [ :nome,:foto ])
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
