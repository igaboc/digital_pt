#disclaimer?
require_relative 'menu'
require_relative 'user'
require_relative 'exercise_input'
require_relative 'exercise'
require_relative 'pt'
require_relative 'graph_renderer'
require_relative 'presentationdata.rb'
require 'terminal-table'

PATH_TO_SOUNDBYTES = './'

def generate_exercises()
  deadlifts = Exercise.New() #TODO:  determine what parameters will be for  Exercise before generating some.
  pt.add_exercise(deadlifts)
end

def print_welcome_message
    system 'clear'
    puts '                 Welcome to:               '
    puts ' '
    puts '============================================'
    puts '                 DIGITAL PT                 '
    puts '============================================'
end

def add_user (user)
    users << user
end

def get_user(username)
  #go through @users and return the one with this username.
  users.each do |user|
    if user.name == username
      return user
    end
  return nil
  end
end

def get_user_from_login
  username_entered = display_menu_to_get_username
  user_object = get_user(username_entered)
  while user_object == nil
    #ask again
    username_entered = display_menu_to_get_username
    user_object = get_user(username_entered)
  end
  
  password_entered = display_menu_to_get_password
  while user_object.password != password_entered
    #ask again
    password_entered = display_menu_to_get_password
  end

  return user_object
end


def save_program_state_to_file
  # TODO: find out how to save data to a text file.
end

def exit_program
  puts "Exiting..."
  exit(0)
end




def print_users_profile_in_table(user, pt)
   
    rows = []
    rows << ["Username:",user.username]
    rows << ["First Name:",user.first_name]
    rows << ["Last Name:",user.last_name]
    rows << ["Gender:",user.gender]
    rows << ["Date of Birth:",user.date_of_birth]
    rows << ["Current Weight:",user.weight]
    rows << ["Desired Weight:",user.goal_weight]
    rows << ["Daily Calories:",pt.daily_amount_of_calories(user.gender, user.weight, 68, (Date.today.year - user.date_of_birth.year)).round(0)]

    table = Terminal::Table.new :headings => [{:value => 'Info', :alignment => :center}, {:value => 'You', :alignment => :center}],  :rows => rows
    table.align_column(0, :right)
    table.align_column(1, :left)
    puts table
    puts ''
    puts ''
end

def display_user_profile_screen(user, pt)
    loop do
        system 'clear'
        print_users_profile_in_table(user, pt)
        response = get_response_from_profile_menu
        case response
        when '1' #update weight
            user.weight = ask_user_for_new_bodyweight(user.weight)
        when 'x' #exit
            break
        end
    end
end


def welcome_user_menu(user, pt)
    loop do 
        response = response_from_main_menu(user) #from menu.rb  '
        case response
        when '1' #1. I want to workout!
            pt.begin_workout(user)
        when '2' #2. View my progress'
             display_progress_chart_screen(user)
        when '3' # 3. View my profile' 
            display_user_profile_screen(user, pt)
        when 'x'#'x. Logout'
         break
        end 
    end
end

def display_progress_chart_screen(user)
    system 'clear'
    #display their historical graph now
    #check that user actually has workout history to graph, if they don't return nil
    if user.workout_history.nil? || user.workout_history.empty?
        puts "<you do not yet have any workout history> \n\n"
    else
        render_user_history_graph_with_defaults(user)
    end
    loop do
        response = response_from_graph_menu 
        case response
        when '1'  #  '1. Change date range for progress chart
            if user.workout_history.nil? || user.workout_history.empty?
                puts "<you do not yet have any workout history> \n\n"
            else
                array_of_dates = get_start_and_end_dates_for_graph
                unless array_of_dates.nil?
                    render_user_history_graph_with_custom_dates(user,array_of_dates[0],array_of_dates[1])
                end
            end
        when 'x'# 'x. Go back to main menu'
            break
        end
    end
end

def present_initial_menu(userlist, pt)
  loop do
      response = main_menu #from menu.rb THIS CLEARS THE SCREEN
      case response
      when '1'
          new_user = create_user_from_entered_details # from menu.rb
          unless new_user.nil?
              userlist << new_user
          end
      when '2'
            user = verify_login_credentials(userlist)
            if  user.nil?
                puts "login failed"
                sleep 2
            else
                welcome_user_menu(user, pt)
            end
                
      when 'x'
          puts 'See you next time!'
          exit(0) #only way to exit loop
      end
  end #loop
end


#below is main class code:

#initialise program:
pt = PT.new(PATH_TO_SOUNDBYTES)
list_of_users = []
user = User.new
list_of_users << user
generate_dummy_data_for_presentation(pt, user)
#the above line is just for the classroom project presentation
#this is where data previously saved to a text file would be read to restore the programs state (if it were implemented)

#Just begun  so print welcome message:
print_welcome_message
sleep 2

#pass control over to the 'main menu' to wait for input from user (passing it the pt object and the list_of_users)
present_initial_menu(list_of_users, pt)
