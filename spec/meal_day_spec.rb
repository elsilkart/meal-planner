require './spec/spec_helper.rb'

# Testing environment for MealDay class
module MealPlan
  describe MealDay do
    let(:meal_day) { described_class.new }
    let(:meal) { Meal.new('test_meal') }
    let(:product) { Product.new('test_product', 12, 7, 4) }

    context 'on creation' do
      it 'there are no meals' do
        expect(meal_day.meals).to eq(0)
      end

      it 'can have meals' do
        meal_day.add_meal(meal)
        expect(meal_day.meals).to eq(1)
      end

      it 'can access meals' do
        meal_day.add_meal(meal)
        expect(meal_day.select_meal(0)).to be(meal)
      end

      it 'meals can be removed' do
        meal_day.add_meal(meal)
        meal_day.remove_meal(0)
        expect(meal_day.meals).to eq(0)
      end
    end

    context 'changing meals' do
      it 'can be cleared all at once' do
        5.times { meal_day.add_meal(meal) }
        meal_day.clear
        expect(meal_day.meals).to be_zero
      end

      it 'can switch two meals' do
        first = Meal.new('Tuna')
        second = Meal.new('Salmon')
        meal_day.add_meal(first)
        meal_day.add_meal(second)
        expect(meal_day.switch_meals(0, 1)).to switch_items(first, second)
      end
    end

    context 'nutrition' do
      it 'counts calories correctly' do
        amount = 100
        meal.add_product(product, amount)
        meal_day.add_meal(meal)
        expect(meal_day.calories).to have_calories(product.carbs, 
          product.protein, product.fat, amount)
      end
    end
  end
end
