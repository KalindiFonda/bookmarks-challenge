# frozen_string_literal: true
require 'bookmarks'

RSpec.describe Bookmarks do
  describe '#all' do
    it 'returns a list of bookmarks' do
      populate_test_bookmarks_table
      bookmarks = Bookmarks.all
      expect(bookmarks).to include('Google')
    end
  end
end
