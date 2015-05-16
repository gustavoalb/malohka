Rails.application.routes.draw do

  resources :noticias do
    put "atualizar_status/:noticia_id/:status"=>'noticias#atualizar_status', as: :atualizar_status
  end

  scope "/gte" do
    %w[gte sobre_o_gte linhas_de_pesquisa pesquisadores projetos].each do |p|
      get p, controller: "static", action: p
    end
  end

  # %w[servicos contato sobre organograma como_chegar ops].each do |p|
  #   get p, controller: "static", action: p
  # end

  # %w[:paginas].each do |p|
  #   get p, controller: "paginas", action: p
  # end

  scope "/servicos" do
    resources :solicitacoes do
      get 'solicitar_ie/:aluno_id'=>'solicitacoes#solicitar_ie', as: :solicitar_ie, on: :collection
    end
  end


  #meu teste de ajax
  # resources :noticias do
  #   get 'toggle_destaque', :on => :member
  # end
  #termina aqui

  # scope "" do
  #   resources :paginas
  #   %w["#{id}-#{permalink.to_s.parameterize}"].each do |p|
  #     get p, controller: "static", action: p
  #   end
  # end


  resources :eventos
  resources :pesquisas
  resources :pessoas
  get 'validar_usuario/index'
  post 'validar_usuario/salvar_usuario'
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :usuarios ,:controllers => { :sessions => "sessions"}
  resources :noticias do
    get "delete"
  end
  resources :alunos
  resources :turmas
  resources :cursos
  resources :niveis

  #este aqui libera o 'páginas', mas a rota fica com '/paginas/' na frente
  #resources :paginas#, only: [:index, :edit, :new, :show]
  #este aqui fecha a liberação de 'páginas' com a rota fica com '/paginas/' na frente



  resources :paginas#, except: :show do
  #get':id', to: 'paginas#show', as: :pagina




  #este aqui libera o permalink - começo
  ##  scope ":permalink" do
  ##    get':id', to: 'paginas#show', as: :permalink
  ##  end
  #este aqui libera o permalink - fim


  root :to => "home#principal"


end
