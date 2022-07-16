class AddDeliveryMethodToNotificationSettings < ActiveRecord::Migration[7.0]
  def change
    add_column :notification_settings, :by_email, :boolean, default: false
    add_column :notification_settings, :by_phone, :boolean, default: false
  end
end
