class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :slept_at, null: false
      t.datetime :woke_up_at

      t.timestamps
    end
  end
end
