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

  def ver_form_nil(objeto)
    if objeto==nil
      return "Nada cadastrado"
    elsif objeto.blank?
      return "Nada cadastrado"
    elsif objeto!=nil
      if objeto.is_a?DateTime
        return "objeto"
      else
        objeto
      end
    end
    #else
    # return "xunda"
    #end
  end

  def tipo_solicitavel(solicitacao)
    if solicitacao=='Iestudantil'  #and objeto="Iestudantil"
      return "Identidade Estudantil"
    else
      return "Nada cadastrado"
    end
  end


  def abre_estilo_5a12_well
    div_5a12 = %{
      <div class="col-sm-12 col-md-12, row, well">
      <div class="col-sm-5 col-md-7, thumbnail, center">
    }
    html = div_5a12
    raw(html)
  end

  def fecha_estilo_5a12_well
    div_5a12 = %{
      </div>
      </div>
    }
    html = div_5a12
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

end
