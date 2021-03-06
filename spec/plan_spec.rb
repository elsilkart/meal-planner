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
        expect { empty_plan.no_of_days += 3 }
          .to change { empty_plan.no_of_days  }.by(3)
      end

      it 'removing days will decrease number of days' do
        expect { empty_plan.no_of_days -= 3 }
          .to change { empty_plan.no_of_days  }.by(-3)
      end

      it 'will fail to change day amount if given amount is below minimum' do
        min = Plan::MIN_DAYS
        max = Plan::MAX_DAYS
        error_message = "Day amount must be between #{min} and #{max}."
        expect { empty_plan.no_of_days = min - 1 }
          .to raise_error(DayAmountError, error_message)
      end

      it 'will fail to change day amount if given amount is above maximum' do
        min = Plan::MIN_DAYS
        max = Plan::MAX_DAYS
        error_message = "Day amount must be between #{min} and #{max}."
        expect { empty_plan.no_of_days = max + 1 }
          .to raise_error(DayAmountError, error_message)
      end

      it 'works when new amount is exact minimum' do
        min = Plan::MIN_DAYS
        empty_plan.no_of_days = min
        expect(empty_plan.no_of_days).to eql(min)
      end

      it 'works when new amount is exact maximum' do
        max = Plan::MAX_DAYS
        empty_plan.no_of_days = max
        expect(empty_plan.no_of_days).to eql(max)
      end
    end

    context 'working with days' do
      it 'changes indexes of days without changing objects' do
        first = empty_plan.select_day(1)
        second = empty_plan.select_day(4)
        expect(empty_plan.switch_days(1, 4)).to switch_items(first, second)
      end

      it 'can clear all days' do
        day = empty_plan.select_day(0)
        day.add_meal(meal)
        empty_plan.clear_all_days
        expect(day.meals).to be_zero
      end

      it 'average meals per day calculation' do
        empty_plan.no_of_days = 10
        empty_plan.each { |day| day.add_meal(meal) }
        empty_plan.select_day(0).add_meal(meal)
        expect(empty_plan.avg_meals).to eq(11.0 / 10)
      end

      it 'average calories per day calculation' do
        amount = 100
        meal.add_product(first_product, amount)
        empty_plan.each { |day| day.add_meal(meal) }
        expect(empty_plan.avg_calories).to have_calories(first_product.carbs,
          first_product.protein, first_product.fat, amount)
      end

      it 'rounds average calories correctly' do
        amount = 100
        meal.add_product(second_product, amount)
        empty_plan.each { |day| day.add_meal(meal) }
        expect(empty_plan.avg_calories).to have_calories(second_product.carbs,
          second_product.protein, second_product.fat, amount)
      end
    end
  end
end
