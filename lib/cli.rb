require_relative 'meal_plan/user_data'
require_relative 'meal_plan/user.rb'
require_relative 'meal_plan/username_error.rb'
require_relative 'meal_plan/authentication_error.rb'
require_relative 'meal_plan/day_amount_error'

# Command line interface class for Meal Plan application
class CLI
  DATA_FILE = 'user_data.yml'
  @current_user = nil
  @input = nil

  # Starting method of CLI
  def self.start
    MealPlan::UserData.load(DATA_FILE)
    greeting
    menu_main
    run_start
  end

  class << self

    private
    # shows menu options
    def menu_main
      puts ''
      puts '**************** User Menu ********************'
      puts '1 - Show this menu'
      puts '2 - Log in to an existing user'
      puts '3 - Create new user'
      puts '0 - Exit program'
      puts '***********************************************'
      puts ''
    end

    # shows menu options for logged in users
    def menu_logged_on
      puts ''
      puts '**************** User Menu ********************'
      puts '1 - Show this menu'
      puts '2 - View Meal Plan'
      puts '3 - Create new Meal Plan'
      puts '4 - Edit Meal Plan'
      puts '0 - Log out'
      puts '***********************************************'
      puts ''
    end

    def greeting
      puts 'Welcome to meal planner.'
    end

    # main cli loop
    def run_start
      # Load user data
      loop do
        user_input
        case @input
        when '1'
          # show menu options
          menu_main

        when '2'
          # login
          result = login_prompt
          login(result[0], result[1])
          unless @current_user.nil?
            puts "Logged in as #{result[0]}."
            run_user_session
            menu_main
          end

        when '3'
          # create new user
          result = create_user_prompt
          create_user(result[0], result[1])
          unless @current_user.nil?
            puts "User #{result[0]} created successfully."
            run_user_session
            menu_main
          end

        when '0'
          # exit program
          # Save user data
          puts 'Bye'
          on_exit
          break

        else
          puts "Unknown command #{@input}. Please review valid commands."
          menu_main
        end
      end
    end

    # loop for logged in user
    def run_user_session
      menu_logged_on
      loop do
        user_input
        case @input
        when '1'
          # show menu options
          menu_logged_on

        when '2'
          # View Meal Plan
          puts 'Not implemented yet'

        when '3'
          # Create new Meal Plan
          # prompt for days
          days = prompt_day_amount
          begin
            @current_user.create_meal_plan(days)
            puts 'New Meal Plan Created'
          rescue MealPlan::DayAmountError => error
            puts error.message
          end

        when '4'
          # edit meal plan
          puts 'Not implemented yet'

        when '0'
          # log out
          puts "User #{@current_user.username} logged out"
          logout
          # returns to main loop
          break

        else
          puts "Unknown command #{@input}. Please review valid commands."
          menu_logged_on
        end
      end
    end

    # get user input
    def user_input
      print 'Enter command:'
      @input = gets.strip
    end

    # prompt for username and password
    def login_prompt
      print 'Enter username:'
      username = gets.strip
      print 'Enter password:'
      password = gets.strip
      [username, password]
    end

    # handle user login
    def login(username, password)
      @current_user = MealPlan::UserData.authenticate(username, password)
    rescue MealPlan::AuthenticationError => error
      puts error.message
    end

    def logout
      @current_user = nil
    end

    # prompt for username and password
    # could be merged with login_prompt
    def create_user_prompt
      print 'Username for new user:'
      username = gets.strip
      print 'Password for new user (optional):'
      password = gets.strip
      [username, password]
    end

    # create a new user
    def create_user(username, password)
      user = MealPlan::User.new(username, password)
      MealPlan::UserData.add_user(user)
      @current_user = user
      # take to logged in user interface
    rescue MealPlan::UsernameError => error
      # inform user about failure
      puts error.message
    end

    def prompt_day_amount
      min = MealPlan::Plan::MIN_DAYS
      max = MealPlan::Plan::MAX_DAYS
      print "Enter amount of days (#{min} to #{max}):"
      gets.chomp
    end

    def on_exit
      File.open(DATA_FILE, 'w') { |file| file.write(MealPlan::UserData.save) }
    end
  end
end

CLI.start
