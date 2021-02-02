#create 2 ussers
jose = User.create(name: "Jose", email: "jose@gmail.com", password: "password")
jasmine = User.create(name: "Jasmine", email: "jasmine@gmail.com", password: "password")

#create some workout entries

WorkoutEntry.create(exercise: "bench press", reps: "4x10", user_id: jose.id)

jasmine.workout_entries.create(exercise: "lat pulls", reps: "4x8") 