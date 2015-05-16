require 'test_helper'

class ValidarUsuarioControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get salvar_usuario" do
    get :salvar_usuario
    assert_response :success
  end

end
