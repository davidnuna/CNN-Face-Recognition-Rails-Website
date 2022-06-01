class CreateUserAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :user_answers do |t|
      t.integer :user_id
      t.integer :question_id
      t.integer :result_id
      t.string :given_answer

      t.index :user_id
      t.index :question_id
      t.index :result_id
      t.index [:user_id, :question_id, :result_id], unique: true

      t.timestamps
    end
  end
end
