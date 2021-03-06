class UsersController < ApplicationController


  get "/signup" do
    if is_logged_in?
      redirect to "/tweets"
    else
    erb :"/users/create_user"
   end
  end

   post "/signup" do
     if params[:username] == "" || params[:password] == "" || params[:email] == ""
       redirect to "/signup"
     else
       @user= User.create(:username => params[:username], :password => params[:password], :email =>params[:email])
       session[:user_id] = @user.id
       redirect to "/tweets"
     end
   end

    get '/login' do
      if is_logged_in?
        redirect "/tweets"
      else
      erb :'/users/login'
      end
    end

    post '/login' do
      @user = User.find_by(username: params[:username])

      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to "/tweets"
      else
        redirect to "/login"
      end
    end

    get '/logout' do
      if is_logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/tweets'
    end
  end

    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])

      erb :'/users/show'
    end
end
