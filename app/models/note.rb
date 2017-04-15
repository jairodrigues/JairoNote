class Note < ApplicationRecord
  has_many :tag_notes
  has_many :tags, through: :tag_notes

  has_many :users_notes
  has_many :users, through: :users_notes

  belongs_to :user

  validates_presence_of :title, :body, :user

end
