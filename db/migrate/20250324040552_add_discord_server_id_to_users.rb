class AddDiscordServerIdToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :discord_server_id, :string
  end
end
