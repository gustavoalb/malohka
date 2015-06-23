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

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

end
