enable :sessions

get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/create' do
	@user = User.new(:name => params[:name], :email => params[:email])
	@user.password= params[:password]
	@user.save 
	@user = User.find_by_email(params[:email])
	session[:user_id] = @user.id
  redirect "/profile/#{@user.id}"
	
end

post '/profile' do
  @user = User.find_by_email(params[:email])
	if @user.password == params[:password]
		session[:user_id] = @user.id
		redirect "/profile/#{@user.id}"
  else
		redirect '/'
	end	
end

get '/profile/:id' do
	p session[:user_id]
	p params[:id]
	if session[:user_id].to_s == params[:id]
		@user = current_user
		@user_urls = @user.urls

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

post '/urls' do
  @new_url = Url.create_short(params[:original_url], session[:user_id])
  p @new_url
  if @new_url == false
  	erb :error
  else
	  @new_url.short_url
	  # erb :index
	end
end

# e.g., /q6bda
get '/:short_url' do
  @url = Url.find_by_short_url(params[:short_url])
  old_count = @url.click_count
  @url.update_attributes(:click_count => old_count + 1)
  redirect "#{@url.original_url}"
end

