class FixVoteCountOnStories < ActiveRecord::Migration
  def change
  	change_column :stories, :votes_count, :integer, default: 0
  	change_column :stories, :comments_count, :integer, default: 0

  end
end
