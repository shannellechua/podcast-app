class PodcastsController < ApplicationController
  def search
    RSpotify.authenticate("2f8aa0ea29914151ab35bb287be9749c", "ec3bea7b485b4a11bfe097b71b82fa37")

    if params[:search].present?
      @podcast = RSpotify::Episode.search(params[:search])

      respond_to do |format|
      format.html 
      format.json { render json: @podcast } 
      end
    end
  end

  def show
    @episode = RSpotify::Episode.find(params[:id])
  end

  def favorite
    @episode = RSpotify::Episode.find(params[:episode_id])  # Changed from params[:id]
    current_user.dummies.create(spotify_id: @episode.id)
    redirect_to podcasts_path, notice: 'Episode added to favorites!'
  end
end
