class AssosController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]
  def show
    @asso = Asso.find(params[:id])
    @user = @asso.user
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

  private

  def asso_params
    params.require(:asso).permit(:name, :description)
  end
end
