class Noticia < ActiveRecord::Base
  scope :publicavel, -> {where("status = 'publicavel'",true).order("publicado_em DESC")}
  scope :destaque, -> {where("status = 'em_destaque'",true).order("publicado_em DESC")}
  scope :pauta, -> {where("status = 'em_pauta'",true).order("publicado_em DESC")}
  scope :arquivadas, -> {where("status = 'em_arquivo'",true).order("publicado_em DESC")}

  state_machine :status, :initial => :publicavel do
    #state_machine :status, :initial => :em_destaque do

    event :em_pauta do
      transition any => :em_pauta
    end

    event :em_destaque do
      transition any => :em_destaque
    end

    event :em_arquivo do
      transition any => :em_arquivo
    end

    event :reavaliar do
      transition any => :publicavel
    end


    after_transition :publicavel => :em_pauta do |noticia, transition|
      #   noticia.destaque = false
      #   noticia.pauta = true
      noticia.publicado_em = DateTime.now
      noticia.save
    end

    after_transition :publicavel => :em_destaque do |noticia, transition|
      #   noticia.destaque = true
      noticia.publicado_em = DateTime.now
      noticia.save
    end
  end

  # after_create :change_status

  private
  # def change_status
  #   if self.em_destaque?
  #     self.pauta = true
  #     self.destaque = true
  #   elsif self.em_pauta?
  #     self.destaque = false
  #     self.pauta = true
  #   end
  #   self.save
  # end

end
