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
    check_in_date = @reservation.check_in
    check_out_date = @reservation.check_out

    # 宿泊日数を計算
    number_of_nights = (check_out_date - check_in_date).to_i

    # 合計金額を計算（@roomの価格 * 宿泊日数 * 予約された人数）
    @total_price = @room.price * number_of_nights * @reservation.number_of_people

    unless @reservation.valid?
      render 'rooms/show' and return
    end

  end

  def create
    @reservation = current_user.reservations.build(reservation_params.merge(room_id: @room.id))

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
    params.require(:reservation).permit(:check_in, :check_out, :number_of_people, :room_id)
  end

  def set_reservation
    @reservation = current_user.reservations.find(params[:id])
  end
end
