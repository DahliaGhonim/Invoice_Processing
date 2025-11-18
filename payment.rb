class PaymentInterface
  def process_payment
    raise NotImplementedError, "Subclasses must implement process_payment function"
  end

  private

  # total: the initial available amount
  #        this can be the account balance or the cash paid
  # amount: the amount to be paid
  def check_payment_validity(total, amount)
    raise "Available balance is not enough!" if total < amount
    return total - amount
  end
end

class VisaPayment < PaymentInterface
  VISA_SERVICE_RATE = 0.03        # I added this dummy rate just to distinguish between visa & paypal

  def initialize(balance)
    @balance = balance
  end

  def process_payment(amount)
    visa_service = amount * VISA_SERVICE_RATE
    amount += visa_service
    @balance = check_payment_validity(@balance, amount)
  end
end

class PaypalPayment < PaymentInterface
  PAYPAL_SERVICE_RATE = 0.04      # I added this dummy rate just to distinguish between visa & paypal

  def initialize(balance)
    @balance = balance
  end

  def process_payment(amount)
    paypal_service = amount * PAYPAL_SERVICE_RATE
    amount += paypal_service
    @balance = check_payment_validity(@balance, amount)
  end
end

class CashPayment < PaymentInterface
  def initialize(cash)
    @cash = cash
  end

  def process_payment(amount)
    change = check_payment_validity(@cash, amount)
  end
end
