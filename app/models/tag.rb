class Tag < ApplicationRecord
  belongs_to :user

  has_many :tag_notes
  has_many :notes, through: :tag_notes

  validates_presence_of :title, :user
end
