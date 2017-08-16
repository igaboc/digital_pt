require_relative 'moded_ascii_chart'
require_relative 'user'
require 'pry'

#CONSTANTS:

def max_days_to_render
  return 40
end

def score_scaling_coefficient
  return 100
end

#METHODS:

#BELOW FUNCTION TESTED AND WORKS - DOES WHAT IT SAYS
def render_user_history_graph_with_defaults(user)
  unless user.workout_history.nil? || user.workout_history.empty?
    start_date = user.workout_history.first.date
    end_date = user.workout_history.last.date
    render_user_history_graph_with_custom_dates(user, start_date, end_date)
  else
    puts "<you do not yet have any workout history>"
  end
end # render_user_history_graph_with_defaults

#BELOW FUNCTION TESTED AND WORKS - DOES WHAT IT SAYS
def render_user_history_graph_with_custom_dates(user, start_date, end_date)
  
  #pull out the users' history:
  user_history = user.workout_history

  # cut the history array to just look at the dates specified:
  history_snapshot = get_history_array_for_dates(user_history, start_date, end_date)
  
  #convert the history to an array where all the exercises performed on one day are counted as one and given a score (convert the array from one of ExerciseInput objects, to one of [score,date] hashes)
  history_snapshot_in_daily_performance = get_history_score_in_day_increments(history_snapshot)
  
  #now that we have the history as data to feed to the graphing program, run it through a function to compress it down to our maximum number of x values.
  history_as_plottable_x_vals = chunk_score_date_hash_array_for_chart_plots(history_snapshot_in_daily_performance, max_days_to_render)

  #make the title for the graph:
  title_string = "#{user.first_name}'s progress from #{start_date.day}/#{start_date.month}/#{start_date.year} to #{end_date.day}/#{end_date.month}/#{end_date.year}"

  #use that to create a new ascii_chart and draw it to the screen:
  puts AsciiCharts::Cartesian.new(history_as_plottable_x_vals, :title => title_string, :min_y_vals => 10, :max_y_vals => 20).draw
  puts ''
end #render_user_history_graph_with_custom_dates

#BELOW FUNCTION TESTED AND WORKS - DOES WHAT IT SAYS
def get_history_array_for_dates(history_array, start_date, end_date)
  # history_array is an array of ExerciseInput objects, 
  # returns: a sub array of history_array consisting only of the ExerciseInput objects whose date does not lie outside the bounds of start_date and end_date

  array_index_start = 0 #by default the start index will be the first element
  array_index_end = history_array.length - 1 #by default the last index will be the last element
  start_date_found = false  
  history_array.each_with_index do |exercise_input, index|
    # find the first index where exercise_input.date is greater than or equal to start_date
    if exercise_input.date >= start_date && !start_date_found
      array_index_start = index
      start_date_found = true
      # binding.pry
    end
    # find the last index where exercise_input.date is less than or equal to end_date
    if exercise_input.date > end_date
      array_index_end = index - 1 #then we've gone to far and the last one was the one just before
      break
    end
    if exercise_input == history_array.last # then we've reached the end and if we had found it by now this code wouldn't have run so the last one is also the last one of the specified date range
      array_index_end = index
      break
    end

  end #loop
  return history_array[array_index_start..array_index_end]

end # get_history_array_for_dates(history, start_date, end_date)

#BELOW FUNCTION TESTED AND WORKS - DOES WHAT IT SAYS
def chunk_score_date_hash_array_for_chart_plots(score_date_hash_array, number_of_chunks)
  chunked_array = []
  ### IMPORTANT: score_date_hash_array is an array of hashes that look like: {score: Integer, date:Date}

  #if score_date_hash_array contains 30 elements, and we need to return it with only 5 chunks(elements),
  # then we will need to make the chunks of size 30/5=6 elements.
  #so find the average of the first 6 elements and create a new element that is an array of [element_number_starts_at_zero, average_score] which when we get enough of those becomes our input to the ascii_chart module
  
  length_of_array = score_date_hash_array.length
  #figure out how many elements need to be 'chunked' and then round it up to the nearest integer:
  number_of_elements_to_group = length_of_array.to_f / number_of_chunks.to_f
  number_of_elements_to_group = number_of_elements_to_group.round(0).to_i

  #handle the case where there is not as much data as we are capable of displaying: (prevents division by zero further down.)


  invalid_argument = false #sanity check that we've been given a score date hash array
  if !score_date_hash_array.first.is_a? (Hash)
    puts "chunk_score_date_hash_array_for_chart_plots: argument not a hash"
    invalid_argument = true
  end

  if !score_date_hash_array.first[:score].is_a? (Integer)
    puts "chunk_score_date_hash_array_for_chart_plots: score,date hash doesn't have score value?"
    invalid_argument = true
  end

  if !score_date_hash_array.first[:date].is_a? (Date)
    puts "chunk_score_date_hash_array_for_chart_plots: score,date hash doesn't have date value?"
    invalid_argument = true
  end

  if invalid_argument
    return nil
  end

  if number_of_elements_to_group < 2
    score_date_hash_array.each_with_index do |element, index|
      chunked_array << [index, element[:score]]
    end
    return chunked_array
  end

  puts "number of elements to group = #{number_of_elements_to_group}"
  score_so_far = 0
  x_val_so_far = 0
  score_date_hash_array.each_with_index do |element, index|
    if (index + 1) % number_of_elements_to_group == 0 || element == score_date_hash_array.last #if the next element after this one is the start of a new group || we are on the very last element :
      average_score_for_group = (score_so_far + element[:score]) / number_of_elements_to_group #TODO, this is dumb, it will give a slightly off result for the last group unless the total array number is perfectly divisible by the number of chunks.
      chunked_array << [x_val_so_far, average_score_for_group]
      x_val_so_far += 1
      score_so_far = 0 
    else
      score_so_far += element[:score]
    end
  end #loop

  return chunked_array
end #  chunk_score_date_hash_array_for_chart_plots

#BELOW FUNCTION TESTED AND WORKS - DOES WHAT IT SAYS
def get_history_score_in_day_increments(history_in_exercise_increments)
 # this method will take a history ( array of exercise input's) and return a new array of {score,date} hashes with one hash per date, (all exercises performed in one day summed up to a final figure for that whole day)
 
 # returns an array of {score,date} hashes.
  date_focused_on = history_in_exercise_increments.first.date
  score_history_in_day_increments = [] #initialize an empty array (will become an array of score, date hashes.)
  array_position_of_date_start = 0
  day_score = 0
  array_position_of_date_end = 0
  history_in_exercise_increments.each_with_index do |exercise_input, index|
    if exercise_input == history_in_exercise_increments.last #when upto last element:
      array_position_of_date_end = index
      day_score = get_score_for_exercises_completed(history_in_exercise_increments[array_position_of_date_start..array_position_of_date_end])
      
      #add that day to our list:
      score_history_in_day_increments << {score: day_score, date: date_focused_on}

    elsif exercise_input.date != date_focused_on #when date changes:
      #that was all for the date we were prev focused on.
      array_position_of_date_end = index - 1
      day_score = get_score_for_exercises_completed(history_in_exercise_increments[array_position_of_date_start..array_position_of_date_end])
      
      #add that day to our list:
      score_history_in_day_increments << {score: day_score, date: date_focused_on}
      
      #upto the first of more exercise inputs with a new date so update date being looked at and known start and end positions.
      day_score = 0
      date_focused_on = exercise_input.date
      array_position_of_date_start = index
      array_position_of_date_end = index
    else #otherwise we're haven't yet found the index of the last element for the day we're looking into and we also haven't hit the end of the list yet.

      #do nothing.
    end
  end #loop

  return score_history_in_day_increments
end # get_history_score_in_day_increments

#BELOW METHOD TESTED AND WORKS - DOES WHAT IT SAYS
def get_score_for_exercises_completed(array_of_exercise_inputs) 
  #score as in mark or grade, a simple number, calculated from the sum of the products of the weight and reps of each exercise input so as to more easily compare performance over time
  
  #don't have to worry about date in this method, just give the score for all the exercise inputs passed through. (it is the responsibility of the calling function to only pass through exercise inputs from a particular day if it is after a score for that day.)
  score = 0;
  array_of_exercise_inputs.each do |exercise_input|
    score += ( exercise_input.completed_reps * exercise_input.weight )
    score += exercise_input.duration 
    
  end #loop
  score = score / score_scaling_coefficient
  return score
end  # get_score_for_exercises_completed
