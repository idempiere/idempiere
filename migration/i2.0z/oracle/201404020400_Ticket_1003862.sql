-- Apr 2, 2014 3:38:01 PM COT
-- 1003862-Barcode type UPC A is needed for print formats going to Amazon
INSERT INTO AD_Ref_List (AD_Client_ID,AD_Org_ID,AD_Reference_ID,AD_Ref_List_ID,AD_Ref_List_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,Value) VALUES (0,0,377,200176,'79d36566-b888-4fc1-931d-c0b1612c709b',TO_DATE('2014-04-02 15:53:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','UPC-A',TO_DATE('2014-04-02 15:53:38','YYYY-MM-DD HH24:MI:SS'),100,'UPA')
;

SELECT register_migration_script('201404020400_Ticket_1003862.sql') FROM dual
;
