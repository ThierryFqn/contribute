class ParticipationsController < ApplicationController
  def create
    @participation = Participation.new
    @event = Event.find(params[:event_id])
    @participation.event = @event
    @participation.user = current_user
    authorize @participation
    authorize @event
    @participation.save ? (redirect_to profiles_path) : (render :new)
  end
end
#   def create
#     @participation = Participation.new(participation_params)

#     if @participation.save
#       redirect_to @participation, notice: 'votre participation a été enregistrée avec succès.'
#     else
#       render :new
#     end
#   end

#   private

#   def participation_params
#     params.require(:participation).permit(:status, :user_id, :event_id)
#   end
# end
