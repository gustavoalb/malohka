require 'test_helper'

class StaticControllerTest < ActionController::TestCase
  test "should get grupo_de_pesquisa" do
    get :grupo_de_pesquisa
    assert_response :success
  end

  test "should get sobre_o_gte" do
    get :sobre_o_gte
    assert_response :success
  end

  test "should get linhas_de_pesquisa" do
    get :linhas_de_pesquisa
    assert_response :success
  end

  test "should get pesquisadores" do
    get :pesquisadores
    assert_response :success
  end

  test "should get projetos" do
    get :projetos
    assert_response :success
  end

  test "should get historico" do
    get :historico
    assert_response :success
  end

  test "should get funcionamento" do
    get :funcionamento
    assert_response :success
  end

  test "should get organograma" do
    get :organograma
    assert_response :success
  end

  test "should get como_chegar" do
    get :como_chegar
    assert_response :success
  end

end
