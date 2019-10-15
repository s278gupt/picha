class Tag < ApplicationRecord
    has_many :taggings
    has_many :pictures, through: :taggings
end
