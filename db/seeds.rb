require 'faker'
require 'open-uri'

# 既存のユーザーを指定して紐付け
user = User.find_by(email: 'ttorubou@gmail.com')
raise "User not found" unless user

# タグを取得または作成
tag = Tag.find_by(title: 'テストタグ') || Tag.create!(title: 'テストタグ')

# 投稿を作成
100.times do |i|
  file = URI.open('https://via.placeholder.com/150') # ダミー画像のURL
  tempfile = Tempfile.new(['dummy', '.jpg'])
  tempfile.binmode
  tempfile.write(file.read)
  tempfile.rewind

  begin
    Post.transaction do
      Post.create!(
        user: user,
        title: "テスト投稿 #{i + 1}",
        address: "石川県金沢市#{i + 1}丁目",
        report: "これはテスト投稿です。",
        image: tempfile,
        tags: [tag] # タグを含める
      )
    end
  rescue ActiveRecord::RecordInvalid => e
    puts "Failed to create post: #{e.record.errors.full_messages.join(", ")}"
  ensure
    tempfile.close
    tempfile.unlink
  end
end
