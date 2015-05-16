class Resposta < ActiveRecord::Base
  belongs_to :pergunta, :dependent => :destroy
  #accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
end
