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
    RSpotify.authenticate("2f8aa0ea29914151ab35bb287be9749c", "ec3bea7b485b4a11bfe097b71b82fa37")


      @episode = RSpotify::Episode.find(params[:id])
  end
end
