class AddDiscordChannelIdToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :discord_channel_id, :string
  end
end
