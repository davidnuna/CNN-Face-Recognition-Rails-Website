class CreateQuizzes < ActiveRecord::Migration[6.1]
  def change
    create_table :quizzes do |t|
      t.integer :user_id
      t.string :name
      t.integer :difficulty, default: 0
      
      t.timestamps
    end
  end
end
