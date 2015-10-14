class AlunosController < ApplicationController
  load_and_authorize_resource
  before_action :set_aluno, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @q = Aluno.ransack(params[:q])
    @alunos = @q.result(distinct: true).paginate(:page => params[:page], :per_page => 10).order("id ASC")
    # require 'barby' #sou aqui mesmo se vou servir ao resto so sistema?
    # require 'barby/barcode/code_39' #sou aqui mesmo se vou servir ao resto so sistema?
    # require 'barby/outputter/png_outputter' #sou aqui mesmo se vou servir ao resto so sistema?


    respond_to do |format|
      format.html # show.html.erb
      #      if !aluno.turma.nil?
      format.pdf do
        # Thin ReportsでPDFを作成
        # 先ほどEditorで作ったtlfファイルを読み込む
        iestudantil_do_aluno = ODFReport::Report.new("#{Rails.root}/app/reports/IEstudantil_modelo_2015-2.odt")
        # report = ThinReports::Report.new(layout: "#{Rails.root}/app/reports/iestudantil_m2015.tlf")
        @alunos.each do |aluno|
          # #if !aluno.turma.nil?
          # barcode = Barby::Code39.new(aluno.matricula)
          # blob = Barby::PngOutputter.new(barcode).to_png(:xdim => 3) #Raw PNG data
          # #    xdim: (default: 1)
          # #ydim: (default: same as xdim)
          # #height: (default: 100)
          # #margin: (default: 10)
          # b = File.open("/tmp/codigo_barras_#{barcode}.png",'w')
          # b.write blob
          # b.close

          # report.start_new_page
          # report.page.item(:nome).value(aluno.pessoa.nome)
          # report.page.item(:nascimento).value(aluno.pessoa.nascimento.to_s_br)
          # report.page.item(:rg).value(aluno.pessoa.rg)
          # #report.page.item(:curso).value(@aluno.curso) #inserir cursos
          # report.page.item(:matricula).value(aluno.matricula)
          # report.page.item(:validade).value(view_context.validade_aluno(aluno))

          # if aluno.pessoa.nil?
          #   #image_tag("anonimo.jpg")
          # elsif aluno.pessoa.foto.present?
          #   f = File.open (aluno.pessoa.foto.path)
          #   report.page.item(:foto).value(open(f))
          #   f.close
          # end

          # # f = File.open (aluno.pessoa.foto.path)
          # # report.page.item(:foto).value(open(f))
          # # f.close

          # report.page.item(:barra).value(b.path)
        end
        send_data report.generate, filename: "Identidade Estudantil.pdf",
          type: 'application/pdf',
          disposition: 'inline' # para visualização no navegador
        #disposition: 'attachment' # para download
        #end
      end
    end
  end

  def new
    @aluno = Aluno.new
    respond_with(@aluno)
  end

  def edit
    @pessoa = Pessoa.find(@aluno.pessoa_id)
  end



  def create
    @aluno = Aluno.new(aluno_params)
    @aluno.save
    respond_with(@aluno)
  end

  def update
    @pessoa_id = @aluno.pessoa.id
    pessoa_params = params[:aluno].delete(:pessoa)
    if @aluno.update(aluno_params)
      Pessoa.transaction do
        @pessoa = Pessoa.find_by_id(@aluno.pessoa.id)
        @pessoa.update(pessoa_params)
      end
    end
    respond_with(@aluno)
  end

  def destroy
    @aluno.destroy
    respond_with(@aluno)
  end

  #def idestudantil
  def show
    if  current_usuario.roles_mask == 1

      require 'barby'
      require 'barby/barcode'
      require 'barby/barcode/code_39'
      require 'barby/outputter/png_outputter'


      barcode = Barby::Code39.new("#{@aluno.matricula}")

      blob = Barby::PngOutputter.new(barcode).to_png #Raw PNG data##(barcode).to_png(:xdim => 3) #Raw PNG data
      b = File.open("/tmp/codigo_barras_#{barcode}.png",'w')
      b.write blob
      b.close


      respond_to do |format|
        format.html # show.html.erb
        format.pdf do
          # Thin ReportsでPDFを作成
          report = ThinReports::Report.new(layout: "#{Rails.root}/app/reports/iestudantil_m2015.tlf")

          #2.times do
          report.start_new_page
          report.page.item(:nome).value(@aluno.pessoa.nome)
          report.page.item(:nascimento).value(@aluno.pessoa.nascimento.to_s_br)
          report.page.item(:rg).value(@aluno.pessoa.rg)
          report.page.item(:curso).value(@aluno.curso) #inserir cursos
          report.page.item(:matricula).value(@aluno.matricula)
          report.page.item(:validade).value(view_context.validade_aluno(@aluno))

          #f = File.open (@aluno.pessoa.foto.path)
          #report.page.item(:foto).value(open(f))
          #f.close

          if @aluno.pessoa.nil?
            #image_tag("anonimo.jpg")
          elsif @aluno.pessoa.foto.present?
            f = File.open (@aluno.pessoa.foto.path)
            report.page.item(:foto).value(open(f))
            f.close
          end



          report.page.item(:barra).value(b.path)
          #end

          send_data report.generate, filename: "#{@aluno.id}.pdf",
            type: 'application/pdf',
            disposition: 'inline' # para visualização no navegador
          #disposition: 'attachment' # para download
        end
      end
    elsif current_usuario.roles_mask == 4
    else
      render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
    end
  end

  def iestudantil_do_alunod
    @aluno = Aluno.find(params[:aluno_id])
    if  current_usuario.roles_mask == 1
      require 'barby'
      require 'barby/barcode/code_39'
      require 'barby/outputter/png_outputter'
      barcode = Barby::Code39.new("#{@aluno.matricula}")

      blob = Barby::PngOutputter.new(barcode).to_png(:xdim => 3) #Raw PNG data
      b = File.open("/tmp/codigo_barras_#{barcode}.png",'w')
      b.write blob
      b.close

      respond_to do |format|
        format.html # show.html.erb
        format.pdf do
          # Thin ReportsでPDFを作成
          report = ThinReports::Report.new(layout: "#{Rails.root}/app/reports/iestudantil_m2015.tlf")

          report.start_new_page
          report.page.item(:nome).value(@aluno.pessoa.nome)
          report.page.item(:nascimento).value(@aluno.pessoa.nascimento.to_s_br)
          report.page.item(:rg).value(@aluno.pessoa.rg)
          report.page.item(:curso).value(@aluno.curso) #inserir cursos
          report.page.item(:matricula).value(@aluno.matricula)
          report.page.item(:validade).value("dez/2015") # inserir validade

          #f = File.open (@aluno.pessoa.foto.path)
          #report.page.item(:foto).value(open(f))
          #f.close

          if @aluno.pessoa.nil?
            #image_tag("anonimo.jpg")
          elsif @aluno.pessoa.foto.present?
            f = File.open (@aluno.pessoa.foto.path)
            report.page.item(:foto).value(open(f))
            f.close
          end

          report.page.item(:barra).value(b.path)

          send_data report.generate, filename: "#{@aluno.id}.pdf",
            type: 'application/pdf',
            #disposition: 'inline' # para visualização no navegador
            disposition: 'attachment' # para download
        end
      end
    elsif current_usuario.roles_mask == 4
    else
      render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
    end
  end


  def iestudantil_do_aluno
    @aluno = Aluno.find(params[:aluno_id])

    # For Rails 3 or latest replace #{RAILS_ROOT} to #{Rails.root}
    iestudantil_do_aluno = ODFReport::Report.new("#{Rails.root}/app/reports/IEstudantil_modelo_2015-2.odt") do |r|

      r.add_field "NOME", @aluno.pessoa.nome
      r.add_field "NASCIMENTO", @aluno.pessoa.nascimento.to_s_br
      r.add_field "CPF", @aluno.pessoa.cpf
      r.add_field "CURSO", @aluno.curso
      r.add_field "MATRICULA", @aluno.matricula
      r.add_field "VALIDADE", view_context.validade_aluno(@aluno)
      f = File.open (@aluno.pessoa.foto.path)
      r.add_image "FOTO", f
      f.close
    end

    # send_data iestudantil_do_aluno.generate,
    #   type: 'application/vnd.oasis.opendocument.text',
    #   disposition: 'attachment',
    #   filename: 'report.odt'

    arquivo_carta = iestudantil_do_aluno.generate("/tmp/iestudantil_do_aluno-#{@aluno.matricula}.odt")
    system "unoconv -f pdf /tmp/iestudantil_do_aluno-#{@aluno.matricula}.odt"
    f = File.open("/tmp/iestudantil_do_aluno-#{@aluno.matricula}.pdf",'r')
    send_file(f,:filename=>"Identidade Estudantil - #{@aluno.matricula}.pdf",:content_type=>"application/pdf")
  end


  def iestudantis

    @alunos = Aluno.all

    #report = ODFReport::Report.new("reports/invoice.odt") do |r|
    iestudantil_do_aluno = ODFReport::Report.new("#{Rails.root}/app/reports/IEstudantil_modelo_2015-2.odt") do |r|


      #r.add_field(:title, "INVOICES REPORT")
      #r.add_field(:date, Date.today)
      r.add_field "NOME", aluno.pessoa.nome
      r.add_field "NASCIMENTO", aluno.pessoa.nascimento.to_s_br
      r.add_field "CPF", aluno.pessoa.cpf
      r.add_field "CURSO", aluno.curso
      r.add_field "MATRICULA", aluno.matricula
      #r.add_field "VALIDADE", view_context.validade_aluno(aluno)
      #f = File.open (aluno.pessoa.foto.path)
      #r.add_image "FOTO", f
      #f.close


    end

    send_data iestudantil_do_aluno.generate,
      type: 'application/vnd.oasis.opendocument.text',
      disposition: 'attachment',
      filename: 'report.odt'


    # iestudantil_do_aluno = ODFReport::Report.new("#{Rails.root}/app/reports/IEstudantil_modelo_2015-2.odt")
    # @alunos.each do |r|
    #   r.add_field "NOME", aluno.pessoa.nome
    #   r.add_field "NASCIMENTO", aluno.pessoa.nascimento.to_s_br
    #   r.add_field "CPF", aluno.pessoa.cpf
    #   r.add_field "CURSO", aluno.curso
    #   r.add_field "MATRICULA", aluno.matricula
    #   r.add_field "VALIDADE", view_context.validade_aluno(aluno)
    #   f = File.open (aluno.pessoa.foto.path)
    #   r.add_image "FOTO", f
    #   f.close


    #   send_data report.generate, filename: "Identidade Estudantil.pdf",
    #     type: 'application/pdf',
    #     disposition: 'inline' # para visualização no navegador



    #   # send_data iestudantil_do_aluno.generate,
    #   #   type: 'application/vnd.oasis.opendocument.text',
    #   #   disposition: 'attachment',
    #   #   filename: 'report.odt'

    #   #send_data report.generate, filename: "#{@aluno.pessoa.nome}.pdf",
    #   # type: 'application/pdf',
    #   #disposition: 'attachment' # para download ##disposition: 'inline' # para visualização no navegador

    # end
  end



  def cursos_turno
    @nivel = Nivel.find(params[:nivel]) if !params[:nivel].blank?
    @turno = params[:turno] if !params[:turno].blank?
    if @nivel and @turno
      @cursos = @nivel.cursos.joins(:turmas).where("turmas.turno = ?",@turno).uniq.collect{|c|[c.nome,c.id]}
      render :partial => 'cursos'
    else
      render nothing: true
    end
  end

  def turnos
    @nivel = Nivel.find(params[:nivel]) if !params[:nivel].blank?
    if @nivel
      @turnos = [["Manhã",1],["Tarde",2],["Noite",3]]
      render :partial => 'turnos'
    else
      render nothing: true
    end
  end

  def turmas
    @curso = Curso.find(params[:curso]) if !params[:curso].blank?
    @turno = params[:turno] if !params[:turno].blank?
    if @curso and @turno
      @turmas = @curso.turmas.where(:turno=>@turno).collect{|c|[c.nome,c.id]}
      render :partial => 'turmas'
    else
      render nothing: true
    end
  end

  private
  def set_aluno
    @aluno = Aluno.find(params[:id])
    @pessoa = @aluno.pessoa
  end


  def aluno_params
    params.require(:aluno).permit(:matricula, :ano_ingresso, :curso, :curso_id, :turma_id, :periodo_atual, :semestre_atual, :nivel_id, :status, :ativo, pessoa: [ :nome,:foto ])
  end
end
