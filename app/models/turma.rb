class Turma < ActiveRecord::Base
  belongs_to :curso
  has_many :alunos
  enum turno: {'Manhã'=> 1, 'Tarde'=>2, 'Noite'=> 3}
  validates_presence_of [:nome, :codigo, :turno], :message=>"Não pode ficar em branco!"
end
