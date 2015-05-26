Rails.application.routes.draw do

  resources :noticias do
    #put "atualizar_status/:noticia_id/:status"=>'noticias#atualizar_status', as: :atualizar_status
    #put "publicar_noticia/:noticia_id/:publicado"=>'noticias#publicar_noticia', as: :publicar_noticia
    put "alterar_status/:noticia_id/:status"=>'noticias#alterar_status', as: :alterar_status
  end

  #teste do controller static
  scope "/gte" do
    %w[gte pesquisadores projetos].each do |p|
      get p, controller: "static", action: p
    end
  end

  #get gte, controller: "static", action: gte
  #teste do controller static

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



  # scope "" do
  #   resources :paginas
  #   %w["#{id}-#{permalink.to_s.parameterize}"].each do |p|
  #     get p, controller: "static", action: p
  #   end
  # end

  resources :validacao
  resources :eventos
  resources :pesquisas
  resources :pessoas
  get 'validar_usuario/index'

  # atualização de pessoa e aluno
  # post 'validar_usuario/salvar_usuario'
  # get 'validar_usuario/atualizar_pessoa'
  # post 'validar_usuario/salvar_pessoa'
  # get 'validar_usuario/atualizar_aluno'
  # post 'validar_usuario/salvar_aluno'


  mount Ckeditor::Engine => '/ckeditor'
  devise_for :usuarios ,:controllers => { :sessions => "sessions"}
  resources :noticias do
    get "delete"
  end
  resources :alunos   do
    #post 'turmas', on: :collection
    post 'turnos', on: :collection
  end
  resources :turmas do
    post 'cursos', on: :collection
  end
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
