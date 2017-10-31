require_relative 'user_data'
require_relative 'username_error'
require_relative 'plan'

module MealPlan
  # Class to hold user data
  class User
    @meal_plan = nil
    attr_reader :username, :password
    def initialize(username, password)
      validate_username(username)
      @username = username
      @password = password
    end

    def create_meal_plan(days)
      @meal_plan = Plan.new(days)
    end

    def validate_username(username)
      if !UserData.valid_length?(username)
        raise UsernameError,
              'Username length must be between 1 and 20 characters.'
      elsif UserData.invalid_symbols?(username)
        raise UsernameError, 'Symbols must be alphanumeric.'
      elsif !UserData.unique_username?(username)
        raise UsernameError, 'Username is already taken.'
      end
    end
  end
end
