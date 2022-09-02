class Booking < ApplicationRecord

    has_many :companies
    has_many :bookings
end
