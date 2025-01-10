class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:edit, :update, :destroy]
  
  def create
    @feedback = Feedback.new(feedback_params)
    
    if @feedback.save
      redirect_to podcast_path(@feedback.podcast_id), notice: 'Feedback submitted successfully!'
    else
      @episode = RSpotify::Episode.find(params[:podcast_id])
      render 'podcasts/show'
    end
  end


  def edit
    @episode = RSpotify::Episode.find(@feedback.podcast_id)
  end

  def update
    if @feedback.update(feedback_params)
      redirect_to podcast_path(@feedback.podcast_id), notice: 'Feedback was successfully updated.'
    else
      @episode = RSpotify::Episode.find(@feedback.podcast_id)
      render :edit
    end
  end

  def destroy
    podcast_id = @feedback.podcast_id
    @feedback.destroy
    redirect_to podcast_path(podcast_id), notice: 'Feedback was successfully deleted.'
  end

  private

  def set_feedback
    @feedback = Feedback.find(params[:id])
  end

  def feedback_params
    params.require(:feedback).permit(:rating, :comment).merge(podcast_id: params[:podcast_id])
  end
end