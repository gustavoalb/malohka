class PessoasController < ApplicationController
  #require 'will_paginate/array'
  load_and_authorize_resource
  before_action :set_pessoa, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @q = Pessoa.ransack(params[:q])
    @pessoas = @q.result(distinct: true).paginate(:page => params[:page], :per_page => 10).order("nome ASC")
    if current_usuario.roles_mask == 4 #and @pessoa.alunos.first.status == 'pendente'
      redirect_to pessoa_minha_area_path (current_usuario.pessoa_id)
    end
  end

  def minha_area
    @pessoa = Pessoa.find(params[:pessoa_id])
    @participacoes = Participacao.da_pessoa(@pessoa).all
    @componentes = Componente.order("inicio asc")
    @responsavel_id = @pessoa.funcionario.id
  end

  def lista_frequencia
    # @pessoa = Pessoa.find(params[:pessoa_id])
    @componente = Componente.find(params[:evento_id])
    @participacoes = @componente.participacoes#.da_pessoa(@pessoa).all
    # @evento = @evento.componentes#.order("componentes.inicio asc")

    # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    lista_frequencia = ODFReport::Report.new("#{Rails.root}/app/reports/lista_frequencia.odt") do |r|

      r.add_field "EVENTO", @componente.evento.nome
      r.add_field "ATIVIDADE", @componente.nome
      r.add_field "ID", @componente.id
      r.add_field "DATA", Time.now.strftime("%d de %B de %Y")

      r.add_table("COMPONENTES", @participacoes) do |t|
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

  def certificado
    require 'barby/barcode/qr_code'
    require 'barby/outputter/png_outputter'
    @pessoa = Pessoa.find(params[:pessoa_id])
    @evento = Evento.find(params[:evento_id])
    @participacoes = @evento.participacoes.da_pessoa(@pessoa).all
    @participacao = @participacoes.first
    @responsavel = @evento.responsavel

    qr_code = Barby::QrCode.new("#{certificado_url(@evento.id)}", level: :q, size: 6)

    blob = Barby::PngOutputter.new(qr_code).to_png #Raw PNG data##(qr_code).to_png(:xdim => 3) #Raw PNG data
    b = File.open("/tmp/qr_codes_#{@pessoa_id}_#{@evento_id}.png",'w')
    b.write blob
    b.close

    certificado = ODFReport::Report.new("#{Rails.root}/app/reports/oiq.odt") do |r|

      r.add_field "NOME", @participacao.pessoa.nome
      r.add_field "EVENTO", @evento.nome

      r.add_field "DEPARTAMENTO_RESPONSAVEL", @responsavel.departamento
      r.add_field "PORTARIA_DEP_RESPONSAVEL", @responsavel.decreto

      r.add_field "ENCARREGADO", @evento.responsavel.pessoa.nome
      r.add_field "ID", @evento.id
      r.add_field "EVENTO_INICIO", @evento.periodos.minimum('inicio').strftime("%d de %B")
      r.add_field "EVENTO_TERMINO", @evento.periodos.maximum('inicio').strftime("%d de %B de %Y")
      r.add_field "DATA_DOCUMENTO", @evento.periodos.maximum('created_at').strftime("%d de %B de %Y")
      r.add_field "FUNCIONARIO_RESPONSAVEL", @evento.responsavel.pessoa.nome
      r.add_field "DIRECAO_GERAL_PESSOA", @evento.responsavel.pessoa.nome
      r.add_field "DATA_REGISTRO", @evento.periodos.maximum('created_at').strftime("%d de %B de %Y às %H:%M")
      r.add_field "CH_TOTAL", @evento.somar_ch_total

      f = File.open (b.path)
      r.add_image "FOTO", b
      f.close

      r.add_table("COMPONENTES", @participacoes) do |t|
        t.add_column("TIPO") {|t|t.componente.tipo_componente}
        t.add_column("COMPONENTE") {|t|t.componente.nome}
        t.add_column("CH") {|t|t.somar_ch_parcial}

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

    # send_data certificado.generate,
    #   type: 'application/vnd.oasis.opendocument.text',
    #   disposition: 'attachment',
    #   filename: 'report.odt'

    arquivo_evento = certificado.generate("/tmp/certificado-#{@evento.id}.odt")
    system "unoconv -f pdf /tmp/certificado-#{@evento.id}.odt"
    f = File.open("/tmp/certificado-#{@evento.id}.pdf",'r')
    send_file(f,:filename=>"Certificado - #{@evento.id}.pdf",:content_type=>"application/pdf")
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
      render :text => "A foto não foi salva"
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
