Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users

  # Set the homepage as the root path
  root to: "pages#home"

  # Define a resourceful route for the pages controller with only the profile action
  resources :pages, only: [:profile] do
    # Additional custom actions for the pages controller that don't require a specific ID
    collection do
      # Route for the coach to prepare for an upcoming game
      get :prepare_game

      # Route for the coach to select players for an upcoming game
      post :select_players

      # Route for displaying the "GAME TIME" message and redirecting to the game play page
      get :game_in_progress

      # Route for displaying the game play interface
      get :game_play
    end
  end
end


# VERB /path, to: 'controller#action', as: :prefix
