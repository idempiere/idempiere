SET SQLBLANKLINES ON
SET DEFINE OFF

-- Show opposite sign on financial report
-- Sep 26, 2019 4:27:52 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203365,0,0,'Y',TO_DATE('2019-09-26 16:27:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-09-26 16:27:52','YYYY-MM-DD HH24:MI:SS'),100,'IsAllowOppositeSign','Allow Opposite Sign','Allow column values to be displayed with the opposite sign','Allows values to be displayed with the opposite sign to the calculated value if the "Show Opposite Sign" flag is set on the Report Line. Note that all report calculations are performed before the sign is reversed.','Allow Opposite Sign','D','67b0805b-dd29-4619-a31f-e831216830f9')
;

-- Sep 26, 2019 4:28:49 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (214054,0,'Allow Opposite Sign','Allow column values to be displayed with the opposite sign','Allows values to be displayed with the opposite sign to the calculated value if the "Show Opposite Sign" flag is set on the Report Line. Note that all report calculations are performed before the sign is reversed.',446,'IsAllowOppositeSign','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2019-09-26 16:28:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-09-26 16:28:49','YYYY-MM-DD HH24:MI:SS'),100,203365,'Y','N','D','N','N','N','Y','ba253ecf-6fab-487a-9555-b1e8a78963ab','Y',0,'N','N')
;

-- Sep 26, 2019 4:28:52 PM IST
ALTER TABLE PA_ReportColumn ADD IsAllowOppositeSign CHAR(1) DEFAULT 'N' CHECK (IsAllowOppositeSign IN ('Y','N'))
;

-- Sep 26, 2019 4:29:17 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206181,'Allow Opposite Sign','Allow column values to be displayed with the opposite sign','Allows values to be displayed with the opposite sign to the calculated value if the "Show Opposite Sign" flag is set on the Report Line. Note that all report calculations are performed before the sign is reversed.',374,214054,'Y',0,460,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-09-26 16:29:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-09-26 16:29:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fa4bf151-debd-446f-9c2c-1045e0047cb9','Y',480,1,1,1,'N','N','N')
;

-- Sep 26, 2019 4:30:39 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2019-09-26 16:30:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206181
;

-- Sep 26, 2019 4:32:22 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203366,0,0,'Y',TO_DATE('2019-09-26 16:32:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-09-26 16:32:21','YYYY-MM-DD HH24:MI:SS'),100,'IsShowOppositeSign','Show Opposite Sign','Display values with the opposite sign','Displays values for a Report Line with the opposite sign to the calculated value. The "Allow Opposite Sign" flag on Report Column must also be set for this to take effect. Note that all report calculations are performed before the sign is reversed.','Show Opposite Sign','D','affbda16-f11c-40c9-bdd6-7b7dbcce23ba')
;

-- Sep 26, 2019 4:33:16 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (214055,0,'Show Opposite Sign','Display values with the opposite sign','Displays values for a Report Line with the opposite sign to the calculated value. The "Allow Opposite Sign" flag on Report Column must also be set for this to take effect. Note that all report calculations are performed before the sign is reversed.',448,'IsShowOppositeSign','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2019-09-26 16:33:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-09-26 16:33:16','YYYY-MM-DD HH24:MI:SS'),100,203366,'Y','N','D','N','N','N','Y','8a3f8b94-6f5f-4966-a222-93a08e660254','Y',0,'N','N')
;

-- Sep 26, 2019 4:33:18 PM IST
ALTER TABLE PA_ReportLine ADD IsShowOppositeSign CHAR(1) DEFAULT 'N' CHECK (IsShowOppositeSign IN ('Y','N'))
;

-- Sep 26, 2019 4:33:44 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206182,'Show Opposite Sign','Display values with the opposite sign','Displays values for a Report Line with the opposite sign to the calculated value. The "Allow Opposite Sign" flag on Report Column must also be set for this to take effect. Note that all report calculations are performed before the sign is reversed.',376,214055,'Y',0,190,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-09-26 16:33:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-09-26 16:33:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5ed1ddfb-f4e2-46f7-ab04-e7045011ee23','Y',205,2,2,1,'N','N','N')
;

SELECT register_migration_script('201912301640_IDEMPIERE-4065.sql') FROM dual
;
