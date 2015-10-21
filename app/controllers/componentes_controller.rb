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
    @componente = Componente.find params[:id]
    # respond_with(@componente)
  end

  def lista_frequencia
    # @pessoa = Pessoa.find(params[:pessoa_id])
    # @componente = Componente.find(params[:evento_id])
    # @participacoes = @componente#participacoes#.da_pessoa(@pessoa).all
    # @evento = @evento.componentes#.order("componentes.inicio asc")



    # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    lista_frequencia = ODFReport::Report.new("#{Rails.root}/app/reports/lista_frequencia.odt") do |r|

      r.add_field "EVENTO", @componente.evento.nome
      r.add_field "ATIVIDADE", @componente.nome
      r.add_field "ID", @componente.id
      r.add_field "DATA", Time.now.strftime("%d de %B de %Y")

      r.add_table("COMPONENTES", @componente.participacoes) do |t|
        t.add_column("PARTICIPANTE") {|t|t.pessoa.nome}
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

    # send_data lista_frequencia.generate,
    #   type: 'application/vnd.oasis.opendocument.text',
    #   disposition: 'attachment',
    #   filename: 'report.odt'

    arquivo_evento = lista_frequencia.generate("/tmp/lista_frequencia-#{@componente.id}.odt")
    system "unoconv -f pdf /tmp/lista_frequencia-#{@componente.id}.odt"
    f = File.open("/tmp/lista_frequencia-#{@componente.id}.pdf",'r')
    send_file(f,:filename=>"Frequencia - #{@componente.id}.pdf",:content_type=>"application/pdf")
  end

  def new
    @componente = Componente.new
    respond_with(@componente)
  end

  def edit
  end

  def create
    @componente = Componente.new(componente_params)
    @componente.save
    respond_with(@componente)
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
  end

  def componente_params
    params.require(:componente).permit(:evento_id, :tipo, :objetivos, :inicio, :responsavel_id, :nome, :descricao, :vagas, {:publico_ids => []}, {:ministrante_ids => []}, {:ministrante_ids => []}, :publico, :tipo_componente, :local, :status, :_destroy, periodos_attributes: [:id, :componente_id, :inicio, :qnt_horas, :_destroy])
  end
end
