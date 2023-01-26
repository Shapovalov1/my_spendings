class CreateSpendingsUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :spendings_users do |t|
      t.bigint :origin_user_id
      t.references :spending
      t.bigint :shared_user_id

      t.timestamps
    end
  end
end
