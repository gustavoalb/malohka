class Preposto < ActiveRecord::Base
  # belongs_to :pessoa
  # belongs_to :gerenciador, class_name: "Pessoa"
  # belongs_to :atividade, class_name: "Componente"
  belongs_to :componente
  belongs_to :gerenciador, class_name: "Pessoa"

  # accepts_nested_attributes_for :gerenciador

end
