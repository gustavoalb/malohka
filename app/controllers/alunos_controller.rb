class AlunosController < ApplicationController
  load_and_authorize_resource
  before_action :set_aluno, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    #@alunos = Aluno.all
    @q = Aluno.ransack(params[:q])
    alunos = @q.result(distinct: true).order("id ASC")#.paginate(:page => params[:page], :per_page => 5)
    #respond_with(@alunos)
    @alunos = meus_alunos

    require 'barby' #sou aqui mesmo se vou servir ao resto so sistema?
    require 'barby/barcode/code_39' #sou aqui mesmo se vou servir ao resto so sistema?
    require 'barby/outputter/png_outputter' #sou aqui mesmo se vou servir ao resto so sistema?

    respond_to do |format|
      format.html # show.html.erb
      format.pdf do
        # Thin ReportsでPDFを作成
        # 先ほどEditorで作ったtlfファイルを読み込む
        report = ThinReports::Report.new(layout: "#{Rails.root}/app/reports/iestudantil_m2015.tlf")

        @alunos.each do |aluno|

          barcode = Barby::Code39.new(aluno.pessoa.cpf)

          blob = Barby::PngOutputter.new(barcode).to_png(:xdim => 3) #Raw PNG data
          #    xdim: (default: 1)
          #ydim: (default: same as xdim)
          #height: (default: 100)
          #margin: (default: 10)
          b = File.open("/tmp/codigo_barras_#{barcode}.png",'w')
          b.write blob
          b.close

          report.start_new_page
          report.page.item(:nome).value(aluno.pessoa.nome)
          report.page.item(:nascimento).value(aluno.pessoa.nascimento.to_s_br)
          report.page.item(:rg).value(aluno.pessoa.rg)
          #report.page.item(:curso).value(@aluno.curso) #inserir cursos
          report.page.item(:matricula).value(aluno.matricula)
          #report.page.item(:validade).value(@aluno.validade) # inserir validade


          if aluno.pessoa.nil?
            #image_tag("anonimo.jpg")
          elsif aluno.pessoa.foto.present?
            f = File.open (aluno.pessoa.foto.path)
            report.page.item(:foto).value(open(f))
            f.close
          end





          # f = File.open (aluno.pessoa.foto.path)
          # report.page.item(:foto).value(open(f))
          # f.close

          report.page.item(:barra).value(b.path)
        end
        send_data report.generate, filename: "Identidade Estudantil.pdf",
          type: 'application/pdf',
          disposition: 'inline' # para visualização no navegador
        #disposition: 'attachment' # para download
      end
    end
  end

  #  def show
  #    respond_with(@aluno)
  #  end

  def calcular_validade

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
      require 'barby/barcode/code_39'
      require 'barby/outputter/png_outputter'
      barcode = Barby::Code39.new("#{@aluno.pessoa.cpf}")

      blob = Barby::PngOutputter.new(barcode).to_png(:xdim => 3) #Raw PNG data
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
          report.page.item(:curso).value("Técnico em Rede de Computadores") #inserir cursos
          report.page.item(:matricula).value(@aluno.matricula)
          report.page.item(:validade).value("dez/2015") # inserir validade

          #f = File.open (@aluno.pessoa.foto.path)
          #report.page.item(:foto).value(open(f))
          #f.close

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

  def iestudantil
    #  require 'barby'
    #  require 'barby/barcode/code_39'
    #  require 'barby/outputter/png_outputter'
    #  barcode = Barby::Code39.new("#{@aluno.pessoa.cpf}")
    #  barcode = Barby::Code39.new(@aluno)

    #   blob = Barby::PngOutputter.new(barcode).to_png(:xdim => 3) #Raw PNG data
    #   b = File.open("/tmp/codigo_barras_#{barcode}.png",'w')
    #   b.write blob
    #   b.close

    respond_to do |format|
      format.html # show.html.erb
      format.pdf do

        report = ThinReports::Report.new(layout: "#{Rails.root}/app/reports/iestudantil_m2015.tlf")

        @alunos.each do |aluno|
          #2.times do
          report.start_new_page
          report.page.item(:nome).value(aluno.pessoa.nome)
          report.page.item(:nascimento).value(aluno.pessoa.nascimento.to_s_br)
          report.page.item(:rg).value(aluno.pessoa.rg)
          #report.page.item(:curso).value(@aluno.curso) #inserir cursos
          report.page.item(:matricula).value(aluno.matricula)
          #report.page.item(:validade).value(@aluno.validade) # inserir validade

          f = File.open (aluno.pessoa.foto.path)
          report.page.item(:foto).value(open(f))
          f.close

          report.page.item(:barra).value(b.path)
        end

        send_data report.generate, filename: "#{@aluno.id}.pdf",
          type: 'application/pdf',
          #  disposition: 'inline' # para visualização no navegador
          disposition: 'attachment' # para download

      end
    end
  end

  def iestudantilf
    respond_to do |format|
      format.html # show.html.erb
      format.pdf do
        # Thin ReportsでPDFを作成
        # 先ほどEditorで作ったtlfファイルを読み込む
        #report = ThinReports::Report.new layout: File.join(Rails.root, 'app', 'reports', 'cr80.tlf')
        report = ThinReports::Report.new(layout: "#{Rails.root}/app/reports/cr80.tlf")
        # 1ページ目を開始
        10.times do
          report.start_new_page
          report.page.item(:nome).value(@aluno.nome)
          report.page.item(:nascimento).value(@aluno.nascimento)
          report.page.item(:rg).value(@aluno.rg)
          report.page.item(:curso).value(@aluno.curso.nome) #inserir cursos
          report.page.item(:matricula).value(@aluno.matricula)
          #report.page.item(:foto).value(open('http://rubyonrails.org/images/rails.png'))

          f = File.open (@aluno.foto.path)
          report.page.item(:foto).value(open(f))
          f.close

          require 'barby'
          require 'barby/barcode/code_39'
          require 'barby/outputter/png_outputter'
          barcode_value = "099999333"
          full_path = "/somewhere/barcode_#{barcode_value}.png"
          b = Barby::Code39.new(barcode_value)
          File.open(full_path, 'w') { |f| f.write barcode.to_png(:margin => 3, :xdim => 2, :height => 55) }
          report.page.item(:barra).value(open(b))
          b.close
        end

        send_data report.generate, filename: "#{@aluno.id}.pdf",
          #send_data report.generate, filename: 'Identidade Estudantil.pdf',
          type: 'application/pdf',
          #disposition: 'inline' # para visualização no navegador
          disposition: 'attachment' # para download
      end
    end
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
