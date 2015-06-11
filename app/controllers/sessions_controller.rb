class SessionsController < Devise::SessionsController
  # skip_before_filter :check_concurrent_session
  skip_before_filter :validar_usuario
  def create
    super

  end

  def destroy

    super
  end


  private
  def set_online_user
    current_usuario.online = true
    current_usuario.save(validate: false)
  end

  def set_offline_usuario
    current_usuario.online = false
    current_usuario.save(validate: false)
  end
end
