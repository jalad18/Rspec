class User < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true
    validates :password, presence: true
    validates :phone, presence: true, numericality: { only_integer: true }, length: { is: 10 }
end
  