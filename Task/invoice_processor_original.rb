# SOLID & OOP Refactoring Task — Requirements

# You will get a Ruby class that handles invoice processing.
# The class is not well-designed and breaks many OOP and SOLID rules.
# Your job is to study the code, understand what is wrong, and rewrite it in a clean way.

# 1. Read and Analyze the Code

# Before you change anything, read the code carefully.

# You must write:

# Which SOLID principles are broken

# Where the problems appear in the code

# Why each part is considered a violation

# Keep your explanations simple and clear.

# 2. Refactor the Code

# You need to rewrite the code using SOLID principles.
# Your final version should be easier to read, test, and extend.

# Please make sure to:

# Split responsibilities into separate classes (SRP)

# Allow new features (like new payment methods) without editing old classes (OCP)

# Make sure any subclass can replace the parent class without issues (LSP)

# Use small and focused interfaces (ISP)

# Depend on abstractions, not concrete classes (DIP)

# 3. Improve the Structure

# Your refactored code should include:

# A separate class for tax calculation

# A payment interface with different payment classes (Visa, PayPal, Cash, etc.)

# A logger class

# A notification or email sender class

# Dependency injection instead of writing files or printing inside the processor

# A main InvoiceProcessor that only controls the invoice workflow

# 4. Make the Code Test-Friendly

# The new version should be easy to test.
# So please avoid:

# puts statements

# Writing to files directly

# Sending real emails

# All external actions should be inside their own classes so you can mock them in tests.

# Deliverables

# When you finish, you should submit:

# A list of all SOLID violations you found

# The refactored code

# A short explanation of how your changes fix the problems

# (Optional) A small diagram showing your classes

# Goal of the Task

# By doing this assignment, you should show that you can:

# Understand OOP problems

# Apply SOLID in real code

# Clean up messy code

# Build a system that is easy to maintain and extend



class InvoiceProcessor
  def initialize(user, items, payment_method)
    @user = user
    @items = items
    @payment_method = payment_method
  end

  def process
    total = 0

    @items.each do |item|
      total += item[:price] * item[:quantity]
    end

    if @user.country == "EG"
      total += total * 0.14
    else
      total += total * 0.20
    end

    if @payment_method == :visa
      puts "Paid using VISA"
    elsif @payment_method == :paypal
      puts "Paid using PayPal"
    elsif @payment_method == :cash
      puts "Paid with CASH"
    else
      raise "Payment method not supported"
    end

    File.open("invoice_log.txt", "a") do |f|
      f.puts "User: #{@user.name}, Total: #{total}"
    end

    puts "Email sent to #{@user.email}: thanks for your purchase"

    total
  end
end


# Usage Main from controller or rails c or wherever. 
processor = InvoiceProcessor.new(
  OpenStruct.new(name: "Ahmed", country: "EG", email: "ahmed@mail.com"),
  [
    { price: 10, quantity: 2 },
    { price: 30, quantity: 1 }
  ],
  :visa
)

processor.process
