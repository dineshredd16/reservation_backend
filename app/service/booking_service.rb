class BookingService

  def self.list(params)
    bookings = Booking.where(created_at: Date.current.all_day).is_active
    return bookings
  end

  def self.create(params)
    company_service = CompanyService.find_by(company_id: params[:company_id], id: [params[:company_service_id]])
    if company_service.present?
        new_params = params.as_json(only: [:company_id, :company_service_id, :booking_date])
        booking = Booking.new(new_params)
        booking.is_active = true
        if booking.save
            return true, booking
        else
            return false, booking.errors.full_messages.join(', ')
        end
    else
        return false,  "no service available for booking with company id : #{params[:company_id]} and company service id : #{params[:company_service_id]}"
    end
  end

  def self.update(params)
    new_params = params.as_json(only: [:booking_date, :is_active])
    booking = Booking.find_by(id: params[:booking_id])
    if booking.present?
        if booking.update(new_params)
            return true, booking
        else
            return false, booking.errors.full_messages.join(', ')
        end
    else
        return false, "booking not found with id #{params[:booking_id]}"
    end
  end

  def self.list_available_slots(params)
    data = []
    service = CompanyService.find_by(id: params[:company_service_id])
    company = Company.find_by(id: params[:company_id])
    if service.present? and company.present?
        time = Time.now.in_time_zone("Asia/Kolkata")
        if time.strftime("%M").to_i <= 30
            time = time.beginning_of_hour + 30.minutes
        else
            time = time.beginning_of_hour + 1.hour
        end
        if company.working_days.include? (time.wday)
            while (time < (Time.now.in_time_zone("Asia/Kolkata").end_of_day))
                if Booking.servicable_slot(time, service.id)
                    data << time.strftime("%d-%m-%Y %H:%M")
                end
                time = time + 30.minutes
            end
        end
        return true, data
    else
        return false, "company or service not found"
    end     
  end

end