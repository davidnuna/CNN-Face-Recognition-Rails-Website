class CreateLoginAttempts < ActiveRecord::Migration[6.1]
  def change
    create_table :login_attempts do |t|
      t.integer :user_id
      t.integer :status, default: 0
      
      t.timestamps
    end
  end
end
