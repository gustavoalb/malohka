class Aluno < ActiveRecord::Base
  #  include CriarUsuario
  belongs_to :turma
  belongs_to :pessoa
  has_many :carteiras, class_name: 'Iestudantil'
  has_one :usuario
  accepts_nested_attributes_for :pessoa, :allow_destroy => true
  validates_presence_of [:matricula, :ano_ingresso, :curso, :semestre_atual], :message=>"Não pode ficar em branco!"

  def gerar_c_barra
    pessoa = self.pessoa
    barcode = Barby::Code128B.new(pessoa.cpf)
    blob = Barby::PngOutputter.new(barcode).to_png #Raw PNG data
    f = File.open("#{Rails.public_path}/system/codigos/:id/#{barcode}.png", 'w')
    f.write @blob
    f.close
  end

  def xunda
    if @aluno.turma.nome.present?
      puts coisa
    else
      puts merda
    end

  end

end
