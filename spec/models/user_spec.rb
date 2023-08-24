require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user.name = nil
    expect(user).not_to be_valid
  end

  it 'is valid with a name' do
    user.name = 'jazzy B'
    expect(user).to be_valid 
  end

  it 'is not valid without an email' do
    user.email = nil
    expect(user).not_to be_valid
  end

  it 'is a valid email' do
    user.email = 'jazzyb@email.com'
  end

  it 'is not valid without a password' do
    user.password = nil
    expect(user).not_to be_valid
  end

  it 'is not valid without a phone' do
    user.phone = nil
    expect(user).not_to be_valid
  end

  it 'is a valid phone number' do
    user.phone = 9898989898
  end

  it 'is not valid with a non-numeric phone' do
    user.phone = 'abc'
    expect(user).not_to be_valid
  end

  it 'is not valid with a phone of length other than 10' do
    user.phone = '123456789'
    expect(user).not_to be_valid
  end
end
