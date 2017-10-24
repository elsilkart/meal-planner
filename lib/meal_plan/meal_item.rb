module MealPlan
  # A class that combines products and their amounts
  class MealItem
    def initialize(product, amount)
      @product = product
      @amount = amount
    end

    def calories
      (@product.calories * @amount).to_f / 100
    end

    def carbs
      (@product.carbs * @amount).to_f / 100
    end

    def protein
      (@product.protein * @amount).to_f / 100
    end

    def fat
      (@product.fat * @amount).to_f / 100
    end
  end
end
