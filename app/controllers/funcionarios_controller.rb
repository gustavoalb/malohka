class FuncionariosController < ApplicationController
  load_and_authorize_resource
  before_action :set_funcionario, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @q = Funcionario.ransack(params[:q])
    @funcionarios = @q.result(distinct: true).paginate(:page => params[:page], :per_page => 10)#.order("nome ASC")
  end

  def cracha_funcional
    if  current_usuario.roles_mask == 1
      require 'barby'
      require 'barby/barcode/code_39'
      require 'barby/outputter/png_outputter'
      #barcode = Barby::Code39.new("#{@funcionario.matricula}")

      # blob = Barby::PngOutputter.new(barcode).to_png(:xdim => 3) #Raw PNG data
      # b = File.open("/tmp/codigo_barras_#{barcode}.png",'w')
      # b.write blob
      # b.close



      respond_to do |format|
        # format.html # show.html.erb
        format.pdf do
          # Thin ReportsでPDFを作成
          report = ThinReports::Report.new(layout: "#{Rails.root}/app/reports/cracha_funcional_m2015.tlf")

          #2.times do
          report.start_new_page
          ###report.page.item(:nome).value(@funcionario.pessoa.nome.split(/ /)[0])
          report.page.item(:nome).value(@funcionario.id)
          #report.page.item(:rg).value(@funcionario.pessoa.rg)
          #report.page.item(:curso).value(@funcionario.curso) #inserir cursos
          report.page.item(:cargo).value(@funcionario.cargo)
          #report.page.item(:validade).value(view_context.validade_funcionario(@funcionario))

          #f = File.open (@aluno.pessoa.foto.path)
          #report.page.item(:foto).value(open(f))
          #f.close

          if @funcionario.pessoa.nil?
            #image_tag("anonimo.jpg")
          elsif @funcionario.pessoa.foto.present?
            f = File.open (@funcionario.pessoa.foto.path)
            report.page.item(:foto).value(open(f))
            f.close
          end



          #report.page.item(:barra).value(b.path)
          #end

          send_data report.generate, filename: "#{@funcionario.id}.pdf",
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

  def show
    #respond_with(@funcionario)
    if  current_usuario.roles_mask == 1
      require 'barby'
      require 'barby/barcode/code_39'
      require 'barby/outputter/png_outputter'
      barcode = Barby::Code39.new("#{@funcionario.matricula}")

      blob = Barby::PngOutputter.new(barcode).to_png(:xdim => 3) #Raw PNG data
      b = File.open("/tmp/codigo_barras_#{barcode}.png",'w')
      b.write blob
      b.close



      respond_to do |format|
        format.html # show.html.erb
        format.pdf do
          # Thin ReportsでPDFを作成
          report = ThinReports::Report.new(layout: "#{Rails.root}/app/reports/cracha_funcional_m2015.tlf")

          #2.times do
          report.start_new_page
          report.page.item(:nome).value(@funcionario.pessoa.nome.split(/ /)[0],@funcionario.pessoa.nome.split(/ /)[1])
          #report.page.item(:nascimento).value(@funcionario.pessoa.nascimento.to_s_br)
          #report.page.item(:rg).value(@funcionario.pessoa.rg)
          #report.page.item(:curso).value(@funcionario.curso) #inserir cursos
          report.page.item(:cargo).value(@funcionario.cargo)
          #report.page.item(:validade).value(view_context.validade_funcionario(@funcionario))

          #f = File.open (@aluno.pessoa.foto.path)
          #report.page.item(:foto).value(open(f))
          #f.close

          if @funcionario.pessoa.nil?
            #image_tag("anonimo.jpg")
          elsif @funcionario.pessoa.foto.present?
            f = File.open (@funcionario.pessoa.foto.path)
            report.page.item(:foto).value(open(f))
            f.close
          end



          #report.page.item(:barra).value(b.path)
          #end

          send_data report.generate, filename: "#{@funcionario.id}.pdf",
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

  def new
    @funcionario = Funcionario.new
    respond_with(@funcionario)
  end

  def edit
    @pessoa = Pessoa.find(@funcionario.pessoa_id)
  end

  def create
    @funcionario = Funcionario.new(funcionario_params)
    @funcionario.save
    respond_with(@funcionario)
  end

  def update
    @pessoa_id = @funcionario.pessoa.id
    pessoa_params = params[:funcionario].delete(:pessoa)
    if @funcionario.update(funcionario_params)
      Pessoa.transaction do
        @pessoa = Pessoa.find_by_id(@funcionario.pessoa.id)
        @pessoa.update(pessoa_params)
      end
    end
    respond_with(@funcionario)
  end





  def destroy
    @funcionario.destroy
    respond_with(@funcionario)
  end

  private
  def set_funcionario
    @funcionario = Funcionario.find(params[:id])
  end

  def funcionario_params
    params.require(:funcionario).permit(:matricula, :cargo, :cargo_id, :data_posse, :departamento, :decreto, pessoa: [ :nome,:foto ])
    # params.require(:aluno).permit(:matricula, :ano_ingresso, :curso, :curso_id, :turma_id, :periodo_atual, :semestre_atual, :nivel_id, :status, :ativo, pessoa: [ :nome,:foto ])

  end
end
