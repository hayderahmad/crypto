class CreateNotificationSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_settings do |t|
      t.json :setting_config
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
