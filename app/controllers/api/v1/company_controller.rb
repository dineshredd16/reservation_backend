module Api::V1

    class CompanyController < ApplicationController

        def index_company
            companies = Company.filter(params.slice(:by_service)).is_active
            render json: {status: "success", data: companies, errors: []},status: :ok
        end

        def create_company
            new_params = params.as_json(only: [:name, :code, :gstin, :pan_no, :address, :working_days, :start_time, :end_time])
            company = Company.new(new_params)
            company.is_active = true
            if company.save
                render json: {status: "success", data: company, errors: []},status: :ok
            else
                render json: {status: "failure", data: [], errors: company.errors.full_messages.join(', ')},status: :unprocessable_entity
            end
        end

        def update_company
            new_params = params.as_json(only: [:gstin, :pan_no, :address, :working_days, :start_time, :end_time, :is_active])
            company = Company.find_by(id: params[:company_id])
            if company.present?
                if company.update(new_params)
                    render json: {status: "success", data: company, errors: []},status: :ok
                else
                    render json: {status: "failure", data: [], errors: company.errors.full_messages.join(', ')},status: :unprocessable_entity
                end
            else
                render json: {status: "failure", data: [], errors: "company not found with id #{params[:company_id]}"},status: :unprocessable_entity
            end
        end
        
    end
end