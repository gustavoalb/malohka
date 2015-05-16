#class Evento < ActiveRecord::Base
#  has_many :ocasioes, :dependent => :destroy
#  accepts_nested_attributes_for :ocasioes, :reject_if => lambda { |a| a[:inicio].blank? }, :allow_destroy => true
#  has_many :periodos, :dependent => :destroy
#  accepts_nested_attributes_for :periodos, :reject_if => lambda { |a| a[:inicio].blank? }, :allow_destroy => true
  #accepts_nested_attributes_for :ocasioes

#  def ocasioes_for_form
#    collection = ocasioes.where(evento_id: id)
#    collection.any? ? collection : ocasioes.build
#  end

#  validates_length_of :nome, :maximum => 30, :message => "O título do evento deverá ter 30 caracteres no máximo"

#  enum tipoevento: {'Palestra'=> 1, 'Congresso'=>2, 'Simpósio'=> 3, 'Seminário'=> 4, 'Outros'=> 5}
#end
