class AddResetPasswordEmailSentAtToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :reset_password_email_sent_at, :datetime
  end
end
