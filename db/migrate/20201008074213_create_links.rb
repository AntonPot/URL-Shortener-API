class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :url, null: false
      t.string :slug, null: false

      t.timestamps
    end

    add_index :links, :slug, unique: true
  end
end
