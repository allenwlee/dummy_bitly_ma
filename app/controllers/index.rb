enable :sessions

get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/create' do
	encrypted_password = params[:password].reverse
	@user = User.create(:name => params[:name], :email => params[:email], 
		          :password => encrypted_password)
	erb :profile
end

post '/profile' do
	if User.authenticate?(params[:email], params[:password]) == true
		@user = User.find_by_email(params[:email])
		session[:user_id] = @user.id
		redirect "/profile/#{@user.id}"
	else
		redirect '/'
	end	
end

get '/profile/:id' do
	# p session[:user_id]
	# p params[:id]
	if session[:user_id].to_s == params[:id]
		@user = User.find(params[:id])
		erb :profile
	else
		erb :access_denied
	end
end


get '/login' do
	erb :login
end

get '/create' do
	erb :index
end

get '/logout' do
	session.clear
	erb :index
end

