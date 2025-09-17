class CreateTweets < ActiveRecord::Migration[7.1]
  def change
    create_table :tweets do |t|
      t.string :name
      t.integer :price
      t.text :about

      t.timestamps
    end
  end
end
