class Booking < ApplicationRecord

    include Filterable

    has_many :companies
    has_many :company_services

    validate :validate_booking_date
    validate :validate_slots_availabilty


    scope :is_active, -> {where(is_active: true)}
    scope :by_company, -> (code) {joins("Inner Join companies on companies.id = bookings.company_id").where(companies: {code: code})}
    scope :by_company_service, -> (service_code) {joins("Inner Join company_services as cs on cs.id = bookings.company_service_id").where(company_services: {service_code: service_code})}

    def validate_booking_date
        date = self.booking_date.in_time_zone("Asia/Kolkata")
        if !(date.strftime("%d-%m-%Y") == DateTime.now.in_time_zone("Asia/Kolkata").strftime("%d-%m-%Y") and (["00", "30"].include? date.strftime("%M")))
            errors.add(:base, "can only book services at round figure values only 00 min,  60min, 30min")
        end
        if (DateTime.now.in_time_zone("Asia/Kolkata").strftime("%d-%m-%Y %H-%M") > date.strftime("%d-%m-%Y %H-%M"))
            errors.add(:base, "booking can either be created or updated only for bookings after #{DateTime.now.in_time_zone("Asia/Kolkata").strftime("%d-%m-%Y %H:%M")}")
        end
    end


    def validate_slots_availabilty
        if self.is_active == true
            booking_possible = Booking.servicable_slot(self.booking_date, self.company_service_id)
            if !booking_possible
                errors.add(:base, "no slots available for the opted company service")
            end
        end
    end

    def self.servicable_slot(datetime, company_service_id)
        count = 1
        company_service = CompanyService.find_by(id: company_service_id)
        company = Company.find_by(id: company_service.company_id)
        if (company.end_time.strftime("%H:%M") > (datetime + company_service.time_taken.minutes).strftime("%H:%M")) and (company.start_time.strftime("%H-%M") <= datetime.strftime("%H-%M"))
            bookings = Booking.joins("Inner Join company_services as cs on cs.id = bookings.company_service_id").where(booking_date: (Time.now - company_service.time_taken.minutes)..datetime, company_service_id: company_service_id, is_active: true).select("bookings.booking_date as booking_datetime, cs.time_taken as time_taken")
            bookings.each do |booking|
                end_time = (booking.booking_datetime + booking.time_taken.minutes)
                if end_time > datetime
                    count += 1
                end
            end
            if company_service.slots >= count
                return true
            else
                return false
            end
        else
            return false
        end
        
    end

end