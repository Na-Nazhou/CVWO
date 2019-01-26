class Tag < ApplicationRecord
  belongs_to :task
  validates :tag_name, uniqueness: { scope: :task_id,
    message: "cannot be repeated"}
end
