class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
  end

  def show
  end

  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.create(params_event)
    @event.user = current_user
    authorize @event
    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  private

  def params_event
    params.require(:event).permit(:name, :description, :cause, :status, :start_date, :end_date, :address, :latitude,
                                  :longitude, :number_volunteers, :asso_id)
  end
end
