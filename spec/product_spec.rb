require './spec/spec_helper.rb'

# Test environment for Product class
module MealPlan
  describe Product do
    let(:carbs) { 4 }
    let(:protein) { 6 }
    let(:fat) { 2 }
    let(:name) { 'food' }
    let(:product) { described_class.new(name, carbs, protein, fat) }

    context 'on creation' do
      it 'has correct amount of calories' do
        expect(product.calories).to eq(4 * (carbs + protein) + 9 * fat)
      end

      it 'has correct name' do
        expect(product.name).to eq(name)
      end
    end
  end
end
