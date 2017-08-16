# This class contains the attributes of one exercise
# for example, the gym exercise known as the Bench Press where a person
# lies on their back on a bench and pushes a barbell vertically away from their chest 
# may have the following attribs:

# name = "Bench Press"
# session_type = "Chest"
# compound = true
# bare_minimum_weight = 5
# max_weight_increment = 10
# weight_increment_factor = 0.824938329 ---based on Chris' formulas
# optimal_rep = {"musclebuild": 4, "generalfitness": 10}
# set_count = {"musclebuild": 4, "generalfitness": 3}

class Exercise

    attr_accessor :name, :session_type #String
    attr_accessor :compound #Boolean
    attr_accessor :bare_minimum_weight, :max_weight_increment #Integer
    attr_accessor :weight_increment_factor #Float
    attr_accessor :optimal_rep, :set_count #{hashkey: hashvalue, hashkey: hashvalue, ...}  --a hash

    def initialize(name, session_type, compound, bare_minimum_weight, max_weight_increment, weight_increment_factor, optimal_rep, set_count)
        @name = name
        @session_type = session_type
        @compound = compound
        @bare_minimum_weight = bare_minimum_weight
        @max_weight_increment = max_weight_increment
        @weight_increment_factor = weight_increment_factor
        @set_count = set_count
    end
end