class PodcastsController < ApplicationController
  require 'i18n_data'
  before_action :authenticate_spotify

  def search
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
    @feedback = Feedback.new
    @feedbacks = Feedback.where(podcast_id: params[:id])  # To display all feedbacks
  end

  def favorite
    @episode = RSpotify::Episode.find(params[:episode_id])  
    current_user.episodes.create(spotify_id: @episode.id, name: @episode.name, show: @episode.show.name)
    redirect_to podcasts_path, notice: 'Episode added to favorites!'
  end
  
  def unfavorite
    @episode = RSpotify::Episode.find(params[:id])
    episode = current_user.episodes.find_by(spotify_id: @episode.id)
    episode.destroy if episode
    redirect_to podcasts_path, notice: 'Episode removed from favorites!'
  end

  def played
    @episode = RSpotify::Episode.find(params[:id])
    episode_favorite = current_user.episodes.find_by(spotify_id: @episode.id)
    episode_favorite.update(played: true) if episode_favorite
    redirect_back(fallback_location: podcast_path(@episode), notice: 'Episode marked as played!')
  end
  
  def unplayed
    @episode = RSpotify::Episode.find(params[:id])
    episode_favorite = current_user.episodes.find_by(spotify_id: @episode.id)
    episode_favorite.update(played: false) if episode_favorite
    redirect_back(fallback_location: podcast_path(@episode), notice: 'Episode marked as unplayed!')
  end

  def finished
    @episode = RSpotify::Episode.find(params[:id])
    episode_favorite = current_user.episodes.find_by(spotify_id: @episode.id)
    episode_favorite.update(finished: true) if episode_favorite
    redirect_back(fallback_location: podcast_path(@episode), notice: 'Episode marked as finished!')
   end
   
   def unfinished
    @episode = RSpotify::Episode.find(params[:id]) 
    episode_favorite = current_user.episodes.find_by(spotify_id: @episode.id)
    episode_favorite.update(finished: false) if episode_favorite
    redirect_back(fallback_location: podcast_path(@episode), notice: 'Episode marked as unfinished!')
   end

  private

  def authenticate_spotify
    RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'])
  end
end

