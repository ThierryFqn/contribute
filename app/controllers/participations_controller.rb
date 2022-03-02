class ParticipationsController < ApplicationController
  def create
    @participation = Participation.new
    @event = Event.find(params[:event_id])
    @participation.event = @event
    @participation.user = current_user
    authorize @participation
    @participation.save ? (redirect_to profiles_path) : (render :new)
  end

  def accepted
    @participation = Participation.find(params[:id])
    @participation.accepted!
  end

  def denied
    @participation = Participation.find(params[:id])
    @participation.denied!
  end
end
