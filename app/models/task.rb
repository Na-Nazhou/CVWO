class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, length: { maximum: 1000,
    too_long: "%{count} characters is teh maximum allowed" }
  belongs_to :user
  has_many :tags, dependent: :destroy
  accepts_nested_attributes_for :tags,
    allow_destroy: true,
    reject_if: lambda { |attributes| attributes['tag_name'].blank?}
end
