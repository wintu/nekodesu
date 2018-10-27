class DataSet < ApplicationRecord
  belongs_to :user
  has_many :data
  has_many :tag_relates, dependent: :destroy
  has_many :tags, through: :tag_relates
end
