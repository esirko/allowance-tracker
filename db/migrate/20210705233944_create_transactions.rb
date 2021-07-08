class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.datetime :timestamp
      t.decimal :amount
      t.text :description

      t.timestamps
    end
  end
end
