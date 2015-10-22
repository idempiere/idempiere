SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2896 UX: Doubleclick in text fields
-- Oct 22, 2015 3:21:25 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (202920,0,0,'Y',TO_DATE('2015-10-22 15:21:25','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-10-22 15:21:25','YYYY-MM-DD HH24:MI:SS'),0,'ToggleOnDoubleClick','Toggle on Double Click','Defines if double click in a field on grid mode switch to form view','Defines if double click in a field on grid mode switch to form view','Toggle on Double Click','D','f4bda10b-d0d4-4763-9c2a-6d57c38d8c43')
;

-- Oct 22, 2015 3:21:43 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212330,0,'Toggle on Double Click','Defines if double click in a field on grid mode switch to form view','Defines if double click in a field on grid mode switch to form view',200174,'ToggleOnDoubleClick','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2015-10-22 15:21:43','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-10-22 15:21:43','YYYY-MM-DD HH24:MI:SS'),0,202920,'Y','N','D','N','N','N','Y','82ce8855-972f-4673-bfe4-b2f74219a50b','Y',0,'N','N','N')
;

-- Oct 22, 2015 3:21:49 PM CEST
ALTER TABLE AD_UserPreference ADD ToggleOnDoubleClick CHAR(1) DEFAULT 'N' CHECK (ToggleOnDoubleClick IN ('Y','N'))
;

-- Oct 22, 2015 3:22:22 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203913,'Toggle on Double Click','Defines if double click in a field on grid mode switch to form view','Defines if double click in a field on grid mode switch to form view',200189,212330,'Y',1,80,'N','N','N','N',0,0,'Y',TO_DATE('2015-10-22 15:22:22','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-10-22 15:22:22','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','606eb6b0-a10e-4807-af1b-a2f7c8519115','Y',80,2,2)
;

-- Oct 22, 2015 3:22:42 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=2,Updated=TO_DATE('2015-10-22 15:22:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=203913
;

-- Oct 22, 2015 3:22:42 PM CEST
UPDATE AD_Field SET SeqNo=70,Updated=TO_DATE('2015-10-22 15:22:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=203800
;

-- Oct 22, 2015 3:22:42 PM CEST
UPDATE AD_Field SET SeqNo=80,Updated=TO_DATE('2015-10-22 15:22:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=203798
;

SELECT register_migration_script('201510221522_IDEMPIERE-2896.sql') FROM dual
;

