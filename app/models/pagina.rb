class Pagina < ActiveRecord::Base
  validates_uniqueness_of :permalink

  # enum tipo_id: {'principal'=> 1, 'gte'=>2, 'servicos'=> 3}
  enum tipo: {'Principal'=> 'principal', 'Gte'=>'gte', 'Serviços'=> 'servicos'}
  #inherited_resources
  #actions :show

  # before_filter do
  #   if request.get? && params.key?(:id)
  #     if resource.to_param != params[:id]
  #       params[:id] = resource.to_param
  #       return redirect_to url_for(params), :status => 301
  #     end
  #   end
  # end

  # def to_param
  #   permalink
  # end
  def to_param
    #    "#{permalink.to_s.parameterize}"
    "#{id}"
  end
end
