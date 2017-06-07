#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	validates :name, presence: true
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

before do
	@barbers = Barber.all
	@clients = Client.all
end

get '/' do
	erb :index			
end

get '/contacts' do
	erb :contacts
end

get '/visit' do
	erb :visit
end

post '/visit' do
	
	c = Client.new params[:client]
	c.save

	erb "Вы записались"
end

post '/contacts' do

	@email = params[:email]
	@message = params[:message]

	contact = Contact.new(email: @email, message: @message)
	contact.save

	erb "Ваше сообщение отправлено"
end