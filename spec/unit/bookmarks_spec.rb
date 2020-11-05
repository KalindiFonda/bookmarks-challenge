# frozen_string_literal: true
require './models/bookmarks.rb'
require './spec/database_helpers'


RSpec.describe Bookmarks do
  describe '#all' do
    it 'returns a list of bookmarks' do
      populate_test_bookmarks_table
      bookmarks = Bookmarks.all
      b_list = bookmarks.map { |b| b.title}
      expect(b_list).to include('Google')
    end
  end
  describe '.delete' do
    it 'deletes the given bookmark' do
      Bookmarks.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
      bookmarks = Bookmarks.all
      first_bookmark = bookmarks[0]
      Bookmarks.delete(id: first_bookmark.id)
      expect(Bookmarks.all.length).to eq 0
    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmarks.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
      persisted_data = persisted_data(id: bookmark.id)

      expect(bookmark).to be_a Bookmarks
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq 'Test Bookmark'
      expect(bookmark.url).to eq 'http://www.testbookmark.com'
    end
    it 'does not create a new bookmark if the URL is not valid' do
      Bookmarks.create(url: 'not a real bookmark', title: 'not a real bookmark')
      expect(Bookmarks.all).to be_empty
    end
  end
  describe '#update' do
    it 'updates a record from the table' do
      Bookmarks.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
      bookmarks = Bookmarks.all
      first_bookmark = bookmarks[0]
      first_bookmark.update(url: 'http://www.title.com', title: 'new_title')
      updated_bookmark = Bookmarks.find_by(id: first_bookmark.id)
      expect(updated_bookmark.url).to eq 'http://www.title.com'
      expect(updated_bookmark.title).to eq 'new_title'
    end
  end
end
