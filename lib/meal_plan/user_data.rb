require_relative './authentication_error.rb'
require 'psych'

module MealPlan
  # Class for storing users
  class UserData
    @users = {}

    def self.add_user(user)
      @users[user.username] = user
    end

    def self.remove_user(username)
      @users.delete(username)
    end

    def self.search(username)
      @users.key?(username)
    end

    def self.correct_password?(username, password)
      @users[username].password == password
    end

    def self.authenticate(username, password)
      raise MealPlan::AuthenticationError, 'User not found' unless
             search(username)

      unless correct_password?(username, password)
        raise MealPlan::AuthenticationError, 'Invalid username or password.'
      end
      @users[username]
    end

    def self.valid_length?(username)
      # length test (1...20)
      size = username.size
      size > 0 && size < 21
    end

    def self.invalid_symbols?(username)
      # symbol test (only alphanumeric symbols)
      (username =~ /\A[[:alnum:]]+\z/) != 0
    end

    def self.unique_username?(username)
      # unique username test
      !search(username)
    end

    def self.save
      File.open('user_data.yml', 'w') { |file| file.write(Psych.dump(@users)) }
    end

    def self.load
      file_name = 'user_data.yml'
      @users = Psych.load(File.open(file_name, 'r')) if File.exist?(file_name)
    end
  end
end
