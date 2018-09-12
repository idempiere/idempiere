-- IDEMPIERE-2709: Adding support for editable field on info window
-- Jul 3, 2015 6:10:42 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212216,0,'Read Only','Field is read only','The Read Only indicates that this field may only be Read.  It may not be updated.',897,'IsReadOnly','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2015-07-03 18:10:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-07-03 18:10:41','YYYY-MM-DD HH24:MI:SS'),100,405,'Y','N','D','N','N','N','Y','3a94dcce-25f4-4382-9547-a8f18949bbe7','Y','N','N')
;

-- Jul 3, 2015 6:10:49 PM IST
ALTER TABLE AD_InfoColumn ADD COLUMN IsReadOnly CHAR(1) DEFAULT 'Y' CHECK (IsReadOnly IN ('Y','N')) NOT NULL
;

-- Jul 3, 2015 6:15:02 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (203829,'Read Only','Field is read only','The Read Only indicates that this field may only be Read.  It may not be updated.',844,212216,'Y',0,165,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-07-03 18:14:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-07-03 18:14:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ebc3464e-96a2-447d-a846-b964ede1b66f','Y',170,1,1,1,'N','N','N')
;

-- Table: t_selection_infowindow

-- DROP TABLE t_selection_infowindow;

CREATE TABLE t_selection_infowindow
(
  ad_pinstance_id numeric(10) NOT NULL,
  t_selection_id numeric(10) NOT NULL,
  viewid varchar(30),
  columnname varchar(255) NOT NULL,
  value_string varchar(255),
  value_date timestamp,
  value_number numeric,
  info varchar(60),
  CONSTRAINT t_selection_infowindow_key PRIMARY KEY (ad_pinstance_id, t_selection_id, columnname)
);

SELECT register_migration_script('201507032015_IDEMPIERE-2709.sql') FROM dual
;
