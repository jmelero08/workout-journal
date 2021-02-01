class CreateWorkoutEntries < ActiveRecord::Migration
  def change
    create_table :workout_entries do |t|
      t.string :exercise
      t.string :reps
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
