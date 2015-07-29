Rails.application.routes.draw do

  resources :iteracoes do
    put "alterar_status/:iteracao_id/:status"=>'iteracoes#alterar_status', as: :alterar_status
  end

  resources :usuarios
  resources :grupos
  resources :funcionarios
  resources :noticias do
    put "alterar_status/:noticia_id/:status"=>'noticias#alterar_status', as: :alterar_status
  end

  #teste do controller static
  # scope "/gte" do
  #   %w[gte pesquisadores projetos].each do |p|
  #     get p, controller: "static", action: p
  #   end
  # end

  #get gte, controller: "static", action: gte
  #teste do controller staticameters: {"tipo"=>"images", "permalink"=>"servicos"}

  scope "/servicos" do
    resources :solicitacoes do
      get 'solicitar_ie/:aluno_id'=>'solicitacoes#solicitar_ie', as: :solicitar_ie, on: :collection
      put "cancelar_solicitacao/:iestudantil_id/:status"=>'solicitacoes#cancelar_solicitacao', as: :cancelar_solicitacao
    end
  end

  # scope "" do
  #   resources :paginas
  #   %w["#{id}-#{permalink.to_s.parameterize}"].each do |p|
  #     get p, controller: "static", action: p
  #   end
  # end

  resources :validacao
  resources :eventos
  resources :pesquisas
  resources :pessoas do
    #    post 'upload', :on => :collection
    get :foto
    post :upload_foto
  end

  # validação de usuário
  get 'validar_usuario/index'

  # atualização de pessoa e aluno
  post 'validar_usuario/salvar_usuario'
  get 'validar_usuario/atualizar_pessoa'
  post 'validar_usuario/salvar_pessoa'
  get 'validar_usuario/atualizar_aluno'
  post 'validar_usuario/salvar_aluno'

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :usuarios , path_prefix: 'perfil',:controllers => { :sessions => "sessions"}

  resources :alunos   do
    post 'turmas', on: :collection
    post 'turnos', on: :collection
    post 'cursos_turno', on: :collection
    get 'iestudantil_do_aluno/:aluno_id'=>'alunos#iestudantil_do_aluno', as: :iestudantil_do_aluno, on: :collection
  end
  resources :turmas do
    post 'cursos', on: :collection
  end
  resources :cursos
  resources :niveis

  resources :paginas #do
  #   get 'nova_pagina' => 'paginas#new', as: :nova_pagina
  # end

  #get 'estaticos/index'

  resources :estaticos

  #este aqui libera o permalink - começo
  scope "conteudo/:tipo" do
    get ':permalink', to: 'paginas#permalink', as: :permalink
  end

  #este aqui libera o permalink - fim

  root :to => "home#principal"
end
