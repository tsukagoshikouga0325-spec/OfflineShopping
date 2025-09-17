class RemoveTextFromTweets < ActiveRecord::Migration[7.1]
  def change
    remove_column :tweets, :text, :string
  end
end
