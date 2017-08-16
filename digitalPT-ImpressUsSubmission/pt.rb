require_relative 'exercise_input'
require_relative 'exercise'
require 'date'
require 'pry'
require 'gosu'

# Pt class stores methods used to determine what exercises the users will do today, the suggested weight per exercise, and how many sets to do per exercise
class PT

  attr_accessor :exercises # list of exercises to enable the PT class to gain access to them as part of its methods

  def initialize
      @exercises = []
      @number_of_sets_to_demand = 2
      @number_of_exercises_to_demand = 2
  end

  # add exercise to array
  def add_exercises(exercise)
      @exercises << exercise
  end

  # loops through the exercises to provide a unique session type list
  def session_type_list
      session_type_list = []
      @exercises.each do |exercise|
          session_type = exercise.session_type
          session_type_list << session_type
      end
      return session_type_list.uniq
  end

  # identify the users last session from their workout_history
  def users_last_session_type(user)
      users_last_session_type = user.workout_history.last.session_type
  end


  # Determine the session type today by taking into account the user's previous exercise history
    def todays_session_type(user) #assume (and hope) that what the caller passes as user is in fact a user object
        ### Start of logic to determine the sesion type today ###
        # if the user has not yet logged an exercise in the workout history then just start with the first session type.
        if user.workout_history.empty? || user.workout_history.nil?
            return session_type_list[0]
        end

        session_type_list.each_with_index do |session_type, index|
            if users_last_session_type(user) == session_type
                if session_type == session_type_list.last
                    return session_type_list[0]
                else 
                    return session_type_list[(index+1)]
                end
            end
        end #loop
    end #todays_session_type

  # List of exercises for the user to complete today based on todays session type
  def todays_exercises(user)
      todays_exercises = []
      @exercises.each do |exercise|
          if exercise.session_type == todays_session_type(user)
          todays_exercises << exercise
          end
      end
      todays_exercises.uniq
  end

    # Split exercise list into compound exercises and non-compound
def split_todays_exercises_into_compound_noncompound_arrays(user)
    both_arrs = []
    todays_exercises_compound = []
    todays_exercises_noncompound = []
    todays_exercises(user).each do |exercise|
        if exercise.compound == true
            todays_exercises_compound << exercise
        else
            todays_exercises_noncompound << exercise
        end
    end
    both_arrs << todays_exercises_compound
    both_arrs << todays_exercises_noncompound
    both_arrs
end

# Randomly select 2 exercises from the todays_exercises list
def randomly_select_exercise_from_todays_exercises_list(user, compound)
    subarray_to_get = 1
    if compound
        subarray_to_get = 0 #the first array is compound exercises
    end 
    random_exercises = split_todays_exercises_into_compound_noncompound_arrays(user)[subarray_to_get]
    return random_exercises.sample(@number_of_exercises_to_demand)     
end


def previous_weight(user) #this should take into account the exercise being performed, as as this is now the previous weight is the last weight the user lifted, which likely will have been for a completely different exercise.
    if user.workout_history.empty? || user.workout_history.nil?
        return 0
    end

    last_weight_attempted = user.workout_history.last.weight
    last_weight_attempted.to_i
end

def previous_rep(user)
    if user.workout_history.empty? || user.workout_history.nil?
        return 0
    end
    last_rep_completed = user.workout_history.last.completed_reps
    last_rep_completed.to_i
end

def suggested_weight(previous_weight, previous_rep, optimal_rep)
    
    #now need to find appropriate weight difference percentage between current weight and optimal weight (optimal weight would result in optimal reps)

    # formula is rep_difference_percentage = previous_rep / optimal_rep * 100
    # weight_as_percentage = (rep_difference_percentage + 230)/3.15 
    # weight_adjustment_coefficient = weight_as_percentage / 100
    
    rep_difference_percentage = previous_rep / optimal_rep * 100
    weight_as_percentage = (rep_difference_percentage + 230)/3.15 
    weight_adjustment_coefficient = weight_as_percentage / 100
    suggested_weight = previous_weight * weight_adjustment_coefficient

    return suggested_weight.to_i
end

    # provide the final suggested weight after taking into account the max_weight_increment
def final_check_on_sugested_weight(previous_weight, previous_rep, optimal_rep, exercise)
    max_weight_increment_for_exercise = exercise.max_weight_increment
    if suggested_weight(previous_weight, previous_rep, optimal_rep) > max_weight_increment_for_exercise
        return suggested_weight(previous_weight, previous_rep, optimal_rep)
        else 
        return previous_weight + max_weight_increment_for_exercise 
    end
end


#  method to calculate daily amount of calories
# BMR x Activity Level = DAC(Your Daily Amount of Calories)
  def daily_amount_of_calories(gender, weight_in_kg, height_in_inches, age_in_years)
    # BMR for men = 66 + (6.2 x weight in pounds) + (12.7 x height in inches) 
    # – (6.76 x Age in years) * activity level
    weight_in_pounds = weight_in_kg * 2.204623
    calories = 0
    if gender == 'male'
      bmr_for_men = 66 + (6.2 * weight_in_pounds) + (12.7 * height_in_inches) - (6.76 * age_in_years)
      calories = bmr_for_men * 1.9 
    else # gender == 'female'
      # BMR for women = 655.1 + (4.35 x weight in pounds) + (4.7 x height in inches) 
      # – (4.7 x Age in years) * activity level
      bmr_for_women = 655.1 + (4.35 * weight_in_pounds) + (4.7 * height_in_inches) - (4.7 * age_in_years)
      calories = bmr_for_women * 1.375
    end
    return calories
  end

    def play_sound(path_to_file)
        tune = Gosu::Sample.new(path_to_file)
        tune.play
    end

    # returns a random Arnie sample
    def random_spirit_of_schwarzanegger
        path = "/home/alex/apps/ruby/digitalPT/"
        f1 = "arniebelieve.wav"
        f2 = "arnie_answer_the_questions.wav"
        f3 = "arnie_chillout.wav"
        f4 = "arnie_chillout_dickwad.wav"
        f5 = "arnie_comeon_doitnow.wav"
        f6 = "arnie_dontlisten_tohellwithyou.wav"
        f7 = "arnie_listen_carefully.wav"
        f8 = "arnie_that_hit_the_spot.wav"
        f9 = "arnie_there_is_no_bathroom.wav"
        fs = [f1, f2, f3, f4, f5, f6, f7, f8, f9]
        return path + fs.sample
    end

#weight, completed_reps, exercise_performed, duration, date, session_number, session_type
    def begin_workout(user)
        play_sound(random_spirit_of_schwarzanegger)
        system 'clear'
        puts "Today, we're focusing on #{todays_session_type(user)}"
        sleep 1
        system 'clear'
        # Do 2 x exercises from the compound list and loop until set count is completed
        compound_exercises = randomly_select_exercise_from_todays_exercises_list(user, true)  
        # first compound exercise of the day 
        first_compound_exercise_set_count = compound_exercises[0].set_count
        first_compound_exercise_set_count.times do
            weight_to_hoist = final_check_on_sugested_weight(previous_weight(user), previous_rep(user), 5, compound_exercises[0])
            puts "Do #{compound_exercises[0].name} @ #{weight_to_hoist}kgs"
            puts "How many reps did you do?"
            completed_reps_for_compound_exercise1 = gets.strip.to_i
            puts "How long did it take you (in minutes)?"
            duration_for_compound_exercise1 = gets.strip.to_i
            puts "Great Work!"
            sleep 1
            puts ""
            ## inputs into users workout history
            compound_exercise1_completed = ExerciseInput.new(weight_to_hoist,completed_reps_for_compound_exercise1, compound_exercises[0].name,duration_for_compound_exercise1,Date.today,1,compound_exercises[0].session_type)
            user.workout_history << compound_exercise1_completed
        end
        system 'clear'
        # second compound exercise of the day
        second_compound_exercise_set_count = compound_exercises[1].set_count
        second_compound_exercise_set_count.times do
            puts "Do #{compound_exercises[1].name} @ #{final_check_on_sugested_weight(previous_weight(user), previous_rep(user), 5, compound_exercises[1])}kgs"
            puts "How many reps did you do?"
            completed_reps_for_compound_exercise2 = gets.strip.to_i
            puts "How long did it take you (in minutes)?"
            duration_for_compound_exercise2 = gets.strip.to_i
            puts "Great Work!"
            sleep 1
            puts ""
            ## second compound_exercise added to the user.workout_array
            compound_exercise2_completed = ExerciseInput.new(50,completed_reps_for_compound_exercise2, compound_exercises[1].name,duration_for_compound_exercise2,Date.today,1,compound_exercises[1].session_type)
            user.workout_history << compound_exercise2_completed    
        end
        system 'clear'
        # Do 2 x exercises from the non-compound list
        noncompound_exercises = randomly_select_exercise_from_todays_exercises_list(user, false)
        # first noncompound exercise of the day    
        first_noncompound_exercise_set_count = noncompound_exercises[0].set_count
        first_noncompound_exercise_set_count.times do    
            puts "Do #{noncompound_exercises[0].name} @ #{final_check_on_sugested_weight(previous_weight(user), previous_rep(user), 5, noncompound_exercises[0])}kgs"
            puts "How many reps did you do?"
            completed_reps_for_noncompound_exercise1 = gets.strip.to_i
            puts "How long did it take you (in minutes)?"
            duration_for_noncompound_exercise1 = gets.strip.to_i
            puts "Great Work!"
            sleep 1
            puts ""
            ## first non compound_exercise added to the user.workout_array
            non_compound_exercise1_completed = ExerciseInput.new(50,completed_reps_for_noncompound_exercise1, noncompound_exercises[0].name,duration_for_noncompound_exercise1,Date.today,1,noncompound_exercises[0].session_type)
            user.workout_history << non_compound_exercise1_completed
        end
        system 'clear'
        # second noncompond exercise of the day
        second_noncompound_exercise_set_count = noncompound_exercises[1].set_count
        second_noncompound_exercise_set_count.times do 
            puts "Do #{noncompound_exercises[1].name} @ #{final_check_on_sugested_weight(previous_weight(user), previous_rep(user), 5, noncompound_exercises[1])}kgs"
            puts "How many reps did you do?"
            completed_reps_for_noncompound_exercise2 = gets.strip.to_i
            puts "How long did it take you (in minutes)?"
            duration_for_noncompound_exercise2 = gets.strip.to_i
            puts "Great Work!"
            sleep 1
            puts ""
            ## second non compound_exercise added to the user.workout_array
            non_compound_exercise2_completed = ExerciseInput.new(50,completed_reps_for_noncompound_exercise2, noncompound_exercises[1].name,duration_for_noncompound_exercise2,Date.today,1,noncompound_exercises[1].session_type)
            user.workout_history << non_compound_exercise2_completed
        end
            system 'clear'
            puts "Workout Complete!"
            sleep 1
            puts ""
     
    end

end
