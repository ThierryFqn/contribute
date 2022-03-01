class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @events = policy_scope(Event).order(created_at: :desc)
    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window: render_to_string(partial: "info_window", locals: { event: event }),
        image_url: helpers.asset_url("mimi.jpeg")
      }
    end
  end

  def show
    @event = Event.find(params[:id])
    @participation = Participation.new
    @participation.event = @event
    authorize @event
    authorize @participation
  end

  def new
    @event = Event.new
    @asso = Asso.find(params[:asso_id])
    authorize @event
    authorize @asso
  end

  def create
    @event = Event.new(params_event)
    @asso = Asso.find(params[:asso_id])
    @event.asso = @asso
    authorize @event
    authorize @asso
    if @event.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def params_event
    params.require(:event).permit(:name, :description, :cause, :status, :start_date, :end_date, :address, :number_volunteers)
  end
end
