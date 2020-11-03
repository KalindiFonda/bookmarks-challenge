# frozen_string_literal: true

require 'sinatra/base'
require './lib/bookmarks.rb'
# This is my new class
class BookmarkManager < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/test' do
    'Hello world!'
  end

  get '/bookmarks' do
    @bookmarks = Bookmarks.all
    erb :'bookmarks/index'
  end

  post '/bookmarks' do
    Bookmarks.new(params[:bookmark_title], params[:bookmark_url])
    redirect '/bookmarks'
  end
  run! if app_file == $PROGRAM_NAME
end
