class AddStatusToEventUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :event_users, :status, :boolean, default: false
  end
end
