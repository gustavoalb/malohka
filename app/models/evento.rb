class Evento < ActiveRecord::Base
  has_many :periodos, :dependent => :destroy
  accepts_nested_attributes_for :periodos,  :allow_destroy => true
end
