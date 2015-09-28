class EventosController < ApplicationController
  before_action :set_evento, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @eventos = Evento.all
    @componentes = Componente.all

    respond_with(@eventos)
  end

  def show
    @periodos = @evento.periodos
    @periodos_por_dia = @evento.periodos.group_by { |t| t.inicio.strftime("%d/%m/%y") }
    @participacoes = Participacao.all
    respond_with(@evento)
  end

  def new
    @evento = Evento.new
    responsavel_id = current_usuario.pessoa
    1.times do
      componentes = @evento.componentes.build
      1.times { componentes.periodos.build }
    end
    #respond_with(@evento)
  end

  def edit
    responsavel_id = current_usuario.pessoa

  end

  def create
    @evento = Evento.new
    @evento.save(validate: false)
    redirect_to evento_wizard_evento_path(@evento, :inicio)
  end


  def registrar_participacao
    @evento = Evento.find(params[:evento_id])
    @componente = Componente.find(params[:evento][:componente_id])
    @pessoa = Pessoa.find(params[:evento][:pessoa_id])
    @participacao = @pessoa.participacoes.new(:componente_id=>@componente.id)
    if @participacao.save
      redirect_to evento_url(@evento), notice: 'Inscrição feita com sucesso!'
    else
      redirect_to evento_url(@evento), alert: 'Você já possui uma inscrição ativa para esta atividade. :~('
    end
  end

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



  def update
    @evento.update(evento_params)
    respond_with(@evento)
  end

  def destroy
    @evento.destroy
    respond_with(@evento)
  end

  private
  def set_evento
    @evento = Evento.find(params[:id])
  end

  def evento_params
    params.require(:evento).permit(:nome, :descricao, :status, :responsavel_id, :pessoa_id, :componente_id, :logo, :banner, :organizacao, :parceiros, :apoio, componentes_attributes: [ :id, :evento_id, :nome, :qnt_horas, :descricao, :vagas, {:publico_ids => []}, {:ministrantes_ids => []}, :publico, :tipo_componente, :local, :status, :ministrante_id, :_destroy, periodos_attributes: [ :id, :componente_id, :inicio, :termino, :_destroy]])
  end
end
