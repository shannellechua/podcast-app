class UsersController < ApplicationController
  def favorites
    @favorite_episodes = current_user.episodes
  end
end 