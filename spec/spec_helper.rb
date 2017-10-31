require 'timeout'
require 'simplecov'
SimpleCov.start

require './lib/meal_plan/plan.rb'
require './lib/meal_plan/meal_day.rb'
require './lib/meal_plan/meal.rb'
require './lib/meal_plan/meal_item.rb'
require './lib/meal_plan/product.rb'
require './lib/meal_plan/user.rb'
require './lib/meal_plan/user_data.rb'
require './lib/meal_plan/username_error.rb'
require './lib/meal_plan/authentication_error.rb'
require './lib/meal_plan/day_amount_error.rb'
RSpec.configure do |config|
  config.around do |example|
    Timeout.timeout(5, &example)
  end
end
