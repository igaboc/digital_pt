require_relative 'pt'
require_relative 'exercise'
require_relative 'user'
require_relative 'exercise_input'
require 'pry'
require 'date'


########### dummy data for exercises ############

def generate_dummy_data_for_presentation(pt1,user)

#generate the exercises:
# For the legs session type
  legs1 = Exercise.new("Full Squat", "Legs", true, 10, 5, 1.2,4,3) 
  legs2 = Exercise.new("Barbell Lunge", "Legs", false, 15, 5, 1.1,4,2) 
  legs3 = Exercise.new("Deadlift", "Legs", true, 15, 5, 1.3,2,4) 
  legs4 = Exercise.new("Leg Press", "Legs", false, 20, 5, 1.25,6,5) 
  legs5 = Exercise.new("Ham String Curl", "Legs", true, 12, 5, 1.15,4,4) 
  # For the Biceps, Triceps, Forearms and Abs (aka BTFA) session type 
  btfa1 = Exercise.new("Bicep Curls", "BTFA",true, 10, 5, 1.2,4,3) 
  btfa2 = Exercise.new("Shoulder Press", "BTFA", false, 10, 5, 1.2,4,3) 
  btfa3 = Exercise.new("Bench Press", "BTFA", true, 10, 5, 1.2,4,3) 
  btfa4 = Exercise.new("Triceps Extension", "BTFA", false, 10, 5, 1.2,4,3) 
  btfa5 = Exercise.new("Sit Up", "BTFA", true, 10, 5, 1.2,4,3) 
  # For the Shoulders and Traps session type
  shoulders_traps1 = Exercise.new("Dumbell Shoulder Press", "Shoulders and Traps",true, 10, 5, 1.2,4,3) 
  shoulders_traps2 = Exercise.new("Upright Barbell Row", "Shoulders and Traps", false, 10, 5, 1.2,4,3) 
  shoulders_traps3 = Exercise.new("Seated Bent-over Rear Delt Raise", "Shoulders and Traps", true, 10, 5, 1.2,4,3) 
  shoulders_traps4 = Exercise.new("Side Lateral Raise", "Shoulders and Traps", false, 10, 5, 1.2,4,3) 
  shoulders_traps5 = Exercise.new("Barbell Shrug", "Shoulders and Traps", true, 10, 5, 1.2,4,3) 
  # For the Back session type
  back1 = Exercise.new("Barbell Deadlift", "Back", true, 10, 5, 1.2,4,3) 
  back2 = Exercise.new("Wide-Grip Pull Up", "Back", false, 10, 5, 1.2,4,3) 
  back3 = Exercise.new("Bent-Over Barbell Deadlift", "Back", true, 10, 5, 1.2,4,3) 
  back4 = Exercise.new("Standing T-Bar Row", "Back", false, 10, 5, 1.2,4,3) 
  # For the Chest session type
  chest1 = Exercise.new("Barbell Bench Press", "Chest", true, 10, 5, 1.2,4,3) 
  chest2 = Exercise.new("Flat Bench Dumbbell Press", "Chest", false, 10, 5, 1.2,4,3) 
  chest3 = Exercise.new("Seated Machine Chest Press", "Chest", true, 10, 5, 1.2,4,3) 
  chest4 = Exercise.new("Incline Dumbbell Press", "Chest", false, 10, 5, 1.2,4,3) 
  chest5 = Exercise.new("Machine Decline Press", "Chest", true, 10, 5, 1.2,4,3) 

# add exercises to the PT object so that it's aware of them
  pt1.add_exercises(legs1)
  pt1.add_exercises(legs2)
  pt1.add_exercises(legs3)
  pt1.add_exercises(legs4)
  pt1.add_exercises(legs5)
  pt1.add_exercises(btfa1)
  pt1.add_exercises(btfa2)
  pt1.add_exercises(btfa3)
  pt1.add_exercises(btfa4)
  pt1.add_exercises(btfa5)
  pt1.add_exercises(shoulders_traps1)
  pt1.add_exercises(shoulders_traps2)
  pt1.add_exercises(shoulders_traps3)
  pt1.add_exercises(shoulders_traps4)
  pt1.add_exercises(shoulders_traps5)
  pt1.add_exercises(back1)
  pt1.add_exercises(back2)
  pt1.add_exercises(back3)
  pt1.add_exercises(back4)
  pt1.add_exercises(chest1)
  pt1.add_exercises(chest2)
  pt1.add_exercises(chest3)
  pt1.add_exercises(chest4)
  pt1.add_exercises(chest5)


  # establish id for user
  user.username = "jim"
  user.password = "password"
  user.first_name = "Jimmy"
  user.last_name = "Coder"
  user.gender = "Male"
  user.body_type = "Mesomorph"
  user.goal = "musclebuild"
  user.disclaimer = "accept"
  user.date_of_birth = Date.new(1990,9,9)
  # binding.pry
  user.weight = 56
  user.goal_weight = 75

#establish some dummy workout history for our user:
  # (weight, completed_reps, exercise_performed, duration, date, session_number, session_type)
  workout_history_for_user = ExerciseInput.new(10, 8, chest1.name, 10, Date.new(2017,8,1), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #
  workout_history_for_user = ExerciseInput.new(10, 9, chest1.name, 10, Date.new(2017,8,1), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #
  workout_history_for_user = ExerciseInput.new(10, 10, chest1.name, 10, Date.new(2017,8,1), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #
  workout_history_for_user = ExerciseInput.new(10, 11, chest1.name, 10, Date.new(2017,8,2), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #
  workout_history_for_user = ExerciseInput.new(15, 8, chest1.name, 10, Date.new(2017,8,2), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #
  workout_history_for_user = ExerciseInput.new(15, 9, chest1.name, 10, Date.new(2017,8,2), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #
  workout_history_for_user = ExerciseInput.new(15, 9, chest1.name, 10, Date.new(2017,8,2), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #
  workout_history_for_user = ExerciseInput.new(15, 8, chest1.name, 10, Date.new(2017,8,3), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #
  workout_history_for_user = ExerciseInput.new(15, 8, chest1.name, 10, Date.new(2017,8,3), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #
  workout_history_for_user = ExerciseInput.new(15, 8, chest1.name, 10, Date.new(2017,8,3), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #
  workout_history_for_user = ExerciseInput.new(15, 8, chest1.name, 10, Date.new(2017,8,3), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #
  workout_history_for_user = ExerciseInput.new(15, 8, chest1.name, 10, Date.new(2017,8,4), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #
  workout_history_for_user = ExerciseInput.new(15, 8, chest1.name, 10, Date.new(2017,8,4), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #
  workout_history_for_user = ExerciseInput.new(15, 8, chest1.name, 10, Date.new(2017,8,4), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #
  workout_history_for_user = ExerciseInput.new(15, 8, chest1.name, 10, Date.new(2017,8,4), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #
  workout_history_for_user = ExerciseInput.new(15, 5, chest1.name, 10, Date.new(2017,8,5), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #
  workout_history_for_user = ExerciseInput.new(15, 8, chest1.name, 10, Date.new(2017,8,6), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #
  workout_history_for_user = ExerciseInput.new(20, 8, chest1.name, 10, Date.new(2017,8,7), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #
  workout_history_for_user = ExerciseInput.new(20, 10, chest1.name, 10, Date.new(2017,8,8), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #
  workout_history_for_user = ExerciseInput.new(25, 7, chest1.name, 10, Date.new(2017,8,9), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #
  workout_history_for_user = ExerciseInput.new(25, 8, chest1.name, 10, Date.new(2017,8,10), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #
  workout_history_for_user = ExerciseInput.new(25, 9, chest1.name, 10, Date.new(2017,8,11), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #
  workout_history_for_user = ExerciseInput.new(25, 10, chest1.name, 10, Date.new(2017,8,12), 1, chest1.session_type)
  user.add_completed_session(workout_history_for_user)
  #


end

