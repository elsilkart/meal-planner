require './spec/spec_helper.rb'

# Testing environment for MealItem class
module MealPlan
  describe MealItem do
    let(:product) { Product.new('test', 2, 4, 3) }
    let(:amount) { 65 }
    let(:item) { described_class.new(product, amount) }

    context 'nutrition (in grams)' do
      it 'returns amount of calories' do
        expect(item.calories).to eq(((2 + 4) * 4 + 3 * 9) * 0.65)
      end

      it 'returns amount of carbs' do
        expect(item.carbs).to eq(2 * 0.65)
      end

      it 'returns amount of protein' do
        expect(item.protein).to eq(4 * 0.65)
      end

      it 'returns amount of fat' do
        expect(item.fat).to eq((3 * 0.65).round(2))
      end
    end
  end
end
