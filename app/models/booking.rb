class Booking < ApplicationRecord

    include Filterable

    has_many :companies
    has_many :bookings
end
