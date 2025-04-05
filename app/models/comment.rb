class Comment < ApplicationRecord
  belongs_to :project

  validates :content, presence: true

  broadcasts_to :project
end
