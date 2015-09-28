class SolicitacoesController < ApplicationController
  load_and_authorize_resource
  before_action :set_solicitacao, only: [:show, :edit, :update, :destroy]
  #before_action :atualizar_aluno

  respond_to :html

  def index
    @pessoa = current_usuario.pessoa
    @solicitacao = Solicitacao.new

    #if @pessoa.status == 'pendente' and @pessoa.alunos.first.status == 'pendente'
    if @pessoa.alunos.first.status == 'pendente'
      #if current_usuario.roles_mask == 4 #and @pessoa.alunos.first.status == 'pendente'
      redirect_to validacao_index_path
      #render "#{Rails.root}/public/ops.html" # false/gte/pesquisadores"
    elsif @pessoa.alunos.first.status == 'atualizado'# and @pessoa.alunos.first.status == 'atualizado'
      #redirect_to solicitacoes_path
      #respond_with(@solicitacoes)
    else
      redirect_to :back, :alert => "Esta área ainda será liberada para sua classe de usuário. :~("
    end




  end

  def show
    respond_with(@solicitacao)


  end

  def new
    @solicitacao = Solicitacao.new
    respond_with(@solicitacao)
  end

  def solicitar_ie
    @pessoa = current_usuario.pessoa
    @solicitacao = Solicitacao.new
  end

  def edit
  end

  def create
    if params[:tipo]=='ie' and solicitacao_params[:solicitante_id]
      @solicitante = current_usuario.pessoa.alunos.find(solicitacao_params[:solicitante_id])
      @ie = @solicitante.carteiras.create
      @pessoa = current_usuario.pessoa
    end
    #eu aprendedo ajax

    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @solicitacao.update(solicitacao_params)
    respond_with(@solicitacao)
  end

  def destroy
    @solicitacao.destroy
    respond_with(@solicitacao)
  end

  def iestudantil_do_aluno
    @solicitacao = Iestudantil.find(params[:iestudantil_id])


    # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    iestudantil_do_aluno = ODFReport::Report.new("#{Rails.root}/app/reports/IEstudantil_modelo_2015-2.odt") do |r|

      # r.add_field "NOME", @aluno.pessoa.nome
      # r.add_field "NASCIMENTO", @aluno.pessoa.nascimento.to_s_br
      # r.add_field "CPF", @aluno.pessoa.cpf
      # r.add_field "CURSO", @aluno.curso
      # r.add_field "MATRICULA", @aluno.matricula
      # r.add_field "VALIDADE", view_context.validade_aluno(@aluno)
      # f = File.open (@aluno.pessoa.foto.path)
      # r.add_image "FOTO", f
      # f.close
    end

    # send_data iestudantil_do_aluno.generate,
    #   type: 'application/vnd.oasis.opendocument.text',
    #   disposition: 'attachment',
    #   filename: 'report.odt'

    arquivo_carta = iestudantil_do_aluno.generate("/tmp/iestudantil_do_aluno-#{@aluno.pessoa.nome}.odt")
    system "unoconv -f pdf /tmp/iestudantil_do_aluno-#{@aluno.pessoa.nome}.odt"
    f = File.open("/tmp/iestudantil_do_aluno-#{@aluno.pessoa.nome}.pdf",'r')
    send_file(f,:filename=>"Identidade Estudantil - #{@aluno.pessoa.nome}.pdf",:content_type=>"application/pdf")

  end


  def cancelar_solicitacao
    @iestudantil = Iestudantil.find(params[:iestudantil_id])
    #@iestudantil = Iestudantil.find(params[:id])
    if params[:status]=='cancelado'
      @iestudantil.cancelar
    elsif params[:status]=='impresso'
    end
    #    @solicitacao.save
    redirect_to solicitacoes_url
  end


  def alterar_status
    @iestudantil = Iestudantil.find(params[:iestudantil_id])
    if params[:status]=='em_lote'
      @iestudantil.em_lote
    elsif params[:status]=='imprimir'
      @iestudantil.imprimir
    elsif params[:status]=='entregar'
      @iestudantil.entregar
    elsif params[:status]=='cancelar'
      @iestudantil.cancelar
    end
    @iestudantil.save
    redirect_to solicitacoes_url
  end


  # def alterar_status
  #   @noticia = Noticia.find(params[:noticia_id])
  #   if params[:status]=='destaque'
  #     @noticia.em_destaque
  #     @noticia.publicado_em = DateTime.now
  #   elsif params[:status]=='pauta'
  #     @noticia.em_pauta
  #   elsif params[:status]=='arquivo'
  #     @noticia.em_arquivo
  #   elsif params[:status]=='reavaliacao'
  #     @noticia.reavaliar
  #   end
  #   @noticia.save
  #   redirect_to noticias_url
  # end


  private
  def set_solicitacao
    @solicitacao = Solicitacao.find(params[:id])
  end

  def solicitacao_params
    params.require(:solicitacao).permit(:solicitante_id,:finalizado)
  end
end
