class Participacao < ActiveRecord::Base
  belongs_to :componente
  belongs_to :pessoa
  has_many :alunos, through: :pessoa

  validates_uniqueness_of :pessoa_id,:scope=>[:pessoa_id,:componente_id]

end
