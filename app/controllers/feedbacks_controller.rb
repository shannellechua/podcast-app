class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:edit, :update, :destroy]
  before_action :set_episode, only: [:create, :edit, :update]
  
  def create
    @feedback = Feedback.new(feedback_params.merge(podcast_id: params[:podcast_id]))
    
    if @feedback.save
      redirect_to podcast_path(@feedback.podcast_id), notice: 'Feedback submitted successfully!'
    else
      @feedbacks = Feedback.where(podcast_id: params[:podcast_id])
      render 'podcasts/show', status: :unprocessable_entity
    end
  end

  def edit
    @feedbacks = Feedback.where(podcast_id: @feedback.podcast_id)
  end

  def update
    if @feedback.update(feedback_params)
      redirect_to podcast_path(@feedback.podcast_id), notice: 'Feedback was successfully updated.'
    else
      @feedbacks = Feedback.where(podcast_id: @feedback.podcast_id)
      render :edit, status: :unprocessable_entity
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

  def set_episode
    podcast_id = params[:podcast_id] || @feedback&.podcast_id
    if podcast_id.present?
      @episode = RSpotify::Episode.find(podcast_id)
    else
      redirect_to podcasts_path, alert: 'Podcast ID is missing or invalid.'
    end
  rescue RestClient::NotFound
    redirect_to podcasts_path, alert: 'Episode not found.'
  end

  def feedback_params
    # Remove the merge since we're handling podcast_id separately
    params.require(:feedback).permit(:rating, :comment, :podcast_id)
  end
end