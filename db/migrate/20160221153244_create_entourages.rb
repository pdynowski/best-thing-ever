class CreateEntourages < ActiveRecord::Migration
  def change
    create_table :entourages do |t|
      t.references :user, null: false
      t.references :group, null: false
      t.timestamps null: false
    end

    add_index :entourages, :user_id
    add_index :entourages, :group_id
  end
end
