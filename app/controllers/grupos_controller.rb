class GruposController < ApplicationController
  load_and_authorize_resource
  before_action :set_grupo, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @grupos = Grupo.all
    respond_with(@grupos)
  end

  # http://code.google.com/apis/chart/interactive/docs/gallery/orgchart.html#Example
  def org_chart

    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Name'   )
    data_table.new_column('string', 'Manager')
    data_table.new_column('string', 'ToolTip')
    data_table.add_rows( [
                           [ {:v => 'Mike', :f => 'Mike<div style="color:red; font-style:italic">President</div>'   }, ''    , 'The President' ],
                           [ {:v => 'Jim' , :f => 'Jim<div style="color:red; font-style:italic">Vice President<div>'}, 'Mike', 'VP'            ],
                           [ 'Alice'  , 'Mike', ''           ],
                           [ 'Bob'    , 'Jim' , 'Bob Sponge' ],
                           [ 'Carol'  , 'Bob' , ''           ]
    ] )

    opts   = { :allowHtml => true }
    @chart = GoogleVisualr::Interactive::OrgChart.new(data_table, opts)

  end

  def show
    respond_with(@grupo)
  end

  def new
    @grupo = Grupo.new
    respond_with(@grupo)
  end

  def edit
  end

  def create
    @grupo = Grupo.new(grupo_params)
    @grupo.save
    respond_with(@grupo)
  end

  def update
    @grupo.update(grupo_params)
    respond_with(@grupo)
  end

  def destroy
    @grupo.destroy
    respond_with(@grupo)
  end

  private
  def set_grupo
    @grupo = Grupo.find(params[:id])
  end

  def grupo_params
    params.require(:grupo).permit(:nome, :descricao)
  end
end
