require 'test_helper'

class IteracoesControllerTest < ActionController::TestCase
  setup do
    @iteracao = iteracoes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:iteracoes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create iteracao" do
    assert_difference('Iteracao.count') do
      post :create, iteracao: { nome: @iteracao.nome, status: @iteracao.status }
    end

    assert_redirected_to iteracao_path(assigns(:iteracao))
  end

  test "should show iteracao" do
    get :show, id: @iteracao
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @iteracao
    assert_response :success
  end

  test "should update iteracao" do
    patch :update, id: @iteracao, iteracao: { nome: @iteracao.nome, status: @iteracao.status }
    assert_redirected_to iteracao_path(assigns(:iteracao))
  end

  test "should destroy iteracao" do
    assert_difference('Iteracao.count', -1) do
      delete :destroy, id: @iteracao
    end

    assert_redirected_to iteracoes_path
  end
end
