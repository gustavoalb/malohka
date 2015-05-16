class Curso < ActiveRecord::Base
  belongs_to :nivel
  has_many :turmas
  validates_presence_of [:nome, :codigo, :nivel_id], :message=>"Não pode ficar em branco!"
end
