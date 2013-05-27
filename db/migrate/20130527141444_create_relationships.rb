class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    #Ch 11 http://ruby.railstutorial.org/chapters/following-users#code-relationships_migration
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    add_index :relationships, [:follower_id, :followed_id], unique: true
    # Listing 11.1 also includes a composite index that enforces uniqueness of pairs of (follower_id, followed_id), so that a user can’t follow another user more than once:
  end
end
