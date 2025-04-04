require 'discordrb'
require_relative './config/environment'

bot = Discordrb::Bot.new(token: ENV['DISCORD_BOT_TOKEN'])

bot.ready do
  puts "✅ Discord Bot is ready!"
end

bot.message(start_with: '!set_channel') do |event|
  channel_id = event.channel.id.to_s
  server_id = event.server.id.to_s
  discord_user_id = event.user.id.to_s

  # discord_user_id でログイン済みユーザーを検索
  user = User.find_by(discord_user_id: discord_user_id)

  if user
    user.update(discord_channel_id: channel_id, discord_server_id: server_id)
    event.respond("📌 このチャンネルを通知先に設定しました！")
    puts "✅ ユーザー #{user.id} の通知チャンネルを更新: #{channel_id}"
  else
    event.respond("⚠️ 対応するユーザーが見つかりません。ログインまたは事前に連携してください。")
    puts "🚨 未登録ユーザー: Discord ID #{discord_user_id}"
  end
end

bot.run
