class ChatroomsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    authorize @chatroom
  end
end
