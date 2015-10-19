class EventosController < ApplicationController
  load_and_authorize_resource
  before_action :set_evento, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @eventos = Evento.all
    @componentes = Componente.all
    @componentes_evento = @evento#.componentes#.all
    respond_with(@eventos)
  end

  def show
    @pessoa = current_usuario.pessoa_id
    @periodos = @evento.periodos.order("periodos.inicio asc")
    @componentes = @evento.componentes.order("componentes.inicio asc")
    @componentis = @componentes.order("componentes.inicio asc")
    @componentes_evento = @evento.componentes.all
    @participacoes = @evento.participacoes.all
    # if current_usuario.status == 'criado'
    #   redirect_to wizard_usuario_path(current_usuario.id)#, notice: "Estamos contentes por ter você aqui! É importante saber mais sobre você :^)"
    # else
    #   respond_with(@evento)
    # end
  end

  def new
    @evento = Evento.new
    responsavel_id = current_usuario.funcionario
    # 1.times do
    #   componentes = @evento.componentes.build
    #   1.times { componentes.periodos.build }
    # end
  end

  def edit

    # 1.times do
    #   componentes = @evento.componentes.build
    #   1.times { componentes.periodos.build }
    # end
  end

  def create
    @evento = Evento.new
    @evento.save(validate: false)
    redirect_to evento_wizard_evento_path(@evento, :inicio)
  end

  def delegacoes
    @user = Evento.find( params[:id] )
    @accessories = @user.componentes
  end

  def registrar_participacao
    @evento = Evento.find(params[:evento_id])
    @componente = Componente.find(params[:evento][:componente_id])
    @pessoa = Pessoa.find(params[:evento][:pessoa_id])
    # @pessoa = current_usuario.pessoa_id#Pessoa.find(params[:evento][:pessoa_id])
    @participacao = @pessoa.participacoes.new(:componente_id=>@componente.id)
    if @participacao.save
      redirect_to evento_url(@evento), notice: 'Inscrição feita com sucesso!'
    else
      redirect_to evento_url(@evento), alert: 'Você já possui uma inscrição ativa para esta atividade. :~('
    end
  end

  # def registrar_participacao
  #   @evento = Evento.find(params[:evento_id])
  #   @componente = Componente.find(params[:evento][:componente_id])
  #   @pessoa = Pessoa.find(params[:evento][:pessoa_id])
  #   @participacao = @pessoa.participacoes.new(:componente_id=>@componente.id)
  #   if @participacao.save
  #     redirect_to evento_url(@evento), notice: 'Inscrição feita com sucesso!'
  #   else
  #     redirect_to evento_url(@evento), alert: 'Você já possui uma inscrição ativa para esta atividade. :~('
  #   end
  # end

  def certificado
    @evento = Evento.find(params[:evento_id])

    # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    iestudantil_do_evento = ODFReport::Report.new("#{Rails.root}/app/reports/oi.odt") do |r|

      r.add_field "EVENTO", @evento.nome
      r.add_field "NOME", @evento.pessoa.nome
      r.add_field "ID", @evento.id
      r.add_field "DATA", Time.now.strftime("%d de %B de %Y")

      r.add_table("COMPONENTES", @evento.componentes) do |t|
        t.add_column("TIPO", :tipo_componente)
        t.add_column("COMPONENTE", :nome)
        # t.add_column("C", :tipo_componente)
        # t.add_column("COMPONENTE", :nome)
        # if field.is_a?(String)
        # row["FIELD_NAME"] = 'Materials'
        # row["FIELD_VALUE"] = field
        # else
        # row["FIELD_NAME"] = :field_id
        # row["FIELD_VALUE"] = field.nome || ''
        # end
      end

    end

    # send_data iestudantil_do_evento.generate,
    #   type: 'application/vnd.oasis.opendocument.text',
    #   disposition: 'attachment',
    #   filename: 'report.odt'

    arquivo_evento = iestudantil_do_evento.generate("/tmp/iestudantil_do_evento-#{@evento.id}.odt")
    system "unoconv -f pdf /tmp/iestudantil_do_evento-#{@evento.id}.odt"
    f = File.open("/tmp/iestudantil_do_evento-#{@evento.id}.pdf",'r')
    send_file(f,:filename=>"Certificado - #{@evento.id}.pdf",:content_type=>"application/pdf")
  end

  # def update
  #   @evento.update(evento_params)
  #   respond_with(@evento)
  # end

  # @user = User.find params[:id]

  # respond_to do |format|
  #   if @user.update_attributes(params[:user])
  #     format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
  #     format.json { respond_with_bip(@user) }
  #   else
  #     format.html { render :action => "edit" }
  #     format.json { respond_with_bip(@user) }
  #   end
  # end


  def update
    @evento = Evento.find(params[:id])

    @evento.update(evento_params)
    respond_to do |format|
      if @evento.update_attributes(params[:evento])
        format.html { redirect_to(@evento, :notice => 'O evento foi atualizado com successo.') }
        format.json { respond_with_bip(@evento) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@evento) }
      end
    end
  end

  def destroy
    @evento.destroy
    respond_with(@evento)
  end

  def alterar_status
    @evento = Evento.find(params[:evento_id])
    if params[:status]=='customizar'
      @evento.customizar
    elsif params[:status]=='liberar_acesso'
      @evento.liberar_acesso
    elsif params[:status]=='abrir_incricoes'
      @evento.abrir_incricoes
    elsif params[:status]=='fechar_inscricoes'
      @evento.fechar_inscricoes
    elsif params[:status]=='finalizar'
      @evento.finalizar
    elsif params[:status]=='arquivar'
      @evento.arquivar
    end
    @evento.save
    respond_with(@evento)
  end


  private
  def set_evento
    @evento = Evento.find(params[:id])
  end

  def evento_params
    params.require(:evento).permit(
      :nome, :descricao, :status, :responsavel_id,
      :pessoa_id,
      :componente_id,
      :logo, :banner, :organizacao, :parceiros, :apoio,

      participacoes_attributes:
      [ :id, :evento_id, :pessoa_id, :componente_id, :frequencia, :_destroy],

      componentes_attributes:
      [
        :id, :evento_id, :tipo, :objetivos, :inicio, :nome, :descricao, :vagas, {:publico_ids => []}, {:ministrante_ids => []}, {:ministrante_ids => []}, :publico, :tipo_componente, :local, :status, :_destroy,

        prepostos_attributes:
        [ :id, :evento_id, :pessoa_id, {:responsaveis_delegado_ids => []}, :componente_id, :_destroy],


        periodos_attributes:
        [
          :id, :componente_id, :inicio, :qnt_horas, :_destroy
        ]
      ]
    )

  end
end
