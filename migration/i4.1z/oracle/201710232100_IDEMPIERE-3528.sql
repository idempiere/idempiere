SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3528 Add to Favorite for Menu Search Panel
-- Oct 23, 2017 11:59:39 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Add To Favourite',0,0,'Y',TO_DATE('2017-10-23 23:59:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-10-23 23:59:38','YYYY-MM-DD HH24:MI:SS'),100,200435,'AddToFavourite','D','ddbf357f-3f1c-49dd-9ce7-3d8f0cc3b30a')
;

-- Oct 24, 2017 12:00:05 AM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Remove From Favourite',0,0,'Y',TO_DATE('2017-10-24 00:00:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-10-24 00:00:05','YYYY-MM-DD HH24:MI:SS'),100,200436,'RemoveFromFavourite','D','36985206-17fb-4bf2-a339-3aac5e2601f3')
;

-- Oct 24, 2017 12:00:51 AM GMT+08:00
UPDATE AD_Message SET MsgText='Add To Favourites', Value='AddToFavourites',Updated=TO_DATE('2017-10-24 00:00:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200435
;

-- Oct 24, 2017 12:00:58 AM GMT+08:00
UPDATE AD_Message SET MsgText='Remove From Favourites', Value='RemoveFromFavourites',Updated=TO_DATE('2017-10-24 00:00:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200436
;

SELECT register_migration_script('201710232100_IDEMPIERE-3528.sql') FROM dual
;

