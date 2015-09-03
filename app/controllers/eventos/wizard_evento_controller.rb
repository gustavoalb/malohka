class Eventos::WizardEventoController < ApplicationController
  include Wicked::Wizard

  before_action :setup_wizard

  steps *Evento.form_steps

  def show
    @evento = Evento.find(params[:evento_id])
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
      [ componentes_attributes: [ :id, :evento_id, :nome, :tipo_componente, :descricao, :vagas, :local, :status, {:publico_ids => []}, {:ministrante_ids => []}, :_destroy] ]
    when "organizacao"
      [:organizacao, :parceiros, :apoio]
    end

    params.require(:evento).permit(permitted_attributes).merge(form_step: step)
  end

end
