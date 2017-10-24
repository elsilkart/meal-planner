require './spec/spec_helper.rb'

# Test environment for Plan class
module MealPlan
  describe Plan do
    let(:day_amount) { 7 }
    let(:empty_plan) { described_class.new(day_amount) }
    let(:meal) { Meal.new('Tuna') }
    let(:first_product) { Product.new('tuna', 0, 11, 0) }
    let(:second_product) { Product.new('tuna', 0, 25.51, 0.8) }

    context 'on creation' do
      it 'will have given amount of days' do
        expect(empty_plan.no_of_days).to be(day_amount)
      end
    end

    context 'changing number of days' do
      it 'adding days will increase number of days' do
        old_value = empty_plan.no_of_days
        empty_plan.no_of_days += 3
        expect(empty_plan.no_of_days).to eql(old_value + 3)
      end

      it 'removing days will decrease number of days' do
        old_value = empty_plan.no_of_days
        empty_plan.no_of_days -= 3
        expect(empty_plan.no_of_days).to eql(old_value - 3)
      end
    end

    context 'working with days' do
      it 'changes indexes of days without changing objects' do
        day = empty_plan.select_day(1)
        empty_plan.switch_days(1, 4)
        expect(empty_plan.select_day(4)).to equal(day)
      end

      it 'can clear all days' do
        day = empty_plan.select_day(0)
        day.add_meal(meal)
        count = day.meals
        empty_plan.clear_all_days
        expect(day.meals).not_to eq(count)
      end

      it 'average meals per day calculation' do
        empty_plan.no_of_days = 10
        empty_plan.each { |day| day.add_meal(meal) }
        empty_plan.select_day(0).add_meal(meal)
        expect(empty_plan.avg_meals).to eq(11.0 / 10)
      end

      it 'average calories per day calculation' do
        meal.add_product(first_product, 100)
        empty_plan.each { |day| day.add_meal(meal) }
        expect(empty_plan.avg_calories).to eq((11 * 4))
      end

      it 'rounds average calories correctly' do
        meal.add_product(second_product, 100)
        empty_plan.each { |day| day.add_meal(meal) }
        expect(empty_plan.avg_calories).to eq(25.5 * 4 + 0.8 * 9)
      end
    end
  end
end
