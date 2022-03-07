class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @events = policy_scope(Event).order(created_at: :desc)

    if params.dig(:search, :address).present?
      @events = @events.near(params.dig(:search, :address), params.dig(:search, :distance) || 30)
    end

    if params.dig(:search, :cause)&.reject(&:empty?)&.any?
      @events = @events.where(cause: params.dig(:search, :cause).reject(&:empty?))
    end

    if params.dig(:search, :dates).present?
      dates = params.dig(:search, :dates).split('to')
      start_date = dates.first
      end_date = dates.last
    end

    if start_date
      @events = @events.where("start_date >= ?", DateTime.parse(start_date))
    end

    if end_date
      @events = @events.where("end_date <= ?", DateTime.parse(end_date))
    end

    update_status

    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window: render_to_string(partial: "info_window", locals: { event: event }),
        image_url: helpers.asset_url("marker-contribute.png")
      }
    end
  end

  def show
    @event = Event.find(params[:id])
    @chatroom = Chatroom.find_or_create_by(asso: @event.asso, user: current_user)
    @participation = Participation.new
    @participation.event = @event
    @asso = @event.asso
    @potential_volunteers = @event.preferences
    authorize @event
    authorize @participation
  end

  def new
    @event = Event.new
    @asso = Asso.find(params[:asso_id])
    @event.asso = @asso

    authorize @event
  end

  def create
    @event = Event.new(params_event)
    @asso = Asso.find(params[:asso_id])
    @event.asso = @asso
    @event.number_hours = sum_hours(@event)
    @potential_volunteers = @event.preferences
    authorize @event
    @event.save ? (redirect_to root_path) : (render :new)
  end

  private

  def update_status
    @events.each do |event|
      event.done! if event.end_date < DateTime.now
    end
  end

  def params_event
    params.require(:event).permit(:name, :description, :cause, :status, :start_date, :end_date, :address, :number_volunteers, photos:[])
  end

  def sum_hours(event)
    ((event.end_date.to_time - event.start_date.to_time) / 1.hours).round
  end

end
