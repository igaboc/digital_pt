require 'date'
require 'pry'

# def prompt_user_for_login_details

def get_response_from_profile_menu
    #the menu that allows the user to 1, change/update their recorded weight, change their goals, or x back out.
    loop do
        puts '1. Update current weight'
        puts 'x. Go back to main menu'
        choice = gets.strip
        choice_is_valid = choice == '1' || choice == 'x'
        if choice_is_valid
            return choice
        else 
            puts "'Please enter '1' or 'x':"
            sleep 1 
        end
    end
end

#BELOW TESTED AND WORKS
def main_menu
    loop do 
        system 'clear'
        puts '1. Create User'
        puts '2. Sign In'
        puts 'x. Quit Digital PT'

        choice = gets.strip
        choice_is_valid = choice == '1' || choice == '2' || choice == 'x'
        if choice_is_valid
            return choice
        else 
            puts 'Invalid, try again'
            sleep 1 
        end
    end
end

#BELOW TESTED AND WORKS
def response_from_main_menu(user)
    loop do
        system 'clear'
        puts "Welcome #{user.first_name}, what would you like to do?"
        puts ' '
        puts '1. I want to workout!'
        puts '2. View my progress'
        puts '3. View my profile'
        puts 'x. Logout'
        
        choice = gets.strip

        case choice
        when '1'
            return '1'
        when '2'
            return '2'
        when '3'
            return '3'
        when 'x'
            return 'x'
        else
            puts 'Please try again'
            sleep 1
        end
    end
end


def verify_login_credentials(userlist)
    # return userlist[0]  #placeholder until we implement this fully

    username = nil
    user_object_matching_username = nil
    password = nil

    # username loop
    loop do
        print 'Enter your username (or x to cancel):'
        username = gets.strip
        if username.length > 2 #valid usernames have a length at least 3 chars, ensured by the checking upon registration
            userlist.each do |user|
                if user.username == username
                    user_object_matching_username = user
                    break #breaks th userlist.each loop
                end
            end
            if !user_object_matching_username.nil? #if the userlist.each loop found a username match then
                break #out of the whole username loop
            end
        elsif username == 'x'
            return nil
        end
        puts 'Please try again:'
    end

    # password loop
    loop do
        print 'Enter your password (or x to cancel):'
        password = gets.strip
        if password.length > 2  #valid passwords have a length at least 3 chars, ensured by the checking upon registration
            if user_object_matching_username.password == password
                return user_object_matching_username
            end
        elsif password == 'x'
            return nil
        end
        puts 'Please try again:'
    end
end

#searches the array of users provided by userlist for a user with the username provided by username
def find_user(userlist, username)
    found_user = nil
    userlist.each do |user|
        if user.username == username
          found_user = user
          break
        end 
    end
    return found_user
end 

#BELOW TESTED AND WORKS
def create_user_from_entered_details
    username = nil
    password = nil
    first_name = nil
    last_name = nil
    date_of_birth = nil
    gender = nil
    weight = nil
    goal_weight = nil
    disclaimer = nil
    
    loop do
        system 'clear'
        puts '              Creating User              '
        puts ' '
        puts 'Please press x if you would like to cancel anytime'
        print 'Enter a username (must be at least 3 characters):'
        username = gets.strip
        if username.length > 2 
            break
        elsif username == 'x'
            return nil
        end
        puts 'Please try again:'
    end

    loop do 
        print 'Enter a password:'
        password = gets.strip 
        if password.length > 2
            break
        elsif password == 'x'
            return nil
        end
        puts 'Please try again:'
    end

    loop do
        print 'Enter your first name:'
        first_name = gets.strip
        if first_name.is_a?(String) && first_name.length > 0
            break
         elsif first_name == 'x'
            return nil
            puts 'Please try again'
        end
    end


    loop do
        print 'Enter your last name:'
        last_name = gets.strip
        if last_name.is_a?(String) && last_name.length > 0
            break
         elsif last_name == 'x'
            return nil
        end
        puts 'Please try again'
    end

    loop do
        print 'Enter your date of birth (YYYY.MM.DD):'
        date_of_birth = gets.strip
        if date_of_birth == 'x'
            return nil
        else 
            date_of_birth = parse_date_or_nil(date_of_birth)
        end 
        if date_of_birth.is_a? (Date)
            break
        end
        puts 'Please try again' 
    end 

    loop do
        print 'Are you male or female?:'
        gender = gets.strip 
        if gender == 'male'
            break
        elsif gender == 'female'
            break
        elsif gender == 'x'
            return nil
        end
        puts 'Please try again'
    end

    loop do 
        print 'What is your current weight:'
        weight = gets.strip.to_i
        if weight > 1
            break
         elsif weight == 'x'
            return nil
        end
        system 'Please try again'
    end

     loop do 
        print 'What is your desired weight:'
        goal_weight = gets.strip.to_i
        if goal_weight > 1 
            break
         elsif goal_weight == 'x'
            return nil
        end
        puts 'Please try again'
    end

    print 'Please accept the following disclaimer:'
    sleep 2
    print 'This disclaimer does not cover misuse, accident, lightning, flood, tornado, tsunami, volcanic eruption, earthquake, hurricanes and other Acts of God, neglect, damage from improper reading, incorrect line voltage, improper or unauthorized use, broken antenna or marred cabinet, missing or altered serial numbers, removal of tag, electromagnetic radiation from nuclear blasts, sonic boom, crash, ship sinking or taking on water, motor vehicle crashing, dropping the item, falling rocks, leaky roof, broken glass, mud slides, forest fire, or projectile (which can include, but not be limited to, arrows, bullets, shot, BB’s, paintball, shrapnel, lasers, napalm, torpedoes, or emissions of X-rays, Alpha, Beta and Gamma rays, knives, stones, etc.).
    No license, express or implied, by estoppel or otherwise, to any Intellectual property rights are granted herein.
    Cute Fuzzy Bunny (CFB) disclaims all liability, including liability for infringement of any proprietary rights, relating to use of information in this specification. CFB does not warrant or represent that such use will not infringe such rights. In fact, that’s a very strong possibility.
    Nothing in this document constitutes a guarantee, warranty, or license, express or implied. CFB disclaims all liability for all such guaranties, warranties, and licenses, including but not limited to: fitness for a particular purpose; merchantability; non-infringement of intellectual property or other rights of any third party or of CFB; indemnity; and all others. The reader is advised that third parties may have intellectual property rights that may be relevant to this document and the technologies discussed herein, and is advised to seek the advice of competent legal counsel, without obligation to CFB. In other words, get your own #$^%#$ lawyer before you hurt yourself.
    These materials are provided by CFB as a service to his friends and/or customers and may be used for informational purposes only. Single copies may be distributed at will since it is unlikely that CFB created this material independently as he has no creative skill.
    TRADEMARK INFORMATION: CFB and the CFB logo are registered trademarks of CFB. 
    CFBs trademarks may be used publicly with permission only from CFB. Fair use of CFB trademarks in advertising and promotion of CFB products requires proper acknowledgment. If you use CFB’s trademarks without CFB’s express approval, he will get really pissed off.
    *All other brands and names are property of their respective owners. 
    OWNERSHIP OF MATERIALS: Materials are copyrighted and are protected by worldwide copyright laws and treaty provisions. They may not be copied, reproduced, modified, published, uploaded, posted, transmitted, or distributed in any way, without CFB prior written permission, which is freely granted as long as you take CFB’s name off in some lame attempt to either hide the materials origin or in the hilarious belief that the receiver of this material will think that you created it on your own, or somehow will think you more clever and intelligent that you really are. Except as expressly provided herein, CFB does not grant any express or implied right to you under any patents, copyrights, trademarks, or trade secret information. Other rights may be granted to you by CFB in writing or incorporated elsewhere in the Materials. DISCLAIMER: THE MATERIALS ARE PROVIDED "AS IS" WITHOUT ANY EXPRESS OR IMPLIED WARRANTY OF ANY KIND INCLUDING WARRANTIES OF MERCHANTABILITY, NONINFRINGEMENT OF INTELLECTUAL PROPERTY, OR FITNESS FOR ANY PARTICULAR PURPOSE. IN NO EVENT SHALL CFB OR HIS SUPPLIERS BE LIABLE FOR ANY DAMAGES WHATSOEVER (INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF PROFITS, BUSINESS INTERRUPTION, LOSS OF INFORMATION) ARISING OUT OF THE USE OF OR INABILITY TO USE THE MATERIALS, EVEN IF CFB HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. BECAUSE SOME JURISDICTIONS PROHIBIT THE EXCLUSION OR LIMITATION OF LIABILITY FOR CONSEQUENTIAL OR INCIDENTAL DAMAGES, THE ABOVE LIMITATION MAY NOT APPLY TO YOU. CFB further does not warrant the accuracy or completeness of the information, text, graphics, links or other items contained within these materials. CFB may make changes to these materials, or to the products described therein, at any time without notice. CFB makes no commitment to update the Materials. In other words, if you screw it up, you’re on your own.
    U.S. GOVERNMENT RESTRICTED RIGHTS: The Materials are provided with "RESTRICTED RIGHTS." Use, duplication, or disclosure by the Government is subject to restrictions as set forth in FAR52.227-14 and DFAR252.227-7013 et seq. or its successor. Use of the Materials by the Government constitutes acknowledgment of CFBs proprietary rights in them and excludes him from ever having to pay income taxes ever again, along with assigning the rights of King of Rhode Island to CFB to use as he sees fit.
    Copyright © 1995-99 CFB. All rights reserved.'

    loop do
        puts ' '
        puts 'Do you accept or decline? (write \'accept\' or \'decline\'):'
        disclaimer = gets.strip.downcase
        if disclaimer == 'accept'
            break
        elsif disclaimer == 'decline'
            break
        elsif disclaimer == 'x'
            return nil
        end
        puts 'Please try again'
    end

    new_user = User.new #(username, password, first_name, last_name, date_of_birth, gender, weight, goal_weight, disclaimer)
    new_user.username = username
    new_user.password = password
    new_user.first_name = first_name 
    new_user.last_name = last_name
    new_user.date_of_birth = date_of_birth
    new_user.gender = gender
    new_user.weight = weight 
    new_user.goal_weight = goal_weight
    new_user.disclaimer = disclaimer

    return new_user
end

#BELOW TESTED AND WORKS
def response_from_graph_menu
    puts '1. Change date range for progress chart'
    puts 'x. Go back to main menu'
    loop do
        choice = gets.strip
        they_entered_a_valid_response = choice == '1' || choice == 'x'
        unless they_entered_a_valid_response
            #code here willrun if their response is invalid
            #do nothing, rely on loop to ask them again.
            puts "try again"
        else
            #their response was valid
            return choice
        end
    end  # loop
end #  response_from_graph_menu

#BELOW TESTED AND WORKS
#returnss an array of two dates, start and end, otherwise returns nil if user cancelled.
def get_start_and_end_dates_for_graph
    system 'clear'
    start_date = get_start_date_for_graph
    if start_date.nil?
        return nil
    end
    end_date = get_end_date_for_graph
    if end_date.nil?
        return nil
    else
        return [start_date, end_date]
    end
end 

#BELOW TESTED AND WORKS
#this is a helper method to convert a string into either a valid date, or else nil, calling method can handle what it does with nil
def parse_date_or_nil(date_string_to_parse)
    begin
        start_date = Date.parse(date_string_to_parse)
        return start_date
    rescue
        return nil
    end
end

#BELOW TESTED AND WORKS
#asks user to enter a valid date, prompts to retry if invalid, and returns nil if 'x' is entered, otherwise returns a Date object
def get_start_date_for_graph
    start_date = nil
    loop do
        puts 'What would you like the starting date to be (YYYY.MM.DD)?'
        puts 'Enter x to cancel'
        start_date = gets.strip
        if start_date == 'x'
            return nil
        else
            start_date = parse_date_or_nil(start_date)
        end
        if start_date.is_a? (Date)
            return start_date
        end
        puts 'Please try again'
    end
end 

#BELOW TESTED AND WORKS
#asks user to enter a valid date, prompts to retry if invalid, and returns nil if 'x' is entered, otherwise returns a Date object
def get_end_date_for_graph
    end_date = nil
    loop do
        puts 'What would you like the ending date to be (YYYY.MM.DD)?'
        puts 'Enter x to cancel'
        end_date = gets.strip
        if end_date == 'x'
            return nil
        else
            end_date = parse_date_or_nil(end_date)
        end
        
        if end_date.is_a? (Date)
            return end_date
        end
        puts 'Please try again'
    end
end

#BELOW TESTED AND WORKS
#asks user if they want to update their bodyweight, if yes asks for new weight and returns that value, if no returns original weight that was passed to it
def ask_user_for_new_bodyweight(user_weight)
    puts "Your current weight is #{user_weight}"
    puts 'Would you like to change this? (yes/no)'
    loop do
        input = gets.strip
        if input == 'yes'
            puts "What is your adjusted current weight?"
            input = gets.strip.to_i
            return input
        elsif input == 'no'
            puts 'No worries'
            return user_weight
        end 
        puts "Please enter 'yes' or 'no':"
    end #loop
end  #  ask_user_for_new_bodyweight
