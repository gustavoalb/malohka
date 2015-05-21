class Nivel < ActiveRecord::Base
  has_many :cursos
  has_many :turmas
  validates_presence_of [:nome, :codigo], :message=>"Não pode ficar em branco!"
end
