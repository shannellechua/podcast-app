class PodcastsController < ApplicationController
  require 'i18n_data'
  
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
      @category = RSpotify::Category.find(params[:id])
      # @publisher = RSpotify::Show.find(params[:id])
  end

  # def episodes
  #   RSpotify.authenticate("2f8aa0ea29914151ab35bb287be9749c", "ec3bea7b485b4a11bfe097b71b82fa37")

  #   @episode = RSpotify::Episode.find(params[:id])
  #   @episodes = RSpotify::Episode.find(params[:id])
  # end

  # def category
  #   RSpotify.authenticate("2f8aa0ea29914151ab35bb287be9749c", "ec3bea7b485b4a11bfe097b71b82fa37")

  #   @episode = RSpotify::Category.find(params[:id])
  # end
end
