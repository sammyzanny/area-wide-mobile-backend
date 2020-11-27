class CreateUsers < ActiveRecord::Migration[6.0]
    def change
      create_table :users do |t|
        t.string :email
        t.string :password_digest
        t.string :name
        t.string :phone
        t.string :officename
        t.string :address
        t.string :reset_password_token
        t.datetime :reset_password_sent_at
      
        t.timestamps
      end
    end
  end
  