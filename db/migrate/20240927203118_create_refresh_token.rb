class CreateRefreshToken < ActiveRecord::Migration[7.1]
  def change
    create_table :refresh_tokens do |t|
      t.string :refresh_token

      t.timestamps
    end
  end
end
