class SessionsController < Devise::SessionsController
 # skip_before_filter :check_concurrent_session

 def create
  super
  set_online_user
end

def destroy
  set_offline_user
  super
end


private
def set_online_user
  current_user.online = true
  current_user.save(validate: false)
end

def set_offline_user
 current_user.online = false
 current_user.save(validate: false)
end
end