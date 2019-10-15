class Album < ApplicationRecord
    belongs_to :user
    has_many :pictures, dependent: :destroy

    validates :name, presence: true

    def first_image index
        @picture = Picture.where(album_id: index).first
        return @picture.image
    end
end
