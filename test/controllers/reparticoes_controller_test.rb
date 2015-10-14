require 'test_helper'

class ReparticoesControllerTest < ActionController::TestCase
  setup do
    @reparticao = reparticoes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reparticoes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reparticao" do
    assert_difference('Reparticao.count') do
      post :create, reparticao: { data_criacao: @reparticao.data_criacao, descricao: @reparticao.descricao, nome: @reparticao.nome, sigla: @reparticao.sigla }
    end

    assert_redirected_to reparticao_path(assigns(:reparticao))
  end

  test "should show reparticao" do
    get :show, id: @reparticao
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reparticao
    assert_response :success
  end

  test "should update reparticao" do
    patch :update, id: @reparticao, reparticao: { data_criacao: @reparticao.data_criacao, descricao: @reparticao.descricao, nome: @reparticao.nome, sigla: @reparticao.sigla }
    assert_redirected_to reparticao_path(assigns(:reparticao))
  end

  test "should destroy reparticao" do
    assert_difference('Reparticao.count', -1) do
      delete :destroy, id: @reparticao
    end

    assert_redirected_to reparticoes_path
  end
end
