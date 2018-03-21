class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.integer :daily_score, null: false, default: 0
      t.integer :daily_score_count, null: false, default: 0

      t.timestamps
    end
  end
end
