Rails.application.routes.draw do
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    resources :invoices, :except => [:new] do
      post 'new', on: :collection, as: 'new'
    end
    resources :purchase_orders do
      member do
        post 'sending'
      end
    end
    resources :provider_articles, only: [:index, :show, :edit, :destroy]
    resources :bodegas
    resources :articulos
    resources :providers do
      member do
        get "select_add_multiple_articles"
        post "input_add_multiple_articles"
        post "create_multiple_articles"

        get "select_remove_multiple_articles"
        post "remove_multiple_articles"
      end

    end
    devise_for :users, controllers: { sessions: "users/sessions", :registrations => "users/registrations"}

    get 'welcome/index'

    get 'welcome/show'

    root 'welcome#index'

  end
  match '*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }, via: :all
  match '', to: redirect("/#{I18n.default_locale}"), via: :all


end
