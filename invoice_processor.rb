require_relative 'tax_calculator'
require_relative 'logger'
require_relative 'email_sender'

class InvoiceProcessor
  def initialize(user, items, payment_method)
    @user = user
    @items = items
    @payment_method = payment_method

    @tax_calculator = TaxCalculator.new(@user.country)
    @logger = Logger.new
    @email_sender = EmailSender.new
  end

  def process
    total = process_invoice_payment
    @logger.log_invoice(@user.name, total)
    @email_sender.send_email(@user.email)
    total
  end

  def process_invoice_payment
    sub_total = calculate_sub_total
    total = sub_total + @tax_calculator.calculate_tax(sub_total)
    @payment_method.process_payment(total)
    total
  end

  private
  def calculate_sub_total
    sub_total = 0
    @items.each do |item|
      sub_total += item[:price] * item[:quantity]
    end
    sub_total
  end
end

