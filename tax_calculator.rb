class TaxCalculator
  EG_TAX = 0.14
  OTHERS_TAX = 0.20

  def initialize(country)
    @country = country
  end

  def calculate_tax(sub_total)
    if @country == "EG"
      tax = sub_total * EG_TAX
    else
      tax = sub_total * OTHERS_TAX
    end
    tax
  end
end
