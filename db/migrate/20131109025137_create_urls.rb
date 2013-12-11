class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.text :url
      t.string :url_hash
      t.text :body

      t.timestamps
    end
  end
end
