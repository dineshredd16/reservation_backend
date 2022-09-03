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
                render json: {status: "failure", data: [], errors: data},status: :ok
            end
        end

        def update_booking
            status, data = BookingService.create(params)
            if status
                render json: {status: "success", data: data, errors: []},status: :ok
            else
                render json: {status: "failure", data: [], errors: data},status: :ok
            end
        end

        def index_available_booking_slot
            status, data = BookingService.create(params)
            if status
                render json: {status: "success", data: data, errors: []},status: :ok
            else
                render json: {status: "failure", data: [], errors: data},status: :ok
            end
        end

    end

end