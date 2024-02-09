class ReservationsController < ApplicationController
  before_action :set_room, only: [:new, :confirm, :create]
  before_action :authenticate_user!
  before_action :set_reservation, only: [:destroy]

  def user_reservations
    @reservations = current_user.reservations.includes(:room)
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = @room.reservations.build
  end

  def confirm
    @reservation = @room.reservations.new(reservation_params)
    @reservation.user = current_user

    # 宿泊日数と合計金額の計算
    if @reservation.valid?
      number_of_nights = (@reservation.check_out - @reservation.check_in).to_i
      @total_price = @room.price * number_of_nights * @reservation.number_of_people
    else
      render 'rooms/show' and return
    end
  end



  def create
    @reservation = current_user.reservations.build(reservation_params.merge(room_id: @room.id))

    # 宿泊日数と合計金額の再計算
    if @reservation.check_in && @reservation.check_out
      number_of_nights = (@reservation.check_out - @reservation.check_in).to_i
      @reservation.total_price = @room.price * number_of_nights * @reservation.number_of_people
    end

    if @reservation.save
      redirect_to room_path(@room), notice: '予約が完了しました。'
    else
      flash.now[:alert] = '予約に失敗しました。'
      render 'rooms/show', status: :unprocessable_entity
    end
  end


  def edit
  end

  def update
  end

  def destroy
    @reservation.destroy
    redirect_to user_reservations_path, notice: '予約が削除されました。'
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :number_of_people, :room_id, :total_price)
  end

  def set_reservation
    @reservation = current_user.reservations.find(params[:id])
  end
end
