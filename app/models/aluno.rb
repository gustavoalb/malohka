class Aluno < ActiveRecord::Base
  belongs_to :turma
  belongs_to :pessoa
  has_many :carteiras, class_name: 'Iestudantil'
  has_many :niveis
  has_one :usuario
  accepts_nested_attributes_for :pessoa, :allow_destroy => true
  validates_presence_of [:matricula, :ano_ingresso, :curso, :semestre_atual], :message=>"Não pode ficar em branco!"
  validates :turma_id, :presence => true, :on => :update

  scope :da_pessoa, where('alunos.pessoa_id = ?', p)
  scope :doze, -> {where("ano_ingresso = '2012'",true)}
  scope :treze, -> {where("ano_ingresso = '2013'",true)}
  scope :quatorze, -> {where("ano_ingresso = '2014'",true)}
  scope :quinze, -> {where("ano_ingresso = '2015'",true)}
  #scope :fotas, -> {where("@aluno.pessoa.foto_file_name = nil",true)}

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
      puts teste
    end
  end

  state_machine :status, :initial => :pendente do
    event :atualizar do
      transition :pendente => :atualizado
    end
    event :decair do
      transition :atualizado => :pendente
    end

    after_transition :pendente => :atualizado do |aluno, transition|
      aluno.save!
    end
  end

end
