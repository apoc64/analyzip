FactoryBot.define do
  factory :state do
    abbreviation 'CO'
  end

  factory :zip do
    state
    n1 5000
    mars1 2000
    mars2 2500
    mars4 1000
    prep 750
    numdep 3000
    elderly 750
    a00100 1000000

    factory :zip_high_income do
      state
      n1 5000
      mars1 2000
      mars2 2500
      mars4 1000
      prep 750
      numdep 3000
      elderly 750
      a00100 5000000
    end

    factory :zip_high_pop do
      state
      n1 5100
      mars1 2000
      mars2 2500
      mars4 1000
      prep 750
      numdep 3000
      elderly 750
      a00100 5000000
    end
  end
end
