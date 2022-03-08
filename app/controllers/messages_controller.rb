class MessagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]

  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    authorize @message
    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        json_response
      )
      head :ok
    else
      render "chatrooms/show"
    end
  end

  private

  def json_response
    {
      html: render_to_string(partial: "messages/message", locals: { message: @message }),
      user_id: current_user.id
    }
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
