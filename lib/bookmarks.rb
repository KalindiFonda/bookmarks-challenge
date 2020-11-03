# frozen_string_literal: true
require 'pg'

# This is my bookmarks class!!!!!!!!!!!
class Bookmarks

  # walkthrough uses def self.create(url:) https://github.com/makersacademy/course/blob/master/bookmark_manager/walkthroughs/10.md

  def initialize(title, url)
    @title = title
    @url = url
    add_to_db
  end

  def add_to_db
    begin
      if ENV['RACK_ENV'] == 'test'
        con = PG.connect(dbname: 'bookmark_manager_test')
      else
        con = PG.connect(dbname: 'bookmark_manager')
      end
      con.exec "INSERT INTO bookmarks(title, url)
                VALUES('#{@title}', '#{@url}')"
    rescue PG::Error => e
      # We want R rated errors!
        puts e.message
    ensure
        con.close if con
    end
  end

  def self.all
    begin
      if ENV['RACK_ENV'] == 'test'
        con = PG.connect(dbname: 'bookmark_manager_test')
      else
        con = PG.connect(dbname: 'bookmark_manager')
      end
      result = con.exec "SELECT title, url FROM bookmarks"
      result.map { |bookmark| bookmark['title'] }

    rescue PG::Error => e
      # We want R rated errors!
        puts e.message
    ensure
        result.clear if result
        con.close if con
    end
  end
end
