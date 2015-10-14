module ApplicationHelper
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
               concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
               concat message
      end)
    end
    nil
  end

  def sim_nao(objeto)
    if objeto==true
      return "Sim"
    else
      return "Não"
    end
  end

  def ver_form_nil(objeto,atributo=nil)
    if !objeto.nil? and atributo.nil?
      if objeto.respond_to?(:nome)
        return objeto.nome
      elsif !objeto.respond_to?(:nome) and objeto.respond_to?(:codigo)
        return objeto.codigo
      elsif !objeto.respond_to?(:nome) and !objeto.respond_to?(:codigo) and objeto.is_a?(String)
        return objeto
      elsif !objeto.respond_to?(:nome) and !objeto.respond_to?(:codigo) and objeto.is_a?(DateTime)
        return objeto.to_s_br
      end
    elsif !objeto.nil? and !atributo.nil?
      if objeto.send(atributo).respond_to?(:nome)
        return objeto.send(atributo).nome
      elsif !objeto.send(atributo).respond_to?(:nome) and objeto.send(atributo).respond_to?(:codigo)
        return objeto.send(atributo).codigo
      elsif !objeto.send(atributo).respond_to?(:nome) and !objeto.send(atributo).respond_to?(:codigo) and objeto.send(atributo).respond_to?(:matricula)
        return objeto.send(atributo).matricula
      else
        return objeto.send(atributo)
      end
    elsif objeto.nil?
      return "Nada Cadastrado"
    end
  end


  def ver_form_nil_temp(objeto)
    if objeto
      return objeto
    elsif objeto.nil?
      return "Nada Cadastrado"
    else
      return "Nada Cadastrado"
    end
  end


  def tipo_solicitavel(solicitacao)
    if solicitacao=='Iestudantil'  #and objeto="Iestudantil"
      return "Identidade Estudantil"
    else
      return "Nada cadastrado"
    end
  end


  def abre_estilo_5a12_no_well_1
    div_5a12_1 = %{
      <div class="col-sm-12 col-md-12, row">
      <div class="col-sm-5 col-md-7, thumbnail, center">
    }
    html = div_5a12_1
    raw(html)
  end

  def abre_estilo_5a12_well_1
    div_5a12_1 = %{
      <div class="col-sm-12 col-md-12, row, well">
      <div class="col-sm-5 col-md-7, thumbnail, center">
    }
    html = div_5a12_1
    raw(html)
  end

  def abre_estilo_5a12_well_2
    div_5a12_2 = %{
      </div>
      <div class="col-sm-4 col-md-7">
    }
    html = div_5a12_2
    raw(html)
  end

  def fecha_estilo_5a12_well_1_e_2
    div_5a12_2 = %{
      </div>
      </div>
    }
    html = div_5a12_2
    raw(html)
  end

  def abre_estilo_12_well
    div_12 = %{
      <div class="col-sm-12 col-md-12, row, well">
    }
    html = div_12
    raw(html)
  end

  def fecha_estilo_12_well
    div_12 = %{
      </div>
    }
    html = div_12
    raw(html)
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    # link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end


  def abre_acordeao (objeto_principal)
    html = ""
    html+="<div class='panel-heading'>"
    # <% for componente in @evento.componentes %>
    html+="<h4 class='panel-title'>"
    html+="<div class='panel-group' id='accordion' role='tablist' aria-multiselectable='true'>"
    html+="<div class='panel panel-default'>"
    html+="<div class='panel-heading' role='tab' id='evento-#{objeto_principal.id}-label'>"
    html+="<h4 class='panel-title'>"
    # original
    # html+="<a role='button' data-toggle='collapse' data-parent='#accordion' href='#evento-#{objeto_principal.id}' aria-expanded='true' aria-controls='evento-#{objeto_principal.id}'> componente.periodo.inicio - #{objeto_principal.nome}"
    # original
    # derivado
    html+="<a role='button' data-toggle='collapse' data-parent='#accordion' href='#evento-#{objeto_principal.id}' aria-expanded='true' aria-controls='evento-#{objeto_principal.id}'>#{objeto_principal.nome}"
    # derivado

    html+="</a>"
    html+="</h4>"
    html+="</div>"
    html+="<div id='evento-#{objeto_principal.id}' class='panel-collapse collapse' role='tabpanel' aria-labelledby='evento-#{objeto_principal.id}-label'>"
    html+="<div class='panel-body'>"
    html+="<p>#{objeto_principal.nome}</p>"

    # <% end %>
    return raw(html)
  end

  def fecha_acordeao (objeto_principal)
    html = ""
    # <%# for componente in @evento.componentes %>

    html+="</div>"
    html+="</div>"
    html+="</div>"
    html+="</div>"
    html+="</h4>"
    # <% end %>
    html+="</div>"
    return raw(html)
  end

  # def tabela_solicitacoes (pessoa)

  #   table_body = ""
  #   Iestudantil.da_pessoa(pessoa.id).each do |ie|
  #     Solicitacao.do_objeto(ie.id).each do |solicitacao|
  #       table_body << "<tr>"
  #       table_body << "<td>#{solicitacao.solicitavel.aluno.matricula }</td>"
  #       table_body << "<td>#{link_to tipo_solicitavel(solicitacao.solicitavel_type), solicitacao_path(solicitacao) }</td>"

  #       table_body << "<td>#{solicitacao.created_at.strftime("%d/%m/%y às %H:%M ") }</td>"
  #       table_body << "<td>#{status_solicitavel(solicitacao.solicitavel.status) }</td>"
  #       table_body << "<td>#{link_to t('.destroy', :default => t("helpers.links.apagar")), solicitacao_path(solicitacao),
  #             :method => :delete,
  #             :data => { :confirm => t('.confirm', :default => t("helpers.links.confirm", :default => 'Are you sure?')) },
  #             :class => 'btn btn-xs btn-danger' }
  #             #{link_to 'Cancelar', solicitacao_cancelar_solicitacao_path(solicitacao.id,ie.id,'cancelado'), method: :put, :class => 'btn btn-primary btn-xs'}
  #             </td>"
  #       table_body << "</tr>"
  #     end
  #   end
  #   table_body << "</tbody>"
  #   table_body << "</table>"

  #   html = table_head + table_body
  #   raw(html)
  # end

  def validade_aluno(aluno)
    duracao = aluno.turma.curso.duracao
    periodo_atual = aluno.periodo_atual
    a_cursar = (duracao - periodo_atual)
    semestres_restantes = Time.now + (a_cursar*6).month
    if semestres_restantes.month >= 7
      return "dez/#{semestres_restantes.year}"
    elsif semestres_restantes.month <= 5
      return "jun/#{semestres_restantes.year}"
    end
  end

  def duracao_periodo(periodo)
    inicio = periodo.inicio
    termino = periodo.termino
    duracao = (periodo.termino - periodo.inicio) / 60
    if duracao
      return duracao
    end
  end

  def tutorial_progress_bar
    content_tag(:section, class: "content") do
      content_tag(:div, class: "navigator") do
        content_tag(:ol) do
          wizard_steps.collect do |every_step|
            class_str = "unfinished"
            class_str = "current"  if every_step == step
            class_str = "finished" if past_step?(every_step)
            concat(
              content_tag(:li, class: class_str) do
                link_to I18n.t(every_step), wizard_path(every_step)
              end
            )
          end
        end
      end
    end
  end

end
