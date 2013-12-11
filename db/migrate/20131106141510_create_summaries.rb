class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
      t.integer :user_id
      t.text :body
      t.timestamp :publish_at
      t.boolean :enable_flag, :default => false
      t.string :temporary_code
      t.timestamps
    end
  end
end
