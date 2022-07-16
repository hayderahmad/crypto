class CreateNotificationSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_settings do |t|
      t.string :setting_config_type
      t.json :setting_config_params
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
