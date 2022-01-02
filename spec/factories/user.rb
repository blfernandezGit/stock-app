FactoryBot.define do
    factory(:user) do
        full_name { Faker::Name.name }
        email { Faker::Internet.unique.email }
        password { Faker::Internet.password }
        trait :admin do
            after(:create) {|user| user.update(role: 'admin')}
        end
    end
end 