class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in, :check_out, :number_of_people, presence: true
  validate :check_out_after_check_in
  validates :number_of_people, numericality: { greater_than_or_equal_to: 1 }

  private
  def check_out_after_check_in
    return if check_out.blank? || check_in.blank?

    if check_out <= check_in
      errors.add(:check_out, 'はチェックイン日より後でなければなりません')
    end
  end

  # 宿泊費の合計を計算するメソッド
  def total_price
    number_of_nights = (check_out - check_in).to_i
    total_price = number_of_nights * room.price * number_of_people
    total_price
  end
end
