class PodcastsController < ApplicationController
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

  private

  def authenticate_spotify
    RSpotify.authenticate("2f8aa0ea29914151ab35bb287be9749c", "ec3bea7b485b4a11bfe097b71b82fa37")
  end
end

