class Book < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, :content, presence: true
end
