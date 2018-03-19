SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 13, 2013 4:13:06 PM COT
-- IDEMPIERE-1597 Price List and Date must be not-updateable
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('E','Price list cannot be changed because the order contains product lines',200243,'D','41c5bae2-77e0-4beb-a562-3f3ae465cb90','CannotChangePl','Y',TO_DATE('2013-12-13 16:13:05','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_DATE('2013-12-13 16:13:05','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Dec 13, 2013 4:15:35 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('E','Date Ordered cannot be changed because the order contains product lines and the change falls in a differente price list version',200244,'D','8264d9e8-2b91-4aa2-ba80-82171b747254','CannotChangeDateOrdered','Y',TO_DATE('2013-12-13 16:15:34','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_DATE('2013-12-13 16:15:34','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Dec 13, 2013 4:23:13 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('E','Price list cannot be changed because the invoice contains product lines',200245,'D','4d860b4e-0cd0-491f-a68d-e8a4b0ffb8f8','CannotChangePlIn','Y',TO_DATE('2013-12-13 16:23:12','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_DATE('2013-12-13 16:23:12','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Dec 13, 2013 4:24:15 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('E','Date Invoiced cannot be changed because the invoice contains product lines and the change falls in a differente price list version',200246,'D','411625c7-21ee-48e0-8350-5e59f7fb9ecd','CannotChangeDateInvoiced','Y',TO_DATE('2013-12-13 16:24:14','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_DATE('2013-12-13 16:24:14','YYYY-MM-DD HH24:MI:SS'),0)
;

SELECT register_migration_script('201312131644_IDEMPIERE-1597.sql') FROM dual
;

