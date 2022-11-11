class CreateUserBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :user_bookings do |t|
      t.references :booking
      t.references :user
      t.integer :payment_reference_id
      t.boolean :payment_status
      t.boolean :is_active, index: true
      t.timestamps
    end
  end
end
