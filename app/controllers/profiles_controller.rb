class ProfilesController < ApplicationController
  def show
    authorize(:profile, :show?)
    @participations = current_user.participations
    @events = @participations.map(&:event)
  end

end
