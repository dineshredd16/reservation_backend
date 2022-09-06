module Api::V1

    class BookingController < ApplicationController

        def index_booking
            data = BookingService.list(params)
            render json: {status: "success", data: data, errors: []},status: :ok
        end

        def create_booking
            status, data = BookingService.create(params)
            if status
                render json: {status: "success", data: data, errors: []},status: :ok
            else
                render json: {status: "failure", data: [], errors: data},status: :unprocessable_entity
            end
        end

        def update_booking
            status, data = BookingService.update(params)
            if status
                render json: {status: "success", data: data, errors: []},status: :ok
            else
                render json: {status: "failure", data: [], errors: data},status: :unprocessable_entity
            end
        end

        def index_available_booking_slot
            status, data = BookingService.list_available_slots(params)
            if status
                render json: {status: "success", data: data, errors: []},status: :ok
            else
                render json: {status: "failure", data: [], errors: data},status: :unprocessable_entity
            end
        end

    end

end