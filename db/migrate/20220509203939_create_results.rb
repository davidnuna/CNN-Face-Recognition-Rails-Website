class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.integer :user_id
      t.integer :quiz_id
      t.integer :status, default: 0
      t.integer :score
      
      t.index :user_id
      t.index :quiz_id
      t.index [:user_id, :quiz_id], unique: true

      t.timestamps
    end
  end
end
