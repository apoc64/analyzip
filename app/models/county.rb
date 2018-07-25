class County < ApplicationRecord
  belongs_to :state

  def name
    county
  end

      # @high_incomes = Zip.select('zips.id, zips.a00100, zips.n1, (zips.a00100 / zips.n1) AS income').order('income DESC').limit(10)
  def self.premature_death
    County.select('id, measure_1_value AS raw_value, county, state_id').where('measure_1_value > 0').order('measure_1_value DESC').limit(10)
  end

  def self.low_birth_weight
    County.select('id, measure_37_value AS raw_value, county, state_id').where('measure_37_value > 0').order('measure_37_value DESC').limit(10)
  end

  def self.diabetes
    County.select('id, measure_60_value AS raw_value, county, state_id').where('measure_60_value > 0').order('measure_60_value DESC').limit(10)
  end
end
