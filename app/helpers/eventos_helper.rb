module EventosHelper

  def status(objeto)
    if objeto=='criado'
      return 'Evento criado e a espera de customização'
    elsif objeto=='em_customizacao'
      return 'Evento em fase de customização a ter acesso liberado ao público'
    elsif objeto=='acesso_liberado'
      return 'Evento com acesso liberado ao público'
    elsif objeto=="inscricoes_iniciadas"
      return 'Evento com inscrições liberadas'
    elsif objeto=='inscricoes_finalizadas'
      return 'Evento com Inscrições finalizadas'
    elsif objeto=='finalizado'
      return 'Evento com finalizado mas ainda em pauta'
    elsif objeto=='arquivado'
      return 'Evento arquivado'
    end
  end

  def tipo_plural(objeto)
    if objeto=='Atividade com credenciamento'
      return 'Atividades'
    elsif objeto=='Protocolo de cerimonial'
      return 'Protocolos de cerimonial'
    elsif objeto=='Atividade comum'
      return 'Atividades comuns'
    end
  end
end
