FactoryBot.define do
  factory :user do
    password { 'testing' }
    password_confirmation { 'testing' }
  end

  factory :student, class: User do
    email { 'stu_dent@test.com '}
    first_name { 'Stu' }
    last_name { 'Dent' }
    password { 'testing' }
    password_confirmation { 'testing' }
    user_class { 'test student' }
  end

  factory :teacher, class: User do
    email { 'tea_cher@test.com '}
    first_name { 'Tea' }
    last_name { 'Cher' }
    password { 'testing' }
    password_confirmation { 'testing' }
    user_class { 'test teacher' }
  end
end