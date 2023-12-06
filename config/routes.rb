Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users

  # Log in + Sign up + Dashboard btn
  root to: "pages#home"
  get "dashboard", to: "pages#dashboard"
  get "calendar", to: "pages#calendar"

  get "fake_new", to: "pages#fake_new"

  resources :games, only: :show do
    member do
      get :play
      get :stats
    end
  end

  resources :players do
    member do
      get :player_data
      get :radar_player_data
    end
  end

  resources :coaches, only: %i[new edit update delete] do
    resources :participations, except: %i[index new]
    resources :teams, except: %i[show index]
  end

  resources :player_stats, except: %i[show index] do
    resources :game_stats, only: %i[show new create index]
  end

  resources :games, only: %i[show index] do
    resources :participations, only: %i[new]
    member do
      post 'set_titulaire', to: "participations#titularize"
      get :quarter_data
      get :total_quarter_data
    end
    member do
      post "set_participations", to: "games#set_participations"
    end
  end

end

  # Define a route for displaying the coach's profile and dashboard (Same page)
  # get :profile, to: 'pages#profile', as: :coach_dashboard

  # # Define a route for the coach to prepare for an upcoming game
  # get :prepare_game, to: 'games#prepare_game', as: :prepare_game

  # # Define a route for the coach to select players for an upcoming game
  # post :select_players, to: 'games#select_players', as: :select_players

  # Define a route for displaying the "GAME TIME" message and redirecting to the game play page
  # get :game_in_progress, to: 'games#in_progress', as: :game_in_progress

  # # Define a route for displaying the game play interface
  # get :game_play, to: 'games#play', as: :game_play
