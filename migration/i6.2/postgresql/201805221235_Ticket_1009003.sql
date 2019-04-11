-- May 17, 2018 12:24:17 PM SGT
-- 1009003 add QR Code as Barcode Type for Print Formats
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Created,Updated,EntityType,AD_Client_ID,AD_Org_ID,CreatedBy,UpdatedBy,Value,Name,IsActive,AD_Ref_List_UU,AD_Reference_ID) VALUES (200396,TO_TIMESTAMP('2018-05-17 12:24:15','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2018-05-17 12:24:15','YYYY-MM-DD HH24:MI:SS'),'D',0,0,100,100,'QRC','QR Code','Y','702f344c-557a-4a34-aaae-578cb1b2d137',377)
;

SELECT register_migration_script('201805221235_Ticket_1009003.sql') FROM dual
;