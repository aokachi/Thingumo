class ReCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, unique: true
      t.integer :sex
      t.date :birthday
      t.string :avatar
      t.text :self_introduction
      t.bigint :total_points
      t.string :encrypted_password, null: false
      t.string :reset_password_token, unique: true
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.timestamps
    end
  end
end
