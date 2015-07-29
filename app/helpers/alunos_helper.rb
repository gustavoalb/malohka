module AlunosHelper
  def formulario_aluno(aluno)
    div_well = %{
      <div class="col-sm-12 col-md-12, row, well">
      <div class="col-sm-5 col-md-7, thumbnail, center">
      <div align="CENTER">

      <table>
      <tr>
      <td><strong>Curso: &nbsp;</strong></td>
      <td> #{ @aluno.curso }</td>
      </tr>
      #{ @aluno.curso_id.present? }

      </tr>
      </table>



      #{ @aluno.curso }
      </div>
      </div>
      </div>
    }
    if @aluno.curso_id.present?
      @aluno.curso_id
    else
      xunda
    end

    def validade(objeto)
      if objeto.month >= 7
        return "sim"
      elsif objeto.month <= 5
        return "Nao"
      end
    end

    # if @aluno.turma==nil
    #   @aluno.turma.nome
    # else
    #   xunda
    # end

    # if @aluno.turma==nil

    # else
    #   @aluno.turma.nome
    # end

    def turma_presente
      if @aluno.turma==nil
        @aluno.id
      else
        @aluno.turma.nome
      end
    end
    #     "#{ if @aluno.curso_id.present? }"
    # <tr>
    # <td><strong>Curso: &nbsp;</strong></td>
    # <td> "#{ @aluno.curso_id }</td>"
    # </tr>
    # "#{ else }"
    # xunda
    # "#{ @aluno.curso_id }"
    # "#{ end }
    # <tr>
    # <td><strong>Matrícula: &nbsp;</strong></td>
    # <td> <%= @aluno.matricula %></td>
    # </tr>
    # <% if @aluno.turma.nome.present? %>
    # <tr>
    # <td><strong>Turma: &nbsp;</strong></td>
    # <td> <%= @aluno.turma.nome %></td>
    # </tr>
    # <% else %>
    # merda
    # <% end %>
    # <tr>
    # <td><strong>Ano de ingresso: &nbsp;</strong></td>
    # <td> <%= @aluno.ano_ingresso %></td>



    #     <%= simple_nested_form_for @aluno, :html => { :class => 'form-vertical' } do |f| %>
    #       <% if @aluno.pessoa.foto.present? %>
    #       <%= image_tag(@aluno.pessoa.foto.url(:medium)) %>
    #       <%= f.simple_fields_for @pessoa do |p| %>
    #         <%= p.input :foto, as: :file, label: 'Atualizar foto' %>
    #       <% end -%>
    #       <% else %>
    #       <%= f.simple_fields_for @pessoa do |p| %>
    #         <%= image_tag("anonimo.jpg", size: "250") %>
    #         <%= p.input :foto, as: :file, label: false %>
    #       <% end %>
    #     <% end -%>
    #     </div>
    #     <div>
    #     <table>
    #     <tr>
    #     <td><strong>Curso: &nbsp;</strong></td>
    #     <td> <%= @aluno.curso %></td>
    #     </tr>
    #     <% if @aluno.curso_id.present? %>
    #     <tr>
    #     <td><strong>Curso: &nbsp;</strong></td>
    #     <td> <%= @aluno.curso_id %></td>
    #     </tr>
    #     <% else %>
    #     xunda<%= @aluno.curso_id %>
    #   <% end %>
    #   <tr>
    #   <td><strong>Matrícula: &nbsp;</strong></td>
    #   <td> <%= @aluno.matricula %></td>
    #   </tr>
    #   <% if @aluno.turma.nome.present? %>
    #   <tr>
    #   <td><strong>Turma: &nbsp;</strong></td>
    #   <td> <%= @aluno.turma.nome %></td>
    #   </tr>
    #   <% else %>
    #   merda
    # <% end %>
    # <tr>
    # <td><strong>Ano de ingresso: &nbsp;</strong></td>
    # <td> <%= @aluno.ano_ingresso %></td>
    # </tr>
    # </table>
    # </div>
    # </div>
    # <div class="col-sm-4 col-md-7">
    # <% if can? :manage, @aluno %>
    # <%= render 'manage', :f => f %>
    # <% end -%>
    # </div>
    # </div>
    html = div_well
    raw(html)
  end
end
