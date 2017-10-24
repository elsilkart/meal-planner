require './spec/spec_helper.rb'

# Test environment for Meal class
module MealPlan
  describe Meal do
    let(:meal_name) { 'Tuna' }
    let(:meal) { described_class.new(meal_name) }
    let(:product) { Product.new('egg', 2, 8, 6) }
    let(:amount) { 100 }

    context 'on creation' do
      it 'has has correct name' do
        expect(meal.name).to eq(meal_name)
      end

      it 'has no products' do
        expect(meal.products).to eq(0)
      end
    end

    context 'modifying products' do
      it 'can have products' do
        meal.add_product(product, amount)
        expect(meal.products).to eq(1)
      end

      it 'can have products removed' do
        meal.add_product(product, amount)
        meal.remove_product(product.name)
        expect(meal.products).to eq(0)
      end

      it 'can have all products cleared at once' do
        5.times do |index|
          meal.add_product(Product.new("egg#{index}", 1, 1, 1), amount)
        end
        meal.clear
        expect(meal.products).to eq(0)
      end
    end

    context 'nutrition' do
      it 'calculates total calories in meal' do
        meal.add_product(product, amount)
        expect(meal.calories).to eq((2 + 8) * 4 + 6 * 9)
      end
    end
  end
end
