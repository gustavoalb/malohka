class Funcionario < ActiveRecord::Base
  belongs_to :pessoa
  accepts_nested_attributes_for :pessoa, :allow_destroy => true
end
