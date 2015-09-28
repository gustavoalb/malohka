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
  enum local: {'Auditório'=> 1, 'Hall do Auditório'=>2, 'Biblioteca'=> 3, 'Laboratório'=> 4, 'Sala de aula'=> 3}
  # validates :vagas, numericality: true#, :message=>"Apenas numeros!"

  scope :do_evento, lambda{|evento_id|
    joins(:componentes).where('componentes.evento_id=?',evento_id)
  }

  scope :do, lambda{|evento_id|
    joins(:componente).where('componentes.evento_id=?',evento_id)
  }

  # def publico?(publico)
  #   publicos = []
  #   self.publicos.each do |p|
  #     publicos << p.nome.downcase
  #   end
  #   publicos.include? publico.to_s.downcase
  # end

  # def ministrante?(ministrante)
  #   ministrantes = []
  #   self.ministrantes.each do |m|
  #     ministrantes << m.nome.downcase
  #   end
  #   ministrantes.include? ministrante.to_s.downcase
  # end

end
