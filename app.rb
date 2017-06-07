#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	validates :name, presence: true, length: {minimum: 3}
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
end

get '/' do
	erb :index			
end

get '/contacts' do
	erb :contacts
end

get '/visit' do
	@c = Client.new
	erb :visit
end

get '/barber/:id' do
	@barber = Barber.find(params[:id])
	erb :barber
end

post '/visit' do
	
	@c = Client.new params[:client]
	if @c.save
		erb "Вы записались"
	else
		@error = @c.errors.full_messages.first
		erb :visit
	end

end

post '/contacts' do

	@email = params[:email]
	@message = params[:message]

	contact = Contact.new(email: @email, message: @message)
	contact.save

	erb "Ваше сообщение отправлено"
end

get '/bookings' do
	@clients = Client.order "created_at DESC"
	erb :bookings
end