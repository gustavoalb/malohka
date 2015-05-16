class Nivel < ActiveRecord::Base
  has_many :cursos
  validates_presence_of [:nome, :codigo], :message=>"Não pode ficar em branco!"
end
