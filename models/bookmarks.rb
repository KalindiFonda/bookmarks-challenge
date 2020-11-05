# frozen_string_literal: true

require 'pg'
require './lib/db_connection'

class Bookmarks
  include DBConnection
  attr_reader :id, :url, :title

  def initialize(id:, url:, title:)
    @id = id
    @url = url
    @title = title
  end

  def self.all

    result = DBConnection.query("SELECT * FROM bookmarks;")
    result.map do |bookmark|
      Bookmarks.new(
        url: bookmark['url'],
        title: bookmark['title'],
        id: bookmark['id']
      )
    end
    # result.map do |row|
    #   new(id: row["id"], url: row["url"], title: row["title"])
    # end
  end

  def self.create(url:, title:)
    return false unless is_url?(url)
    result = DBConnection.query("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, title, url;")

    #result = DBConnection.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, url, title")
    bookmark = result.map do |row|
      new(id: row["id"], url: row["url"], title: row["title"])
    end.first
    #Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])

    bookmark
  end






  def self.find_by(id:)
    result = DBConnection.exec("SELECT * FROM bookmarks WHERE id=#{id};")
    result.map do |row|
      new(id: row["id"], url: row["url"], title: row["title"])
    end.first
  end

  def self.delete(id:)
    DBConnection.exec("DELETE FROM bookmarks WHERE id=#{id}")
  end
  #
  # def self.update(url:, title:)
  #   result = DBConnection.exec("UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id=#{id}")
  #   bookmark = result.map do |row|
  #     self.class.new(id: row["id"], url: row["url"], title: row["title"])
  #   end.first
  #   bookmark
  # end

  def update(url:, title:)
   bookmark = self.class.new(id: nil, url: url, title: title)
   # if bookmark.valid?
     result = DBConnection.exec("UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id=#{id} RETURNING id, url, title")
     bookmark = result.map do |row|
       self.class.new(id: row["id"], url: row["url"], title: row["title"])
     end.first
   # end
   bookmark
 end

   private

   def self.is_url?(url)
     url =~ /\A#{URI::regexp(['http', 'https'])}\z/
   end
end



#
# # This is my bookmarks class!!!!!!!!!!!
# class Bookmarks
#
#   # walkthrough uses def self.create(url:) https://github.com/makersacademy/course/blob/master/bookmark_manager/walkthroughs/10.md
#   attr_reader :id, :title, :url
#
#   def add_to_db
#     begin
#       if ENV['RACK_ENV'] == 'test'
#         connection = PG.connect(dbname: 'bookmark_manager_test')
#       else
#         conection = PG.connect(dbname: 'bookmark_manager')
#       end
#       con.exec "INSERT INTO bookmarks(title, url)
#                 VALUES('#{@title}', '#{@url}')"
#     rescue PG::Error => e
#       # We want R rated errors!
#         puts e.message
#     ensure
#         con.close if con
#     end
#   end
#
#   def self.all
#     begin
#       if ENV['RACK_ENV'] == 'test'
#         con = PG.connect(dbname: 'bookmark_manager_test')
#       else
#         con = PG.connect(dbname: 'bookmark_manager')
#       end
#       con.exec "SELECT title, url FROM bookmarks"
#     rescue PG::Error => e
#       # We want R rated errors!
#         puts e.message
#     ensure
#         #result.clear if result
#         con.close if con
#     end
#   end
# end
