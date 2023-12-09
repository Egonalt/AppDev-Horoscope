class CreateUserStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :user_stocks do |t|
      t.references :user, null: false, foreign_key: true
      t.text :stock_tickers

      t.timestamps
    end
  end
end
