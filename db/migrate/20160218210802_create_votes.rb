class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :winner_id, null: false
      t.integer :loser_id, null: false

      t.timestamps null: false
    end
  end
end
