class Datum < ApplicationRecord
  require 'csv'
  belongs_to :data_set, optional: true
  belongs_to :user

  def convert_hash
    csv = CSV.parse(self.body, headers: true)
    csv.map(&:to_h)
  end
end
