# User モデルのサンプルデータ
10.times do |i|
  User.create!(
    email: "user#{i+1}@example.com",
    password: 'password',
    password_confirmation: 'password',
    name: "ユーザー#{i+1}",
    introduction: "こんにちは、ユーザー#{i+1}です。",
    # profile_imageは、ProfileImageUploaderを使用してアップロードする必要があります
  )
end

# Room モデルのサンプルデータ
User.limit(10).each_with_index do |user, i|
  Room.create!(
    name: "部屋#{i+1}",
    description: "快適な部屋です。",
    price: 5000 * (i + 1),
    address: "住所#{i+1}",
    user_id: user.id,
    prefecture: Room.prefectures.keys[i % Room.prefectures.keys.size],
    # imageは、ImageUploaderを使用してアップロードする必要があります
  )
end

# Reservation モデルのサンプルデータ
Room.limit(10).each_with_index do |room, i|
  Reservation.create!(
    check_in: Date.today + i.days,
    check_out: Date.today + (i + 1).days,
    number_of_people: 2,
    user_id: room.user_id,
    room_id: room.id,
    total_price: room.price * 2 # 仮の計算例
  )
end
