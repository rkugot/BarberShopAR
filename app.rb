#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

before do
	@barbers = Barber.all
end

get '/' do
	@barbers = Barber.all
	erb :index			
end

get '/contacts' do
	erb :contacts
end

get '/visit' do
	erb :visit
end

post '/visit' do
	
	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]

	user = Client.new(name: @username, phone: @phone, datestamp: @datetime, barber: @barber, color: @color)
	user.save

	erb "<h2>Спасибо #{@username}, Вы записались</h2>"
end

post '/contacts' do

	@email = params[:email]
	@message = params[:message]

	contact = Contact.new(email: @email, message: @message)
	contact.save

	erb "Ваше сообщение отправлено"
end