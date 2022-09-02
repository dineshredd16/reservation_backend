class Company < ApplicationRecord

    include Filterable

    has_many :company_services
end
