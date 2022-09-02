class CompanyService < ApplicationRecord

    include Filterable

    belongs_to :company_services, optional: true

    validates_uniqueness_of :service_code

    scope :is_service_active, -> {where(is_active: true)}
    scope :company_id, -> (id) {where(company_id: id)}
end
