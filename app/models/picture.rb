class Picture < ApplicationRecord
    belongs_to :user
    belongs_to :album

    has_one_attached :image

    validate :image_type

    private
    def image_type

        if !image.attached?
            errors.add(:image, "please select images")
        else
            if !image.content_type.in?(%('image/jpeg' 'image/png'))
                errors.add(:image, 'needs to be a JPEG or PNG')
            end
        end
    end
end
