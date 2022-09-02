module Api::V1

    class BookingController < ApplicationController

        def index_booking
            bookings = Booking.where(created_at: Date.current.all_day).is_active
            render json: {status: "success", data: bookings, errors: []},status: :ok
        end

        def create_booking
            company_service = CompanyService.find_by(company_id: params[:company_id], id: [params[:company_service_id]])
            if company_service.present?
                new_params = params.as_json(only: [:company_id, :company_service_id, :booking_date])
                booking = Booking.new(new_params)
                booking.is_active = true
                if booking.save
                    render json: {status: "success", data: booking, errors: []},status: :ok
                else
                    render json: {status: "failure", data: [], errors: booking.errors.full_messages.join(', ')},status: :unprocessable_entity
                end
            else
                render json: {status: "failure", data: [], errors: "no service available for booking with company id : #{params[:company_id]} and company service id : #{params[:company_service_id]}"}
            end
        end

        def update_booking
            new_params = params.as_json(only: [:booking_date, :is_active])
            booking = Booking.find_by(id: params[:booking_id])
            if booking.present?
                if booking.update(new_params)
                    render json: {status: "success", data: booking, errors: []},status: :ok
                else
                    render json: {status: "failure", data: [], errors: booking.errors.full_messages.join(', ')},status: :unprocessable_entity
                end
            else
                render json: {status: "failure", data: [], errors: "booking not found with id #{params[:booking_id]}"},status: :unprocessable_entity
            end
        end

        def index_available_booking_slot
            data = []
            service = CompanyService.find_by(id: params[:company_service_id])
            company = Company.find_by(id: params[:company_id])
            if service.present? and company.present?
                time = Time.now.in_time_zone("Asia/Kolkata")
                if time.strftime("%M").to_i <= 30
                    time = time.beginning_of_hour
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
                render json: {status: "success", data: data, errors: []},status: :ok
            else
                render json: {status: "failure", data: [], errors: "company or service not found"},status: :unprocessable_entity
            end
            
        end

    end

end