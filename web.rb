require 'rubygems'
require 'sinatra/base'
require 'pony'
require 'net/smtp'

class Web < Sinatra::Base

  configure do
    set :public_folder, 'public'
  end

  get '/' do
    redirect '/index.html'
  end

  post '/index.html' do 
    require 'pony'
    Pony.mail(
      :from => params[:email_address],
      :to => 'londontocorsica@gmail.com',
      :subject => 'RE: Wedding answer from ' + params[:name],
      :body => params[:name] + ' is coming to the wedding. He/she put ' + params[:vegetarian] + ' for vegetarian, ' + params[:invitees] + ' for invitees. And asked: ' + params[:message],
      :via => :smtp,
      :via_options => { 
        :address              => 'smtp.gmail.com',
        :port           => '587',
        :enable_starttls_auto => true, 
        :user_name => ENV['WEDDING_USERNAME'],
        :password => ENV['WEDDING_PASSWORD'],
        :authentication       => :plain, 
        :domain               => 'localhost.localdomain'
      })
    redirect '/index.html' 
  end
end