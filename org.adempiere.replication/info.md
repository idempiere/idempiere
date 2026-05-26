# iDempiere Data Replication

**Summary:** A robust data synchronization engine designed to replicate data between multiple iDempiere instances. It supports both asynchronous and scheduled replication, ensuring data consistency across distributed environments such as remote branch offices or retail outlets.

## 🚀 Features

* **Single Direction Sync:** Supports Master-to-Slave replication topologies.
* **Dictionary Driven:** Handles table structures and data relationships defined in the Application Dictionary.
* **Partial Replication:** Ability to define specific tables or records for replication using "Replication Strategies."

## ⚙️ Compatibility

* **Core Module**
* **Java Version:** 17+

## 📦 Database Changes

* **Replication Tables:** Utilizes core tables including `AD_Replication`, `AD_ReplicationStrategy`, `AD_ReplicationTable`, and `AD_Replication_Log`.
* **Triggers:** Uses Application Dictionary-level event handlers to capture data changes for export.

## 🛠 Usage & Configuration

* **Setup:**
    1. Define a **Replication Strategy** to select which tables should be synchronized.
    2. Configure a **Messaging Server** that support **JMS** for the transfer of message and data between the source and target iDempiere instance.
    3. Configure **Export Format** and **Export Processor** at the source iDempiere instance.
    4. Add Export Model Validation Classes: org.adempiere.model.ExportModelValidator at the source iDempiere instance.
    5. Configure **Import Format** and **Import Processor** at the target iDempiere instance.
* **Execution:** Export is trigger via the export model validation class. Import is via the scheduled Import Processor.
* **Monitoring:** All successful transmissions and errors are recorded in the **Replication Log** for audit and troubleshooting.

## 👤 Author / Support

* **Developer:** e-Evolution
* **Source Code:** [https://github.com/idempiere/idempiere/tree/master/org.adempiere.replication](https://github.com/idempiere/idempiere/tree/master/org.adempiere.replication)
