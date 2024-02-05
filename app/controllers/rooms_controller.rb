class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :own, :show]

  def index
    if params[:prefecture].present?
      @rooms = Room.where(prefecture: Room.prefectures[params[:prefecture]])
    else
      @rooms = Room.all
    end
  end

  def own
    @rooms = current_user.rooms
  end

  def show
    @room = Room.find(params[:id])
    @reservation = @room.reservations.build
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.new(room_params)
    if @room.save
      flash[:notice] = "施設の登録しました"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def room_params
    params.require(:room).permit(:name, :description, :price, :prefecture, :address, :image)
  end
end
