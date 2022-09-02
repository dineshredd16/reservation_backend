module Api::V1

    class CompanyServiceController < ApplicationController

        def index_company_service
            company = Company.find_by(id: params[:company_id])
            if company.present?
                services = CompanyService.filter(params.slice(:company_id)).is_service_active
                render json: {status: "success", data: services, errors: []},status: :ok
            else
                render json: {status: "failure", data: [], errors: "company not found with id #{params[:company_id]} to show services"}
            end
        end

        def create_company_service
            company = Company.find_by(id: params[:company_id])
            if company.present?
                new_params = params.as_json(only: [:name, :service_code, :company_id, :price, :slots, :time_taken])
                company_service = CompanyService.new(new_params)
                company_service.is_active = true
                if company_service.save
                    render json: {status: "success", data: company_service, errors: []},status: :ok
                else
                    render json: {status: "failure", data: [], errors: company_service.errors.full_messages.join(', ')},status: :unprocessable_entity
                end
            else 
                render json: {status: "failure", data: [], errors: "invalid company id #{params[:company_id]} to create services"}
            end
        end

        def update_company_service
            new_params = params.as_json(only: [:price, :slots, :time_taken, :is_active])
            company_service = CompanyService.find_by(id: params[:company_service_id])
            if company_service.present?
                if company_service.update(new_params)
                    render json: {status: "success", data: company_service, errors: []},status: :ok
                else
                    render json: {status: "failure", data: [], errors: company_service.errors.full_messages.join(', ')},status: :unprocessable_entity
                end
            else
                render json: {status: "failure", data: [], errors: "company service not found with id #{params[:company_service_id]}"},status: :unprocessable_entity
            end
        end

    end
    
end