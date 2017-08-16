# represents a real human user.

class User
    attr_accessor :username, :password, :first_name, :last_name, :gender, :body_type, :goal, :disclaimer #string
    attr_accessor :date_of_birth #date
    attr_accessor :goal_weight, :weight #integer, 
    attr_accessor :workout_history #[exercise_input]
    
    # def initialize(username, password, first_name, last_name, gender, body_type, goal, date_of_birth, goal_weight, weight, workout_history)
    def initialize
        @workout_history = []
        # @workout_history = ExerciseHistory.new() #because, if we're initializing a NEW user. they HAVENO HISTORY
        # @workout_history = workout_history
        # @first_name = first_name
    end
    
    def add_completed_session(exercise_input)
        @workout_history << exercise_input
    end
    
end # class User
