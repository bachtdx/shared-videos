class AddIsLoginedToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_logined, :boolean
  end
end
