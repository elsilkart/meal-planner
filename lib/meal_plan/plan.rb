$LOAD_PATH.unshift File.dirname(__FILE__)
require 'meal_day.rb'
require 'day_amount_error'

module MealPlan
  # Main class of meal plan project
  class Plan
    MAX_DAYS = 30
    MIN_DAYS = 1

    def initialize(days)
      @days = []
      if days >= MIN_DAYS && days <= MAX_DAYS
        days.times { @days << MealDay.new }
      else
        raise DayAmountError,
              "Day amount must be between #{MIN_DAYS} and #{MAX_DAYS}."
      end
    end

    def no_of_days
      @days.size
    end

    def no_of_days=(days)
      if days >= MIN_DAYS && days <= MAX_DAYS
        @days.clear
        days.times { @days << MealDay.new }
      else
        raise DayAmountError,
              "Day amount must be between #{MIN_DAYS} and #{MAX_DAYS}."
      end
    end

    def select_day(index)
      @days.fetch(index)
    end

    def clear_all_days
      each(&:clear)
    end

    def each(&block)
      @days.each(&block)
    end

    def switch_days(first, second)
      @days[first], @days[second] = @days[second], @days[first]
    end

    def avg_meals
      meals = 0
      each { |day| meals += day.meals }
      meals.to_f / @days.size
    end

    def avg_calories
      calories = 0
      each { |day| calories += day.calories }
      (calories / @days.size).round(1)
    end
  end
end
