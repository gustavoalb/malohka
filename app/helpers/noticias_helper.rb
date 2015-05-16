module NoticiasHelper

  def descricao(params)
    if params[:pauta]==false
      return "Sem Pauta"
    elsif params[:pauta] == true
      return "Com pauta"
    end
  end



end
