# frozen_string_literal: true

require 'sinatra/base'
require './models/bookmarks.rb'
require './db_connection_setup'
require 'uri'
require 'sinatra/flash'


# This is my new class
class BookmarkManager < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  set :session_secret, "here be dragons"

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

  # post '/bookmarks' do
  #   Bookmarks.create(url: params[:url], title: params[:title])
  #   #Bookmarks.new(params[:bookmark_title], params[:bookmark_url])
  #   redirect '/bookmarks'
  # end

  post '/bookmarks' do
    flash[:notice] = "You must submit a valid URL." unless Bookmarks.create(url: params[:url], title: params[:title])
    redirect('/bookmarks')
  end

  enable :sessions, :method_override

  delete '/bookmarks/:id' do
    Bookmarks.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmarks.find_by(id: params[:id])
    erb :'bookmarks/edit'
  end

  patch '/bookmarks/:id' do
    bookmark = Bookmarks.find_by(id: params[:id])
    bookmark.update(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end


  run! if app_file == $PROGRAM_NAME
end
