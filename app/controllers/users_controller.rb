class UsersController < ApplicationController

    get '/login' do
        erb :login 
    end

    post '/login' do
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            puts session
            flash[:message] = "Welcome back, #{@user.name}!"
            redirect "users/#{@user.id}"
        else
            flash[:errors] = "No user name found, please sign up!"
            redirect '/login'
        end 
    end

    get '/signup' do
        erb :signup 
    end 

    post '/users' do
        @user = User.new(params)
            if @user.save
            session[:user_id] = @user.id
            flash[:message] = "You can now start tracking your workouts!"
            redirect "/users/#{@user.id}"
        else
            flash[:errors] = "Account creation failure: #{@user.errors.full_messages.to_sentence}"
            redirect '/signup'
        end 
    end

    get '/users/:id' do
        @user = User.find_by(id: params[:id])
        redirect_if_not_logged_in
        erb :'/users/show'
    end

    get '/logout' do
        session.clear
        redirect '/'
    end
end 