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

  def status_iestudantil(objeto)
    if objeto=="solicitado"
      return "Solicitado"
    elsif objeto=="impresso"
      return "Impresso"
    elsif objeto=="entregue"
      return "Entregue"
    end
  end

  def tipo_solicitavel(solicitacao)
    if solicitacao=='Iestudantil'  #and objeto="Iestudantil"
      return "Identidade Estudantil"
    else
      return "Nada cadastrado"
    end
  end


  def continuar(form)
    html=""
    voltar="<i class='fa fa-hand-left icon-white'></i> Voltar"
    if current_usuario
      html+="#{link_to raw(voltar),previous_wizard_path,:class=>'btn btn-warning'} "
    end
    html+= "<button class='btn btn-success' type='submit'>Continuar <i class='fa fa-hand-right icon-white'></i></button>"
    #html+="#{form.submit}"
    return html.html_safe
  end


  def continuar_tag
    html=""
    voltar="<i class='fa fa-hand-left icon-white'></i> Voltar"
    if current_usuario
      html+="#{link_to raw(voltar),previous_wizard_path,:class=>'btn btn-warning'} "
    end
    html+= "<button class='btn btn-success' type='submit'>Continuar <i class='fa fa-hand-right icon-white'></i></button>"
    #html+="#{form.submit}"
    return html.html_safe
  end


end
