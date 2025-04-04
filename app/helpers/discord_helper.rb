module DiscordHelper
  def discord_invite_url
    client_id = ENV['DISCORD_CLIENT_ID']
    redirect_uri = CGI.escape(discord_callback_url)
    permissions = '8'
     scope = 'identify bot'

    "https://discord.com/api/oauth2/authorize?client_id=#{client_id}&permissions=#{permissions}&scope=#{scope}&redirect_uri=#{redirect_uri}&response_type=code"
  end
end
