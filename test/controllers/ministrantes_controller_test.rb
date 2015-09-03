require 'test_helper'

class MinistrantesControllerTest < ActionController::TestCase
  setup do
    @ministrante = ministrantes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ministrantes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ministrante" do
    assert_difference('Ministrante.count') do
      post :create, ministrante: { biografia: @ministrante.biografia, nome: @ministrante.nome, organizacao: @ministrante.organizacao, pessoa_id: @ministrante.pessoa_id }
    end

    assert_redirected_to ministrante_path(assigns(:ministrante))
  end

  test "should show ministrante" do
    get :show, id: @ministrante
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ministrante
    assert_response :success
  end

  test "should update ministrante" do
    patch :update, id: @ministrante, ministrante: { biografia: @ministrante.biografia, nome: @ministrante.nome, organizacao: @ministrante.organizacao, pessoa_id: @ministrante.pessoa_id }
    assert_redirected_to ministrante_path(assigns(:ministrante))
  end

  test "should destroy ministrante" do
    assert_difference('Ministrante.count', -1) do
      delete :destroy, id: @ministrante
    end

    assert_redirected_to ministrantes_path
  end
end
