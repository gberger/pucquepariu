class CreateChatMessages < ActiveRecord::Migration
  def change
    create_table :chat_messages do |t|
      t.integer :course_id
      t.integer :user_id
      t.text :text

      t.timestamps
    end
  end
end
