class WorkoutController < ApplicationController

    get '/workout_entries/new' do
        erb :'/workout_entries/new'
    end 

    post '/workout_entries' do
        if !logged_in?
            redirect '/'
        end

        if params[:exercise] != ""
            @workout_entry = WorkoutEntry.create(exercise: params[:exercise], user_id: current_user.id, reps: params[:reps]) 
            redirect "/workout_entries/#{@workout_entry.id}"
        else
            redirect '/workout_entries/new'
        end 
    end 

    get '/workout_entries/:id' do
        @workout_entry = WorkoutEntry.find(params[:id])
        erb :'/workout_entries/show'
    end
end