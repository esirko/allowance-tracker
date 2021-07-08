class AddDecrementToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :withholdIncrementToday, :boolean
  end
end
