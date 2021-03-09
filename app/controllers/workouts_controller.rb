class WorkoutController < ApplicationController


    get '/workout_entries' do
        @workout_entries = WorkoutEntry.all 
        erb :'workout_entries/index'
    end

    get '/workout_entries/new' do
        redirect_if_not_logged_in
        erb :'/workout_entries/new'
    end 

    post '/workout_entries' do
        redirect_if_not_logged_in

        if params[:exercise] != ""
            @workout_entry = WorkoutEntry.create(exercise: params[:exercise], user_id: current_user.id, reps: params[:reps]) 
            flash[:message] = "Workout successfully created!"
            redirect "/workout_entries/#{@workout_entry.id}"
        else
            flash[:errors] = "Oops, something went wrong, make sure everything is filled out"
            redirect '/workout_entries/new'
        end 
    end 

    get '/workout_entries/:id' do
        set_workout_entry
        erb :'/workout_entries/show'
    end

    get '/workout_entries/:id/edit' do
        redirect_if_not_logged_in
        set_workout_entry
        if authorized_to_edit?(@workout_entry)
            erb :'/workout_entries/edit'
        else
            redirect "users/#{current_user.id}"
        end
      end

    patch '/workout_entries/:id' do
        redirect_if_not_logged_in
        set_workout_entry
        if @workout_entry.user == current_user && params[:exercise] != "" && params[:reps] != ""
            @workout_entry.update(exercise: params[:exercise], reps: params[:reps])
            flash[:message] = "Successfully edited this workout."
            redirect "/workout_entries/#{@workout_entry.id}"
        else
            flash[:errors] = "Cannot edit someone else's workout!"
            redirect "users/#{current_user.id}"
        end
    end

    delete '/workout_entries/:id' do
        set_workout_entry
        if authorized_to_edit?(@workout_entry)
            @workout_entry.destroy
            flash[:message] = "Successfully deleted this workout."
            redirect '/workout_entries'
        else 
            flash[:errors] = "Cannot delete someone else's workout!"
            redirect '/workout_entries'
        end 
    end
    
end


