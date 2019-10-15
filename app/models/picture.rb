class Picture < ApplicationRecord
    belongs_to :user
    belongs_to :album, optional: true

    has_one_attached :image
    has_many :taggings
    has_many :tags, through: :taggings

    validate :image_type

    include PgSearch
    pg_search_scope :search_by_tag, against: [:all_tags]

    def all_tags=(names)
        self.tags = names.split(",").map do |name|
            Tag.where(name: name.strip).first_or_create!
        end
    end
      
    def all_tags
        self.tags.map(&:name).join(", ")
    end

    def self.tagged_with(name)
        Tag.find_by_name!(name).pictures
      end

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
