module MealPlan
  # Product describes a single product
  # and what nutrients it contains
  class Product
    attr_reader :name, :carbs, :protein, :fat

    def initialize(name, carbs, protein, fat)
      @name = name
      @carbs = carbs
      @protein = protein
      @fat = fat
    end

    def calories
      4 * (carbs + protein) + 9 * fat
    end
  end
end
