class Componente < ActiveRecord::Base
  belongs_to :evento
  belongs_to :ministrante
  has_and_belongs_to_many :publicos
  has_and_belongs_to_many :ministrantes
  has_many :periodos, :dependent => :destroy
  accepts_nested_attributes_for :periodos, :allow_destroy => true#, :reject_if => lambda { |a| a[:inicio].blank? }
  # accepts_nested_attributes_for :periodos, :allow_destroy => true, :reject_if => lambda { |a| a[:inicio].blank? }

  has_many :participacoes
  has_many :pessoas,     :through => :participacoes

  enum tipo_componente: {'Palestra'=> 1, 'Seminário'=>2, 'Minicurso'=> 3, 'Mesa redonda'=> 4, 'Mostra Técnica'=> 5, 'Atividade Cultural'=> 6}
  enum local: {'Auditório'=> 1, 'Hall do Auditório'=>2, 'Biblioteca'=> 3, 'Laboratório'=> 4, 'Hall de entrada do IFAP'=> 5, 'Sala de aula 1'=> 11, 'Sala de aula 2'=> 12, 'Sala de aula 3'=> 13, 'Sala de aula 4'=> 14, 'Sala de aula 5'=> 15, 'Sala de aula 6'=> 16, 'Sala de aula 7'=> 17, 'Sala de aula 8'=> 18, 'Sala de aula 9'=> 19, 'Sala de aula 10'=> 20, 'Sala de aula 11'=> 21, 'Sala de aula 12'=> 22, 'Sala de aula 13'=> 23, 'Sala de aula 14'=> 24, 'Sala de aula 15'=> 25, 'Sala de aula 16'=> 26, 'Sala de aula 17'=> 27, 'Sala de aula 18'=> 28, 'Sala de aula 19'=> 29, 'Sala de aula 20'=> 30, 'Sala de aula 21'=> 31, 'Sala de aula 22'=> 32, 'Sala de aula 23'=> 33, 'Sala de aula 24'=> 34}
  # validates :vagas, numericality: true#, :message=>"Apenas numeros!"

  # scope :do_evento, lambda{|evento_id|
  #   joins(:componentes).where('componentes.evento_id=?',evento_id)
  # }
  scope :destaques_do_evento, lambda{|evento_id| where("evento_id=?",evento_id).limit(3)}
  scope :do_evento, lambda{|evento_id| where("@evento_id=?",evento_id)}

end
