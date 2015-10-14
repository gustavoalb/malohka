class Reparticao < ActiveRecord::Base
  belongs_to :orgao
  has_many :departamentos
end
