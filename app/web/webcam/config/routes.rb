Rails.application.routes.draw do
  resources :photos, :only => [:index, :show, :new, :create] do
    post 'upload', :on => :collection
  end

  root :to => redirect("/photos")
end
