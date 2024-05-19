# 既存のユーザーを指定して紐付け
user = User.find_by(email: "ttorubou@gmail.com")


10.times do |n|
    latitude = Faker::Address.latitude.to_f
    longitude = Faker::Address.longitude.to_f
    user.post.create!(
        title: "Example Title #{n + 1}",
        address: "Example Address #{n + 1}",
        latitude: latitude,
        longitude: longitude,
    )
end