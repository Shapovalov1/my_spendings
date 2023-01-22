class CreateSpendings < ActiveRecord::Migration[7.0]
  def change
    create_table :spendings do |t|
      t.string :description
      t.decimal :amount, precision: 8, scale: 2
      t.string :category

      t.references :user

      t.timestamps
    end
  end
end
