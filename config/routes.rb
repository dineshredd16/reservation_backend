Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do

      get 'index_company', to: "company#index_company"
      post 'create_company', to: "company#create_company"
      put 'update_company', to: "company#update_company"

      get 'index_company_service', to: "company_service#index_company_service"
      post 'create_company_service', to: "company_service#create_company_service"
      put 'update_company_service', to: "company_service#update_company_service"

      get 'index_booking', to: "booking#index_booking"
      post 'create_booking', to: "booking#create_booking"
      put 'update_booking', to: "booking#update_booking"
      get 'index_available_booking_slot', to: "booking#index_available_booking_slot"

      get 'generate_bookings_report', to: "report#generate_bookings_report"

    end
  end
end
