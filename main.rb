require "ostruct"
require_relative 'payment'
require_relative 'invoice_processor'

user = OpenStruct.new(name: "Ahmed", country: "EG", email: "ahmed@mail.com")
items = [
    { price: 10, quantity: 2 },
    { price: 30, quantity: 1 }
  ]

BALANCE = 1_000_000
payment_method = VisaPayment.new(BALANCE)

processor = InvoiceProcessor.new(user, items, payment_method)
total = processor.process
