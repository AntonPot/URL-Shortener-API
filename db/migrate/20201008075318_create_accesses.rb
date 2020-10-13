class CreateAccesses < ActiveRecord::Migration[6.0]
  def change
    create_table :accesses do |t|
      # Postgres has a IP type, which should be used here
      t.string :address, null: false
      t.references :link, null: false, foreign_key: true
      t.references :ip_country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
