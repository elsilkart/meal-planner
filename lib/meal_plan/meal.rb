$LOAD_PATH.unshift File.dirname(__FILE__)
require 'meal_item.rb'

module MealPlan
  # Meal describes what is being eaten
  # and what products are being used
  class Meal
    attr_reader :name

    def initialize(name)
      @name = name
      @meal_items = {}
    end

    def add_product(product, amount)
      @meal_items[product.name] = (MealItem.new product, amount)
    end

    def remove_product(product_name)
      @meal_items.delete(product_name)
    end

    def clear
      @meal_items.clear
    end

    def products
      @meal_items.size
    end

    def calories
      calories = 0
      @meal_items.each_value { |item| calories += item.calories }
      calories
    end
  end
end
