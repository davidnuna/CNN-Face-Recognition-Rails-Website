require 'rails_helper'

RSpec.describe 'Face Recognition Login', js: true, type: :feature do
  let!(:create_users) { create_users }

  scenario 'valid and complete flow' do
    visit new_login_path
    expect(page).to have_content('Facial recognition image')
    expect(page).to have_content('Upload a picture instead')
    expect(page).to have_content('Take photo')
    expect(find("#login_image_method", :visible => false).value).to  eq('camera')
    expect(find("#login_image_camera", :visible => false).value).to  eq('')
    sleep 5
    click_on 'Take photo'
    expect(find("#login_image_method", :visible => false).value).to  eq('camera')
    expect(find("#login_image_camera", :visible => false).value).not_to eq('')
    click_on 'Confirm'
    sleep 10

    login_attempt = LoginAttempt.last
    expect(page).to have_current_path(select_user_login_path login_attempt)
    expect(page).to have_content('Select user')
    expect(page).to have_content('Please select your profile from the below options')
    expect(page).to have_css('.select_user', count: 3)
    expect(page).to have_content('Probability', count: 3)
    expect(find("#user_id", :visible => false).value).to eq('')
    first('.select_user').click
    expect(find("#user_id", :visible => false).value).not_to eq('')
    user = User.find(find("#user_id", :visible => false).value)
    click_on 'Choose User'

    expect(page).to have_current_path(login_page_login_path login_attempt)
    expect(page).to have_content('Log in')
    expect(page).to have_content('Please provide the password for the previously chosen user')
    expect(page).to have_field('user_email', readonly: true)
    fill_in 'Password', with: 'testing'
    click_on 'Log in'
    sleep 3

    expect(page).to have_current_path(root_path login_attempt)
    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content('Exam Quiz Application')
    expect(page).to have_content("#{user.first_name} #{user.last_name}")
  end

  def create_users
    users = [ create(:user, email: 'quiz.david@test.com', user_class: 'david', first_name: 'David', last_name: 'Nuna') ]
    (1..38).each do |subject_number|
      users << create(:user, email: "quiz.subject_#{subject_number}@fr.com", user_class: "subject_#{subject_number}", first_name: 'Subject', last_name: "#{subject_number}")
    end

    # To modify!
    users.each do |user|
      user.user_image.attach(io: File.open("app/assets/#{user.user_class}.jpg"), filename: "#{user.user_class}.jpg")
      puts "app/assets/#{user.user_class}.jpg"
    end
  end
end