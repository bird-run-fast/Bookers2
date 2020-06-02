class Book < ApplicationRecord

  validates :title, presence: true
  validates :body, length: {in: 1..200}

  belongs_to :user
end
