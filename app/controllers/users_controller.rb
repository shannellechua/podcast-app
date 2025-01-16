class UsersController < ApplicationController
  def favorites
    @favorite_episodes = current_user.episodes
  end

  def subscriptions
    @subscriptions = current_user.subscriptions.includes(:user)  # Get all subscriptions for the current user
  end

  # def destroy
  #   subscription = current_user.subscriptions.find(params[:id])
  #   if subscription.destroy
  #     flash[:notice] = "Unsubscribed successfully from #{subscription.show_name}."
  #   else
  #     flash[:alert] = "Failed to unsubscribe."
  #   end
  #   redirect_back(fallback_location: subscriptions_path)
  # end
end 