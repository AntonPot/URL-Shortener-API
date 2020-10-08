class CreateIpCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :ip_countries do |t|
      t.string :country_code
      t.string :country_name
      t.string :country_emoji

      t.timestamps
    end
  end
end
