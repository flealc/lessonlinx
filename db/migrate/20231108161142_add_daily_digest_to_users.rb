class AddDailyDigestToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :daily_digest, :time
  end
end
