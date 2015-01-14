SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 17, 2014 11:44:24 AM ICT
-- IDEMPIERE-1969 Contextual Menu for Info Window Parameters
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,'N',0,211766,'N','N','N',0,'N',10,'N','N','N','Y','d32e78d0-660c-4e82-9797-52a00ce3042f','N','AD_InfoWindow_ID','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.','Info Window','Y',TO_DATE('2014-09-17 11:44:23','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-09-17 11:44:23','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','ad_infowindow_preference','N',3068,19,195)
;

-- Sep 17, 2014 11:44:56 AM ICT
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_DATE('2014-09-17 11:44:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211766
;

-- Sep 17, 2014 11:47:56 AM ICT
ALTER TABLE AD_Preference ADD AD_InfoWindow_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 17, 2014 11:47:57 AM ICT
ALTER TABLE AD_Preference ADD CONSTRAINT ad_infowindow_preference FOREIGN KEY (AD_InfoWindow_ID) REFERENCES ad_infowindow(ad_infowindow_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 17, 2014 11:48:37 AM ICT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_TableIndex_ID,SeqNo,AD_Column_ID,EntityType) VALUES (0,0,201253,'c07256ab-8778-4487-978a-d9aa59ef165f',TO_DATE('2014-09-17 11:48:36','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2014-09-17 11:48:36','YYYY-MM-DD HH24:MI:SS'),100,200141,0,211766,'D')
;

-- Sep 17, 2014 11:48:56 AM ICT
DROP INDEX ad_preference_attribute
;

-- Sep 17, 2014 11:48:56 AM ICT
CREATE UNIQUE INDEX ad_preference_attribute ON AD_Preference (PreferenceFor,AD_InfoWindow_ID,AD_Process_ID,AD_Client_ID,AD_Org_ID,AD_Window_ID,AD_User_ID,Attribute)
;
SELECT register_migration_script('201417091982-IDEMPIERE-1969.sql') FROM dual
;
