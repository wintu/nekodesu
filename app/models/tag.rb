class Tag < ApplicationRecord
  has_many :tag_relates, dependent: :destroy
  has_many :data_sets, through: :tag_relates
end
