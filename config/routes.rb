Rails.application.routes.draw do
# Devise routes for user authentication
devise_for :users

# Set the homepage as the root path
root to: "pages#home"

# Define a route for displaying the coach's profile and dashboard (Same page)
get :profile, to: 'pages#profile', as: :coach_dashboard

# Define a route for the coach to prepare for an upcoming game
get :prepare_game, to: 'games#prepare_game', as: :prepare_game

# Define a route for the coach to select players for an upcoming game
post :select_players, to: 'games#select_players', as: :select_players

# Define a route for displaying the "GAME TIME" message and redirecting to the game play page
get :game_in_progress, to: 'games#in_progress', as: :game_in_progress

# Define a route for displaying the game play interface
get :game_play, to: 'games#play', as: :game_play
end

# VERB /path, to: 'controller#action', as: :prefix
# END QT & SUB --> 2 pages en bas
