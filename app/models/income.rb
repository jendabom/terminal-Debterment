class Income < ApplicationRecord
  belongs_to :user
  def as_json
    {
      name: name,
      monthly_income: monthly_income,
    }
  end

  def monthly_income
    if recurring == true
      (paydays_per_year * amount_per_payday) / 12
    else
      "0"
    end
  end

end
