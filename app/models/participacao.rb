class Participacao < ActiveRecord::Base
  belongs_to :periodo
  belongs_to :pessoa
end
