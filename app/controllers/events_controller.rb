class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @events = policy_scope(Event).order(created_at: :desc)

    if params.dig(:search, :address).present?
      @events = @events.near(params.dig(:search, :address), params.dig(:search, :distance) || 30)
    end

    # if params.dig(:search, :cause).present?
    #   @events = @events.where(cause: params.dig(:search, :cause).reject(&:empty?))
    # end

    if params.dig(:search, :start_date).present?
      @events = @events.where("start_date >= ?", DateTime.parse(params.dig(:search, :start_date)))
    end

    if params.dig(:search, :end_date).present?
      @events = @events.where("end_date >= ?", DateTime.parse(params.dig(:search, :start_date)))
    end


    # if params.dig(:search, :address).present? && params.dig(:search, :cause).present?
    #   @events = @events.near(params.dig(:search, :address), params.dig(:search, :distance) || 30) && policy_scope(Event).order(created_at: :desc).where(cause: params.dig(:search, :cause).reject(&:empty?))
    # end

    # if params.dig(:search, :address).present? && params.dig(:search, :cause).present? && params.dig(:search, :start_date).present?
    #   @events = @events.near(params.dig(:search, :address), params.dig(:search, :distance) || 30) && policy_scope(Event).order(created_at: :desc).where(cause: params.dig(:search, :cause).reject(&:empty?)) && policy_scope(Event).order(created_at: :desc).where("created_at >= :start_date AND created_at <= :end_date", {start_date: params.dig(:search, :start_date), end_date: params.dig(:search, :end_date)})
    # end
      # if params[:search].present?
    #   if search_params[:personalities].reject(&:empty?).present? && search_params[:address].present?
    #     @pokemons = policy_scope(Pokemon).order(created_at: :desc)
    #                                      .where(personality: search_params[:personalities].reject(&:empty?))
    #                                      .and(policy_scope(Pokemon).where("address ILIKE ?", "%#{search_params[:address]}%"))

    #   elsif search_params[:personalities].reject(&:empty?).present? && !search_params[:address].present?
    #     @pokemons = policy_scope(Pokemon).order(created_at: :desc)
    #                                      .where(personality: search_params[:personalities].reject(&:empty?))

    #   elsif !search_params[:personalities].reject(&:empty?).present? && search_params[:address].present?
    #     @pokemons = policy_scope(Pokemon).order(created_at: :desc)
    #                                      .where("address ILIKE ?", "%#{search_params[:address]}%")
    #   end

    # else
    #   @pokemons = policy_scope(Pokemon).order(created_at: :desc)
    # end

    # if params.dig(:search, :end_date).present?
    #   @events = policy_scope(Event).order(created_at: :desc)
    #                                 .where("created_at >= :end_date AND created_at <= :end_date", { start_date: params[:end_date], end_date: params[:end_date] } )
    # end
    # if params.dig(:search, :address).present?
    update_status(@events)

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
    @event.asso = @asso

    authorize @event
  end

  def create
    @event = Event.new(params_event)
    @asso = Asso.find(params[:asso_id])
    @event.asso = @asso
    @event.number_hours = sum_hours(@event)
    authorize @event
    @event.save ? (redirect_to root_path) : (render :new)
  end

  private

  def update_status(events)
    events.each do |event|
      event.done! if event.end_date < DateTime.now
    end
  end

  def params_event
    params.require(:event).permit(:name, :description, :cause, :status, :start_date, :end_date, :address, :number_volunteers)
  end

  def sum_hours(event)
    ((event.end_date.to_time - event.start_date.to_time) / 1.hours).round
  end
end
