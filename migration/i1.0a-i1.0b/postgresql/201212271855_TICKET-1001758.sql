-- Dec 27, 2012 6:53:37 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Process SET Description='Create Package for Shipment',Updated=TO_TIMESTAMP('2012-12-27 18:53:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=282
;

-- Dec 27, 2012 6:53:37 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Process_Trl SET IsTranslated='N' WHERE AD_Process_ID=282
;

SELECT register_migration_script('201212271855_TICKET-1001758.sql') FROM dual
;