class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :mobile_number
      t.string :email
      t.boolean :is_active, index: true
      t.timestamps
    end
  end
end
