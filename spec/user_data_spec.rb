require_relative 'spec_helper'

# Test environment for UserData class
module MealPlan
  describe UserData do
    let(:data) { described_class }

    context 'username validation' do
      it 'fails when length is more than 20' do
        long_name = 'aaaaaaaaaaaaaaaaaaaaa'
        expect(data.valid_length?(long_name)).to be false
      end

      it 'is correct when username length is exactly 20' do
        long_correct = 'aaaaaaaaaaaaaaaaaaaa'
        expect(data.valid_length?(long_correct)).to be true
      end

      it 'fails when length is less than 1' do
        expect(data.valid_length?('')).to be false
      end

      it 'is correct when length is atleast 1' do
        expect(data.valid_length?('1')).to be true
      end

      it 'fails when username has non alphanumeric symbols' do
        expect(data.valid_symbols?('@')).to be false
      end

      it 'fails when username is not unique' do
        user = User.new('example', '')
        data.add_user(user)
        expect(data.unique_username?('example')).to be false
        data.remove_user('example')
      end
    end

    context 'password validation' do
      it 'fails when password do not match' do
        user = User.new('example', 'pw')
        data.add_user(user)
        expect(data.correct_password?('example', '')).to be false
        data.remove_user('example')
      end

      it 'is correct when passwords match' do
        user = User.new('example', 'pw')
        data.add_user(user)
        expect(data.correct_password?('example', 'pw')).to be true
        data.remove_user('example')
      end
    end

    context 'account authentication' do
      it 'fails if user with given username does not exist' do
        error_message = 'User not found'
        expect { data.authenticate('???', '') }
          .to raise_error(AuthenticationError, error_message)
      end

      it 'fails when given password does not match user\'s password' do
        data.add_user(User.new('example', 'pw'))
        error_message = 'Invalid username or password.'
        expect { data.authenticate('example', '') }
          .to raise_error(AuthenticationError, error_message)
        data.remove_user('example')
      end

      it 'is successful when given username and password are correct' do
        user = User.new('example', 'pw')
        data.add_user(user)
        expect(data.authenticate('example', 'pw')).to equal(user)
        data.remove_user('example')
      end
    end

    context 'managing data' do
      it 'successfully removes user' do
        user = User.new('example', '')
        data.add_user(user)
        data.remove_user('example')
        expect(data.search('example')).to be false
      end
    end

    context 'data loading and saving' do
      it 'saves results correctly' do
        data.clear
        3.times { |index| data.add_user(User.new("u#{index}", '')) }
        file = File.open('spec/expected_users.yml')
        expect(data.save).to eql(file.read)
      end

      it 'loads files correctly' do
        data.clear
        data.load('spec/expected_users.yml')
        file = File.open('spec/expected_users.yml', 'r')
        expect(data.save).to eql(file.read)
      end

      it 'will not load non existing files' do
        data.clear
        data.load('not_exist')
        expect(data.size).to be_zero
      end
    end
  end
end
