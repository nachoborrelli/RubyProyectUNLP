class Book < ApplicationRecord
  has_many :notes, dependent: :destroy
  belongs_to :user, inverse_of: :books

  validates :title, presence: true, uniqueness: {scope: :user}, length: {maximum: 40}
end
