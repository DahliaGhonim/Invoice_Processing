# SOLID Violations

## Single Responsibility Principle is Violated

The function `process` is responsible for **too many things**:

1. Calculates the total amount of the invoice  
   1.1 Calculates the total price of the items  
   1.2 Calculates the taxes based on the country  

2. Processes the payment method  

3. Writes the invoice to a file  

4. Sends an email to the user  

## Open-Closed Principle is Violated

We will have to **modify** the function `process` in all the following situations:

1. A country's tax is added/removed/changed  
2. A payment method is added/removed  
3. The format of the invoice is changed  
4. The format of the email is changed  
5. Sending email feature is removed  

## Dependency Inversion Principle is Violated

The class `InvoiceProcessor` is dependent on the following **low-level details**:

1. The supported countries' taxes  
2. The supported payment methods  
3. How the invoice is logged  
4. How the email is sent  

---

# Changes & Explanation

### Created the following classes

1. `TaxCalculator`  
2. `PaymentInterface`  
   Subclasses: `VisaPayment`, `PaypalPayment`, `CashPayment`  
3. `Logger`  
4. `EmailSender`  

### Refactored `InvoiceProcessor` class

---

### Due to the violation of **SRP**, the software was not reusable

**After introducing the above classes, reusability increased**, for example:

- `TaxCalculator` can be used as a helper to calculate the appropriate price of a product  
- `EmailSender` can be reused when a product is back in stock  

### Due to the violation of **OCP**, the class `InvoiceProcessor` was not extensible

**After introducing `PaymentInterface`**, adding a new payment method is now easy:

> If we want to add **MasterCard**, we simply create a new class `MasterCardPayment` that inherits from `PaymentInterface` and implements/overides the `process_payment` method.

→ This way, we added a new payment method **without modifying** `InvoiceProcessor`.

### Due to the violation of **DIP**, high-level modules depended on low-level details

**After refactoring**, the class `InvoiceProcessor` is no longer dependent on concrete details such as:

- Countries supported for specific tax rates  
- The tax rates of the supported countries  
- The supported payment methods  

---

**Summary**: By applying SOLID principles (SRP, OCP, DIP), we achieved a more **maintainable**, **extensible**, and **reusable** codebase.