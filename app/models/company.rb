class Company < ApplicationRecord

    include Filterable

    has_many :company_services

    validates_uniqueness_of :name
    validates_uniqueness_of :code

    scope :is_active, -> {where(is_active: true)}
    scope :by_service, -> (service_code) {joins(:company_services).where(company_services: {service_code: service_code, is_active: true})}


end
