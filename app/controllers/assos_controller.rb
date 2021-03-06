class AssosController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]
  def show
    @asso = Asso.find(params[:id])
    @user = @asso.user
    @chatrooms = current_user.chatrooms
    authorize @asso
  end

  def new
    @asso = Asso.new
    authorize @asso
  end

  def create
    @asso = Asso.new(asso_params)
    @asso.user = current_user
    authorize @asso
    @asso.save ? (redirect_to asso_path(@asso)) : (render :new)
  end

  def dashboard
    @asso = Asso.find(params[:id])
    @events = @asso.events
    @pending_participations = @asso.participations.where(status: 0)
    @chatrooms = Chatroom.select { |chatroom| chatroom.asso_id = @asso.id }
    authorize @asso
    @pending_events = @events.select(&:coming?)
    @done_events = @events.select(&:done?)
  end

  def chatbox
    @asso = Asso.find(params[:id])
    @chatroom = @asso.chatroom
    authorize @asso
  end

  private

  def asso_params
    params.require(:asso).permit(:name, :description)
  end
end
