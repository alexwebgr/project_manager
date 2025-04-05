class Project < ApplicationRecord
  enum :status, { active: 0, inactive: 1, closed: 2, archived: 3 }

  validates :name, presence: true

  has_many :comments, dependent: :destroy
end
