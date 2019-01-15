class Task < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  has_and_belongs_to_many :tags
end
