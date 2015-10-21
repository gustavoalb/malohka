class FrequenciasController < ApplicationController
  # load_and_authorize_resource
  before_action :set_frequencia, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @frequencias = Componente.order("inicio asc")
    @responsavel_id = current_usuario.funcionario.id
  end

  def show
    respond_with(@frequencia)
    # @componente = Componente.find(params[:evento][:componente_id])
    # @frequencia = Componente.find(params[:componente_id])
  end

  def lista_frequencia
    @frequencia = Componente.find(params[:frequencia_id])
    @participacoes = @frequencia.participacoes.includes(:pessoa).order("pessoas.nome asc")#.da_pessoa(@pessoa).all
    @responsavel = current_usuario.pessoa.nome.split(/ /)[0].titleize
    # @evento = @evento.frequencias#.order("frequencias.inicio asc")

    # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    f = 0
    lista_de_frequencia = ODFReport::Report.new("#{Rails.root}/app/reports/lista_frequencia.odt") do |r|

      r.add_field "EVENTO", @frequencia.evento.nome
      r.add_field "ATIVIDADE", @frequencia.nome
      r.add_field "ID", @frequencia.id
      r.add_field "DATA", Time.now.strftime("%d de %B de %Y")
      r.add_field "EMISSOR", @responsavel

      r.add_table("COMPONENTES", @participacoes) do |t|
        # t.add_column("ORDEM"){|a|f && f+=1}
        t.add_column("PARTICIPANTE") {|t|t.pessoa.nome}
        t.add_column("ORDEM"){|a| f && f+=1}
      end
    end

    # send_data lista_frequencia.generate,
    #   type: 'application/vnd.oasis.opendocument.text',
    #   disposition: 'attachment',
    #   filename: 'report.odt'

    arquivo_evento = lista_de_frequencia.generate("/tmp/lista_de_frequencia-#{@frequencia.id}.odt")
    system "unoconv -f pdf /tmp/lista_de_frequencia-#{@frequencia.id}.odt"
    f = File.open("/tmp/lista_de_frequencia-#{@frequencia.id}.pdf",'r')
    send_file(f,:filename=>"Frequencia - #{@frequencia.id}.pdf",:content_type=>"application/pdf")
  end

  #   arquivo_evento = lista_frequencia.generate("/tmp/lista_frequencia-#{@componente.id}.odt")
  #   system "unoconv -f pdf /tmp/lista_frequencia-#{@componente.id}.odt"
  #   f = File.open("/tmp/lista_frequencia-#{@componente.id}.pdf",'r')
  #   send_file(f,:filename=>"Frequencia - #{@componente.id}.pdf",:content_type=>"application/pdf")
  # end



  private
  def set_frequencia
    @frequencia = Componente.find(params[:id])
  end

end
