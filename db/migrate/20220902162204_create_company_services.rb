class CreateCompanyServices < ActiveRecord::Migration[6.1]
  def change
    create_table :company_services do |t|
      t.string :name
      t.string :service_code, index: true
      t.references :companies
      t.integer :time_taken
      t.float :price
      t.integer :slots, index: true
      t.boolean :is_active, index: true
      t.timestamps
    end
  end
end
