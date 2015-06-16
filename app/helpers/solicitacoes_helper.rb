module SolicitacoesHelper
  def tabela_solicitacoes (pessoa)
    table_head = %{
      <table class="table table-striped">
      <thead>
      <tr>
      <th>Solicitante</th>
      <th>Tipo de solicitação</th>
      <th>Iniciado em</th>
      <th>Status</th>
      <th>Ações</th>
      <th colspan="3"></th>
      </tr>
      </thead>
      <tbody align="CENTER" >
    }
    table_body = ""
    Iestudantil.da_pessoa(pessoa.id).each do |ie|
      Solicitacao.do_objeto(ie.id).each do |solicitacao|
        table_body << "<tr>"
        table_body << "<td>#{solicitacao.solicitavel.aluno.matricula }</td>"
        table_body << "<td>#{link_to tipo_solicitavel(solicitacao.solicitavel_type), solicitacao_path(solicitacao) }</td>"

        table_body << "<td>#{solicitacao.created_at.strftime("%d/%m/%y às %H:%M ") }</td>"
        table_body << "<td>#{status_solicitavel(solicitacao.solicitavel.status) }</td>"
        table_body << "<td>#{link_to t('.destroy', :default => t("helpers.links.apagar")), solicitacao_path(solicitacao),
              :method => :delete,
              :data => { :confirm => t('.confirm', :default => t("helpers.links.confirm", :default => 'Are you sure?')) },
              :class => 'btn btn-xs btn-danger' }</td>"
        table_body << "</tr>"
      end
    end
    table_body << "</tbody>"
    table_body << "</table>"

    html = table_head + table_body
    raw(html)
  end

  #{link_to t('.edit', :default => t("helpers.links.editar")), edit_solicitacao_path(solicitacao), :class => 'btn btn-default btn-xs'}

  def status_solicitavel(objeto)
    # Em solicitações
    if objeto=="criado"
      return "Solicitação realizada e encaminhada para as devidas providências."
    elsif objeto=="finalizado"
      return "Solicitação conluída."
      # Em Iestudantil
    elsif objeto=="solicitado"
      return "A espera de seleção em arquivo de lote para impressão."
    elsif objeto=="para_impressao"
      return "Selecionado em arquivo de lote e a espera de impressão."
    elsif objeto=="impresso"
      return "Objeto impresso a ser separado para entrega."
    elsif objeto=="entregue"
      return "Entrega confirmada."
    elsif objeto=="cancelado"
      return "Solicitação cancelada"
    end
  end



  def status_iestudantil(objeto)
    if objeto=="entregue"
      return "finalizado"
    else #if objeto=="impresso"
      return "em andamento"
    end
  end


end
