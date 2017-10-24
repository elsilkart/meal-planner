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

      it 'meals can be removed' do
        meal_day.add_meal(meal)
        meal_day.remove_meal(0)
        expect(meal_day.meals).to eq(0)
      end

      it 'meals can be accessed' do
        meal_day.add_meal(meal)
        meal = meal_day.select_meal(0)
        expect(meal).to be_instance_of(Meal)
      end
    end

    context 'changing meals' do
      it 'can be cleared all at once' do
        5.times { meal_day.add_meal(meal) }
        meal_day.clear
        expect(meal_day.meals).to eq(0)
      end

      it 'can switch two meals' do
        meal_day.add_meal(Meal.new('Tuna'))
        meal_day.add_meal(Meal.new('Salmon'))
        meal_day.switch_meals(0, 1)
        expect(meal_day.select_meal(0).name).to eq('Salmon')
      end
    end

    context 'nutrition' do
      it 'counts calories correctly' do
        meal.add_product(product, 100)
        meal_day.add_meal(meal)
        expect(meal_day.calories).to eq((12 + 7) * 4 + 4 * 9)
      end
    end
  end
end
