class Publico < ActiveRecord::Base
  has_and_belongs_to_many :componentes
end
