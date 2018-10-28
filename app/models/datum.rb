class Datum < ApplicationRecord
  require 'csv'
  belongs_to :data_set

  def convert_hash
    csv = CSV.parse(self.body, headers: true)
    csv.map(&:to_h)
  end
end
