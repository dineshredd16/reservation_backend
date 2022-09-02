class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :company
      t.references :company_service
      t.datetime :booking_date, index: true
      t.boolean :is_active, index: true
      t.timestamps
    end
  end
end
