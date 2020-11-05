# frozen_string_literal: true
require './models/bookmarks.rb'
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
end
feature 'create a bookmark' do
  before(:each) do
    populate_test_bookmarks_table
  end
  scenario 'add bookmark' do
    visit '/bookmarks'
    fill_in 'title', :with => 'PIZZA'
    fill_in 'url', :with => 'http://www.pizza.org'
    click_on('Add bookmark')
    expect(page).to have_content('PIZZA')
  end
  scenario 'The bookmark must be a valid URL' do
    visit('/bookmarks')
    fill_in('url', with: 'not a real bookmark')
    click_button('Add bookmark')

    expect(page).not_to have_content "not a real bookmark"
    expect(page).to have_content "You must submit a valid URL."
  end


end


# in spec/features/deleting_a_bookmark_spec.rb

feature 'delete a bookmark' do
  scenario 'A user can delete a bookmark' do
    Bookmarks.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    Bookmarks.create(url: 'http://www.makers.com', title: 'Makers')
    visit('/bookmarks')
    expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')
    first('.bookmark').click_button 'Delete'
    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Makers Academy', href: 'http://www.makersacademy.com')
    expect(page).to have_link('Makers', href: 'http://www.makers.com')

  end
end


feature 'update a bookmark' do
  scenario 'A user can update a bookmark' do
    bookmark = Bookmarks.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit('/bookmarks')
    expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')
    first('.bookmark').click_button 'Edit'
    bookmarks = Bookmarks.all
    first_bookmark = bookmarks[0]

    expect(current_path).to eq "/bookmarks/#{first_bookmark.id}/edit"
    fill_in('url', with: "http://www.mmakersacademy.com")
    fill_in('title', with: "Mmakers Academy")
    click_button('Update bookmark')
    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Makers Academy', href: 'http://www.makersacademy.com')
    expect(page).to have_link('Mmakers Academy', href: 'http://www.mmakersacademy.com')
  end
end
