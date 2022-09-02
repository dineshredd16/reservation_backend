class CompanyService < ApplicationRecord

    include Filterable

    belongs_to :company, optional: true
    belongs_to :booking, optional: true

    validates_uniqueness_of :service_code

    scope :is_service_active, -> {where(is_active: true)}
    scope :company_id, -> (id) {where(company_id: id)}
    scope :by_company_service_id, -> (service_id) {where(id: service_id)}
    
end
