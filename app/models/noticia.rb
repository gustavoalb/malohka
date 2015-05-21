class Noticia < ActiveRecord::Base

  scope :publicavel, -> {where("publicado = false and status = 'publicavel'",true).order("publicado_em DESC")}
  scope :destaque, -> {where("publicado = true and status = 'em_destaque'",true).order("publicado_em DESC")}
  scope :pauta, -> {where("publicado = true and status = 'em_pauta'",true).order("publicado_em DESC")}
  scope :arquivadas, -> {where("publicado = false and destaque = false",true).order("publicado_em DESC")}

  state_machine :status, :initial => :publicavel do
    #state_machine :status, :initial => :em_destaque do

    event :em_pauta do
      transition any => :em_pauta
    end

    event :em_destaque do
      transition any => :em_destaque
    end


    after_transition :em_destaque => :em_pauta do |noticia, transition|
      noticia.destaque = false
      noticia.pauta = true
      noticia.save

    end

    after_transition :em_pauta => :em_destaque do |noticia, transition|
      noticia.destaque = true
      noticia.pauta = true
      noticia.save
    end
  end

  after_create :change_status

  private
  def change_status
    if self.em_destaque?
      self.pauta = true
      self.destaque = true
    elsif self.em_pauta?
      self.destaque = false
      self.pauta = true
    end
    self.save
  end

end
