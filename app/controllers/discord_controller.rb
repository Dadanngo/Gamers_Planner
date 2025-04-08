class DiscordController < ApplicationController
  before_action :require_login

  def callback
    redirect_uri = if Rails.env.production?
      "https://gamers-planner.onrender.com/discord/callback"
    else
      "http://localhost:3000/discord/callback"
    end

    # アクセストークンを取得
    token_response = RestClient.post("https://discord.com/api/oauth2/token", {
      client_id: ENV['DISCORD_CLIENT_ID'],
      client_secret: ENV['DISCORD_CLIENT_SECRET'],
      grant_type: 'authorization_code',
      code: params[:code],
      redirect_uri: redirect_uri,
      scope: 'identify'
    }, {
      'Content-Type': 'application/x-www-form-urlencoded'
    })

    token_data = JSON.parse(token_response.body)

    # Discordユーザー情報取得
    user_info = RestClient.get("https://discord.com/api/users/@me", {
      Authorization: "Bearer #{token_data['access_token']}"
    })
    discord_user = JSON.parse(user_info.body)

    # Bot起動して所属サーバーIDを取得
    bot = Discordrb::Bot.new(token: ENV['DISCORD_BOT_TOKEN'])

    bot.ready do
      joined_server = bot.servers.values.last

      if joined_server
        current_user.update!(
          discord_server_id: joined_server.id,
          discord_user_id: discord_user['id']
        )
        flash[:notice] = "Discord連携が完了しました！"
      else
        flash[:alert] = "Botがサーバーに参加していません。"
      end

      bot.stop
    end

    bot.run
    redirect_to root_path
  end
end
