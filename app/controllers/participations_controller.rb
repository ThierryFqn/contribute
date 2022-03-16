class ParticipationsController < ApplicationController
  def create
    @participation = Participation.new
    @event = Event.find(params[:event_id])
    @participation.event = @event
    @participation.user = current_user
    authorize @participation
    @participation.save ? () : (render :new)
  end

  def accepted
    @participation = Participation.find(params[:id])
    @participation.accepted!
    authorize @participation
    UserMailer.send_confirmation(@participation.user).deliver_now
    render json: json_response
  end

  def denied
    @participation = Participation.find(params[:id])
    @participation.denied!
    authorize @participation
  end

  def cancelled
    @participation = Participation.find(params[:id])
    @participation.cancelled!
    authorize @participation
  end

  private

  def json_response
    {
      html: render_to_string(partial: 'shared/participation_card.html', locals: { participant: @participation }),
      participation_id: @participation.id,
      pending_count: @participation.event.pending_participants.count,
      accepted_count: @participation.event.accepted_participants.count
    }
  end
end
