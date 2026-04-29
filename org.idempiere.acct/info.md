# iDempiere Accounting Engine (Fact ACCT)

**Summary:** The foundational accounting engine for iDempiere. It processes all document-level transactions (Invoices, Payments, Material Receipts, etc.) and transforms them into balanced accounting entries (Fact ACCT) based on the configured Accounting Schema and Chart of Accounts.

## 🚀 Features

* **Real-Time Posting:** Automatically generates accounting facts upon document completion.
* **Multi-Currency Support:** Handles complex currency conversions and realized/unrealized gain/loss calculations.
* **Multi-Schema Accounting:** Supports posting a single transaction to multiple accounting schemas simultaneously (e.g., Local GAAP and IFRS).
* **Flexible Dimensions:** Provides core support for accounting dimensions including Organization, Account, Product, Business Partner, Project, and Sales Region.
* **Suspense Accounting:** Robust handling of unbalanced entries by routing them to configured suspense accounts for manual review.
* **Document Integration:** Pre-configured posting logic for all standard iDempiere documents (AR/AP Invoices, Bank Statements, Inventory Moves, etc.).

## ⚙️ Compatibility

* **Core Module**
* **Java Version:** 17+

## 📦 Database Changes

* **Core Tables:** Manages data within `Fact_Acct`, `C_AcctSchema`, `C_ValidCombination`, and `GL_Category`.
* **Posting Logic:** Uses the `Doc_*` class hierarchy to define how specific document types are translated into debits and credits.

## 🛠 Usage & Configuration

* **Configuration:** 
    1. Define your **Accounting Schema** and **Chart of Accounts**.
    2. Set up **Default Accounts** for Products, Business Partners, and Tax Categories.
* **Execution:** Transactions are usually posted automatically.
* **Audit:** Use the **Performance Analysis > Accounting Fact** window to audit individual entries and drill back to the source document.

## 👤 Author / Support

* **Developer:** iDempiere Community
* **Source Code:** [https://github.com/idempiere/idempiere/tree/master/org.idempiere.acct](https://github.com/idempiere/idempiere/tree/master/org.idempiere.acct)
* **Documentation:** [iDempiere Wiki - Accounting](https://wiki.idempiere.org/en/IDempiere_Accounting)