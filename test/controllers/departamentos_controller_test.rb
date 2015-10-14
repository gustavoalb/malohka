require 'test_helper'

class DepartamentosControllerTest < ActionController::TestCase
  setup do
    @departamento = departamentos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:departamentos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create departamento" do
    assert_difference('Departamento.count') do
      post :create, departamento: { data_criacao: @departamento.data_criacao, nome: @departamento.nome, portaria_criacao: @departamento.portaria_criacao, reparticao_id: @departamento.reparticao_id, sigla: @departamento.sigla }
    end

    assert_redirected_to departamento_path(assigns(:departamento))
  end

  test "should show departamento" do
    get :show, id: @departamento
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @departamento
    assert_response :success
  end

  test "should update departamento" do
    patch :update, id: @departamento, departamento: { data_criacao: @departamento.data_criacao, nome: @departamento.nome, portaria_criacao: @departamento.portaria_criacao, reparticao_id: @departamento.reparticao_id, sigla: @departamento.sigla }
    assert_redirected_to departamento_path(assigns(:departamento))
  end

  test "should destroy departamento" do
    assert_difference('Departamento.count', -1) do
      delete :destroy, id: @departamento
    end

    assert_redirected_to departamentos_path
  end
end
