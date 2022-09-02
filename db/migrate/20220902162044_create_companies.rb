class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :code, index: true 
      t.string :gstin 
      t.string :pan_no 
      t.string :address 
      t.integer :working_days, array: true, default: [] 
      t.time :start_time 
      t.time :end_time 
      t.boolean :is_active, index: true
      t.timestamps
    end
  end
end
