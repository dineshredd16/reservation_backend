module Api::V1

    class ReportController < ApplicationController

        def generate_bookings_report
            data = []

            start_date = params[:start_date].present? ? params[:start_date].to_date : Date.current.beginning_of_month
            end_date = params[:end_date].present? ? params[:end_date].to_date : Date.current.end_of_month
            bookings = Booking
                .filter(params.slice(:by_company, :by_company_service))
                .joins("
                    Inner Join companies on companies.id = bookings.company_id 
                    Inner Join company_services as cs on cs.id = bookings.company_service_id")
                .where(booking_date: start_date..end_date)

            active_bookings = bookings
                    .where(is_active: true)
                    .select("bookings.id, cs.name as service_name, cs.price as service_price, companies.name as company_name, bookings.booking_date")

            cancelled_bookings = bookings.where(is_active: false).select("bookings.id, cs.name as service_name, cs.price as service_price, companies.name as company_name, bookings.booking_date")

            revenue_loss_bookings = cancelled_bookings.where.not(company_service_id: active_bookings.pluck(:company_service_id), booking_date: active_bookings.pluck("bookings.booking_date")).sum("cs.price")

            active_bookings.each do |booking|
                data << {service_name: booking.service_name, service_price: booking.service_price, company_name: booking.company_name, booking_date: booking.booking_date.strftime("%d-%m-%Y %H:%M")}
            end

            render json: {status: "success", revenue_earned: active_bookings.sum("cs.price"), revenue_lost: revenue_loss_bookings, report: data,  errors: []},status: :ok

        end

    end
end