class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :contact
      t.text :address
      t.text :billing
      t.text :message
      t.boolean :filled, default: false
      t.integer :reward, default: 0

      t.references :user, null: false

      t.timestamps
    end
  end
end
