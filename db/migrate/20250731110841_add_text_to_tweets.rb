class AddTextToTweets < ActiveRecord::Migration[7.1]
  def change
    add_column :tweets, :text, :string
  end
end
