class AddDiscordUserIdToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :discord_user_id, :string
  end
end
