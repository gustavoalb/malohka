module SolicitacoesHelper
  def tabela_solicitacoes (pessoa)
    table_head = %{
      <table class="table table-striped">
      <thead>
      <tr>
      <th>Solicitante</th>
      <th>Tipo de solicitação</th>
      <th>Impresso?</th>
      <th>Entregue?</th>
      <th>Finalizado?</th>
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
        table_body << "<td>#{sim_nao(solicitacao.solicitavel.impresso) }</td>"
        table_body << "<td>#{sim_nao(solicitacao.solicitavel.entregue) }</td>"
        table_body << "<td>#{sim_nao(solicitacao.finalizado) }</td>"
        table_body << "<td>#{solicitacao.created_at.strftime("%d/%m/%y às %H:%M ") }</td>"
        table_body << "<td>#{solicitacao.solicitavel.status }</td>"
        table_body << "<td>#{link_to t('.edit', :default => t("helpers.links.editar")), edit_solicitacao_path(solicitacao),
              :class => 'btn btn-default btn-xs'} #{link_to t('.destroy', :default => t("helpers.links.apagar")), solicitacao_path(solicitacao),
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

  def status_solicitacao(objeto)
    if objeto=="criado"
      return "Criado e em andamento"
    elsif objeto=="finalizado"
      return "Finalizado"
    end
  end

end
