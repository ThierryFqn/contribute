class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @events = policy_scope(Event).order(created_at: :desc)
    @events = policy_scope(Event).order(created_at: :desc)

    if params[:search].present?
      if search_params[:start_date, :end_date].reject(&:empty?).present? && search_params[:address].present?
        @events = policy_scope(Event).order(created_at: :desc)
                                         .where(personality: search_params[:start_date, :end_date].reject(&:empty?))
                                         .and(policy_scope(Event).where("address ILIKE ?", "%#{search_params[:address]}%"))

      elsif search_params[:start_date, :end_date].reject(&:empty?).present? && !search_params[:address].present?
        @events = policy_scope(Event).order(created_at: :desc)
                                         .where(personality: search_params[:start_date, :end_date].reject(&:empty?))

      elsif !search_params[:start_date, :end_date].reject(&:empty?).present? && search_params[:address].present?
        @events = policy_scope(Event).order(created_at: :desc)
                                         .where("address ILIKE ?", "%#{search_params[:address]}%")
      end

    else
      @events = policy_scope(Event).order(created_at: :desc)
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

  def search_params
    params.require(:search).permit(:address, :start_date, :end_date)
  end

end
