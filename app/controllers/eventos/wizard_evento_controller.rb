class Eventos::WizardEventoController < ApplicationController
  include Wicked::Wizard

  before_action :setup_wizard

  steps *Evento.form_steps

  def show
    @evento = Evento.find(params[:evento_id])
    @componentes = Componente.where('componentes.evento_id=?',@evento.id)#.order("publicado_em DESC").all
    @publicos = Publico.all.order(:nome)
    @ministrantes = Ministrante.all.order(:nome)
    x = 1.times do
      componentes = @evento.componentes.build
      1.times { componentes.periodos.build }
    end
    # @periodos_por_dia = @evento.periodos.group_by { |t| t.inicio.strftime("%d/%m/%y") }

    render_wizard
  end


  def update
    @evento = Evento.find(params[:evento_id])
    @evento.update(evento_params(step))
    render_wizard @evento
  end

  def finish_wizard_path
    evento_path(@evento)
  end

  private

  def evento_params(step)
    permitted_attributes = case step
    when "inicio"
      [:nome, :descricao, :responsavel_id]
    when "midias"
      [:banner, :logo]
    when "atividades"
      [
        componentes_attributes:
        [ :id, :evento_id, :nome, :tipo_componente, :descricao, :vagas, :local, :status, {:publico_ids => []}, {:ministrante_ids => []}, :_destroy]
      ]

    when "periodos"
      [
        periodos_attributes:
        [ :id, :componente_id, :inicio, :termino, :_destroy]
      ]

      # [ componentes_attributes: [ :id, :evento_id, :nome, :tipo_componente, :descricao, :vagas, :local, :status, {:publico_ids => []}, {:ministrantes_ids => []}, :_destroy], periodos_attributes: [ :id, :componente_id, :inicio, :termino, :_destroy ] ]

    when "organizacao"
      [:organizacao, :parceiros, :apoio]
    end

    params.require(:evento).permit(permitted_attributes).merge(form_step: step)
  end

end
