# frozen_string_literal: true
require 'bookmarks'

feature 'bookmarks-page' do
  before(:each) do
    populate_test_bookmarks_table
  end
  scenario 'show title' do
    visit '/bookmarks'
    expect(page).to have_content('Bookmarks')
  end
  scenario 'show list of bookmarks' do
    visit '/bookmarks'
    expect(page).to have_content('Google')
  end
  scenario 'add bookmark' do
    visit '/bookmarks'
    fill_in 'bookmark_title', :with => 'PIZZA'
    fill_in 'bookmark_url', :with => 'http://www.pizza.org'
    click_on('Add bookmark')
    expect(page).to have_content('PIZZA')
  end
end
