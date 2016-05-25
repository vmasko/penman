class AddScheduleToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :schedule, :timestamp
  end
end
