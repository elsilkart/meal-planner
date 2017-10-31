require_relative 'spec_helper'

# Test environment for user class
module MealPlan
  describe User do
    let(:username) { 'example' }
    let(:password) { 'pw' }
    let(:user) { described_class.new(username, password) }
    let(:data) { UserData }

    context 'creation' do
      it 'username length can\'t be less than 1' do
        message = 'Username length must be between 1 and 20 characters.'
        expect { User.new('', '') }
          .to raise_error(UsernameError, message)
      end

      it 'username length can\'t be above 20' do
        long_name = 'aaaaaaaaaaaaaaaaaaaaa'
        message = 'Username length must be between 1 and 20 characters.'
        expect { described_class.new(long_name, '') }
          .to raise_error(UsernameError, message)
      end

      it 'username must contain alphanumeric characters' do
        message = 'Symbols must be alphanumeric.'
        expect { described_class.new('@', '') }
          .to raise_error(UsernameError, message)
      end

      it 'username must be unique' do
        data.add_user(user)
        message = 'Username is already taken.'
        expect { described_class.new(username, password) }
          .to raise_error(UsernameError, message)
        data.remove_user(username)
      end
    end

    context 'object fields' do
      it 'user password is correct' do
        expect(user.password).to eq(password)
      end

      it 'user name is correct' do
        expect(user.username).to eq(username)
      end
    end

    context 'meal plan' do
      it ' has correct number of days' do
        meal_plan = user.create_meal_plan(14)
        expect(meal_plan.no_of_days).to eq(14)
      end
    end
  end
end
