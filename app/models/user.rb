class User < ApplicationRecord
  has_many :notifications, as: :recipient
  has_many :relation_userrooms
  has_many :rooms, through: :relation_userrooms
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
