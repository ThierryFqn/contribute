class ChatroomsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    authorize @chatroom
  end

  def create
    @asso = Asso.find(params[:asso_id])
    @chatroom = Chatroom.find_by(user: current_user, asso: @asso)

    if @chatroom
      redirect_to chatroom_path(@chatroom)
    else
      @chatroom = Chatroom.create(user: current_user, asso: @asso)
      redirect_to chatroom_path(@chatroom)
    end

    skip_authorization
  end
end

# à la création d'une asso une chatroom est créée automatiquement
# la chatroom est réliée à l'asso
# les users trouvent sur la page de l'event un onglet qui leur permet d'ouvrir la chatroom
# afin de communiquer avec l'asso.
# les users peuvent communiquer avec l'asso afin de leur poser leur question
# lorsque l'asso repond le message s'affiche avec le nom de l'asso
# une chatbox unique est créée par user qui souhaite avoir des informations auprès de l'asso
# afin que la conversation reste privée.