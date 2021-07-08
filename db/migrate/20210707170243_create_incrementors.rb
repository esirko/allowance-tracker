class CreateIncrementors < ActiveRecord::Migration[6.1]
  def change
    create_table :incrementors do |t|
      t.date :effectivedate
      t.decimal :amountperday
      t.text :description
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
