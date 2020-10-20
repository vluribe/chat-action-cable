class Room < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    has_many :messages
    has_many :relation_userrooms
    has_many :users, through: :relation_userrooms
end
