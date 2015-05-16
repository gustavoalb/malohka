require 'test_helper'

class SolicitacoesControllerTest < ActionController::TestCase
  setup do
    @solicitacao = solicitacoes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:solicitacoes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create solicitacao" do
    assert_difference('Solicitacao.count') do
      post :create, solicitacao: { finalizado: @solicitacao.finalizado, solicitante_id: @solicitacao.solicitante_id, tipo_objeto_id: @solicitacao.tipo_objeto_id, tipo_objeto_type: @solicitacao.tipo_objeto_type }
    end

    assert_redirected_to solicitacao_path(assigns(:solicitacao))
  end

  test "should show solicitacao" do
    get :show, id: @solicitacao
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @solicitacao
    assert_response :success
  end

  test "should update solicitacao" do
    patch :update, id: @solicitacao, solicitacao: { finalizado: @solicitacao.finalizado, solicitante_id: @solicitacao.solicitante_id, tipo_objeto_id: @solicitacao.tipo_objeto_id, tipo_objeto_type: @solicitacao.tipo_objeto_type }
    assert_redirected_to solicitacao_path(assigns(:solicitacao))
  end

  test "should destroy solicitacao" do
    assert_difference('Solicitacao.count', -1) do
      delete :destroy, id: @solicitacao
    end

    assert_redirected_to solicitacoes_path
  end
end
