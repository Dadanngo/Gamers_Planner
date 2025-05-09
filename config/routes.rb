Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  root 'top#index'
  resources :users, only: [ :show, :create, :new ] do
    collection do
      get :activate
    end
  end
  resource :login, only: %i[ new create ]
  resource :logout, only: %i[ show ]
  resources :password_resets, only: %i[new create edit update]
  resources :notifications, only: [ :create ]
  resources :profiles, only: [ :show ]
  resources :events do
    resources :schedule_inputs, only: [ :create, :new, :index ]
    member do
      get "recreate", to: "events#recreate"
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'manual/show', to: 'manual#show', as: 'manual_show'
  get 'kiyaku/term', to: 'kiyaku#term', as: 'kiyaku_term'
  get '/events/url/:url/schedule_inputs', to: 'schedule_inputs#index', as: 'event_schedule_inputs_by_url'
  get '/events/url/:url/schedule_inputs/:token/edit', to: 'schedule_inputs#edit', as: 'edit_event_schedule_input_by_url'
  patch '/events/url/:url/schedule_inputs/:token', to: 'schedule_inputs#update', as: 'update_event_schedule_input_by_url'
  delete '/events/url/:url/schedule_inputs/:token', to: 'schedule_inputs#destroy', as: 'delete_event_schedule_input_by_url'
  patch '/events/url/:url/update_lobby_id', to: 'events#update_lobby_id', as: 'update_lobby_id_event_by_url'
  get '/events/url/:url', to: 'events#show', as: 'event_by_url'
  get '/discord/callback', to: 'discord#callback'
  get '/auth/:provider/callback', to: 'oauths#callback'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
