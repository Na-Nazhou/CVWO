class Tag < ApplicationRecord
  belongs_to :task
  validates :tag_name, uniqueness: {case_sensitive: false}
end
