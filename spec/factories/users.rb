# spec/factories/users.rb
FactoryBot.define do
    factory :user do
      name { 'John Doe' }
      email { 'john@example.com' }
      password { 'password123' }
      phone { '1234567890' }
    end
end