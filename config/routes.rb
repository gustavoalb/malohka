Rails.application.routes.draw do

  resources :departamentos
  resources :reparticoes
  resources :certificados

  resources :eventos, only: [:new, :create, :show, :update, :edit, :index] do
    post :registrar_participacao
    get 'certificado'
    get 'lista_frequencia'
    put "alterar_status/:evento_id/:status"=>'eventos#alterar_status', as: :alterar_status
    resources :wizard_evento, only: [:show, :update], controller: 'eventos/wizard_evento'
    member do
      get 'frequencia'
    end
  end


  scope "/forja" do
    resources :componentes
  end


  resources :publicos

  namespace :eventos do
    get 'wizard_evento/show'
    get 'wizard_evento/update'
  end

  resources :ministrantes
  # resources :eventos do
  #   post :registrar_participacao
  # end

  # resources :wizard_usuario#, only: [:edit,:show, :update], controller: 'eventos_wizard'
  resources :wizard_usuario, only: [:show, :update], controller: 'usuarios/wizard_usuario'

  resources :evento_wizard#, only: [:edit,:show, :update], controller: 'eventos_wizard'

  resources :iteracoes do
    put "alterar_status/:iteracao_id/:status"=>'iteracoes#alterar_status', as: :alterar_status
  end

  resources :usuarios
  resources :grupos
  resources :funcionarios do
    get 'cracha_funcional/:funcionario_id'=>'funcionarios#cracha_funcional', as: :cracha_funcional, on: :collection
  end
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
      #get 'iestudantil_do_aluno'
      get "iestudantil_do_aluno"=>'solicitacoes#iestudantil_do_aluno', as: :iestudantil_do_aluno
      put "cancelar_solicitacao/:iestudantil_id/:status"=>'solicitacoes#cancelar_solicitacao', as: :cancelar_solicitacao
      put "alterar_status/:iestudantil_id/:status"=>'solicitacoes#alterar_status', as: :alterar_status
    end
  end

  # scope "" do
  #   resources :paginas
  #   %w["#{id}-#{permalink.to_s.parameterize}"].each do |p|
  #     get p, controller: "static", action: p
  #   end
  # end

  resources :validacao
  resources :validacao_inicial_usuario

  resources :pesquisas

  resources :pessoas do
    get :minha_area
    get 'lista_frequencia'
    get 'certificado'
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

  # assert_routing({ path: 'photos', method: :post }, { controller: 'photos', action: 'create' })
  devise_for :usuarios , path_prefix: 'perfil',:controllers => { :sessions => "sessions"}

  resources :alunos   do
    post 'turmas', on: :collection
    post 'turnos', on: :collection
    post 'cursos_turno', on: :collection
    get 'iestudantil_do_aluno'
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
