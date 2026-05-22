# iDempiere Payment Processor

**Summary:** Payment processor implementations for external payment gateways.

## 🚀 Features

* Payment processor implementation for Authorize.net, Optimal, VeriSign PayFlow Pro and PayPal.

## ⚙️ Compatibility

* **Core Module**
* **Java Version:** 17+

## 📦 Database Changes

* **Payment Tables:** Primarily interacts with `C_Payment`, `C_PaymentProcessor`, and `C_PaymentTransaction`.
* **Configuration:** No additional DDL required; uses standard Application Dictionary entries for Payment Processor and Gateway configuration.

## 🛠 Usage & Configuration

* **Configuration:**
    1. Navigate to the **Payment Processor** window.
    2. Define your gateway provider, URL, and credentials.
    3. Link the Processor to a **Bank Account** and **Tender Type**.
* **Monitoring:** Use the **Payment Transaction** window to audit raw responses and status codes from external providers.

## 👤 Author / Support

* **Developer:** iDempiere Community
* **Source Code:** [https://github.com/idempiere/idempiere/tree/master/org.adempiere.payment.processor](https://github.com/idempiere/idempiere/tree/master/org.adempiere.payment.processor)
