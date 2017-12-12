SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3578 - BPartner Location name : Preserve custom name
-- Dec 11, 2017 9:21:24 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203147,0,0,'Y',TO_DATE('2017-12-11 09:21:23','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2017-12-11 09:21:23','YYYY-MM-DD HH24:MI:SS'),0,'IsPreserveCustomName','Preserve custom name','Preserve custom name','D','1f44e2a6-8a98-4a7f-9943-b206a882e20e')
;

-- Dec 11, 2017 9:22:24 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213303,0,'Preserve custom name',293,'IsPreserveCustomName','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2017-12-11 09:22:23','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2017-12-11 09:22:23','YYYY-MM-DD HH24:MI:SS'),0,203147,'Y','N','D','N','N','N','Y','67391508-06ed-431b-9496-e24d0018b799','N',0,'N','N')
;

-- Dec 11, 2017 9:22:27 AM CET
ALTER TABLE C_BPartner_Location ADD IsPreserveCustomName CHAR(1) DEFAULT 'N' CHECK (IsPreserveCustomName IN ('Y','N')) NOT NULL
;

-- Dec 11, 2017 9:22:52 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205277,'Preserve custom name',222,213303,'Y',1,170,'N','N','N','N',0,0,'Y',TO_DATE('2017-12-11 09:22:51','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2017-12-11 09:22:51','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','5e9824ca-04a4-44a5-a1c9-24582e84336c','Y',170,2,2)
;

-- Dec 11, 2017 9:23:06 AM CET
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=205277
;

-- Dec 11, 2017 9:23:06 AM CET
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=2186
;

-- Dec 11, 2017 9:23:06 AM CET
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=200619
;

SELECT register_migration_script('201712110930_IDEMPIERE-3578.sql') FROM dual
;