class TagRelate < ApplicationRecord
  belongs_to :tag
  belongs_to :data_set
end
