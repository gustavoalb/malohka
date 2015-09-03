require 'test_helper'

class PublicosControllerTest < ActionController::TestCase
  setup do
    @publico = publicos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:publicos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create publico" do
    assert_difference('Publico.count') do
      post :create, publico: { descricao: @publico.descricao, nome: @publico.nome }
    end

    assert_redirected_to publico_path(assigns(:publico))
  end

  test "should show publico" do
    get :show, id: @publico
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @publico
    assert_response :success
  end

  test "should update publico" do
    patch :update, id: @publico, publico: { descricao: @publico.descricao, nome: @publico.nome }
    assert_redirected_to publico_path(assigns(:publico))
  end

  test "should destroy publico" do
    assert_difference('Publico.count', -1) do
      delete :destroy, id: @publico
    end

    assert_redirected_to publicos_path
  end
end
