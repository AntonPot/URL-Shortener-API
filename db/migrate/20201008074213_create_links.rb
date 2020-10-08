class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :url, null: false
      t.string :slug, null: false, index: true

      t.timestamps
    end
  end
end
