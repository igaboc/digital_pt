# This class represents a single workout record, in heavy weights this would be a set
class ExerciseInput
   
    attr_accessor :weight, :completed_reps, :exercise_performed, :duration, :date, :session_number, :session_type

    def initialize(weight, completed_reps, exercise_performed, duration, date, session_number, session_type)
        @weight = weight
        @completed_reps = completed_reps
        @exercise_performed = exercise_performed
        @duration = duration
        @date = date
        @session_number = session_number
        @session_type = session_type
    end
end