# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Projects', type: :feature do
  scenario 'user creates a new project' do
    user = create(:user)
    # using our customer login helper:
    # sign_in_as user
    # or the one provided by Devise:
    login_as user, scope: :user
    visit root_path

    expect do
      click_link 'New Project'
      fill_in 'Name', with: 'Test Project'
      fill_in 'Description', with: 'Trying out Capybara'
      click_button 'Create Project'

      aggregate_failures do
        expect(page).to have_content 'Project was successfully created'
        expect(page).to have_content 'Test Project'
        expect(page).to have_content "Owner: #{user.name}"
      end
    end.to change(user.projects, :count).by(1)
  end
end
