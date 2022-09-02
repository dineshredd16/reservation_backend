class CompanyService < ApplicationRecord

    include Filterable

    belongs_to :company_services
end
