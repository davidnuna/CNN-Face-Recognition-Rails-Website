# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [{ email: 'face.david@recognition.com', password: 'password', password_confirmation: 'password', user_class: 'david' }]
(1..40).each do |subject_number|
  users << { email: "face.subject_#{subject_number}@recognition.com", password: 'password', password_confirmation: 'password', user_class: "subject_#{subject_number}"}
end

User.create!(users)
puts "#{User.count} users created!"

User.all.each do |user|
  user.user_image.attach(io: File.open("app/assets/#{user.user_class}.jpg"), filename: "#{user.user_class}.jpg")
  puts "app/assets/#{user.user_class}.jpg"
end