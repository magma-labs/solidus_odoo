FactoryBot.define do
  factory :order, class: Spree::Order do
    firstname "Joseph"
    lastname "Martinez"
    address1 "Third street #875"
    address2 ""
    city "Manzanillo"
    country_id "157"
    state_id "2235"
    state_name "Colima"
    zipcode "28017"
    phone "3143334456"
  end
end
