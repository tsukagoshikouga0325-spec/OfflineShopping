class AddRegionToTweets < ActiveRecord::Migration[7.1]
  def change
    add_column :tweets, :region, :string
  end
end
