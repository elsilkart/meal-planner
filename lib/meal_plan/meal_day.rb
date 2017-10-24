module MealPlan
  # a class for meal plan day schedule
  class MealDay
    def initialize
      @meals = []
    end

    def add_meal(meal)
      @meals << meal
    end

    def remove_meal(index)
      @meals.delete_at(index)
    end

    def meals
      @meals.size
    end

    def clear
      @meals.clear
    end

    def switch_meals(first, second)
      @meals[first], @meals[second] = @meals[second], @meals[first]
    end

    def select_meal(index)
      @meals.fetch(index)
    end

    def calories
      calories = 0
      @meals.each { |meal| calories += meal.calories }
      calories
    end
  end
end
