-- Jun 12, 2013 6:37:56 PM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
UPDATE AD_Tab SET DisplayLogic='@HasRegion@=''Y''',Updated=TO_DATE('2013-06-12 18:37:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=136
;

-- Jun 12, 2013 6:38:30 PM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
UPDATE AD_Tab SET AD_Column_ID=7053, DisplayLogic='@HasRegion@=''Y''',Updated=TO_DATE('2013-06-12 18:38:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=215
;

-- Jun 13, 2013 10:00:26 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsInfoTab,WhereClause,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,Description,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID) VALUES ('N','N','N',122,35,'N','N',186,'N','N','C_Region_ID IS NULL','N','Y','N',0,'27c212e2-6808-408a-91b8-7284e2b26c75','D','City (Without Regions)','Cities without Region',200095,0,TO_DATE('2013-06-13 10:00:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-06-13 10:00:25','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Jun 13, 2013 10:00:26 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200095 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Jun 13, 2013 10:00:58 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200095,14,'N','N',7052,10,'Y',202185,'N','City in a country','D','City','City','aa6f52b3-f6a0-4160-ae1a-da47af9d82f4','N','N',100,0,TO_DATE('2013-06-13 10:00:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-06-13 10:00:57','YYYY-MM-DD HH24:MI:SS'),'Y','N',10,1,'N',0,2,1)
;

-- Jun 13, 2013 10:00:58 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202185 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jun 13, 2013 10:00:58 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200095,14,'N','N',1107,20,'Y',202186,'Y','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','fe8af11f-7c8e-48d4-9eb8-b54f2f21d2b0','Y','N',100,0,TO_DATE('2013-06-13 10:00:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-06-13 10:00:58','YYYY-MM-DD HH24:MI:SS'),'Y','Y',20,1,'N',0,2,1)
;

-- Jun 13, 2013 10:00:58 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202186 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jun 13, 2013 10:00:59 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200095,14,'Y','N',1108,30,'Y',202187,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','36b92d99-2c21-4a03-b9fa-9e704593ef6e','Y','N',100,0,TO_DATE('2013-06-13 10:00:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-06-13 10:00:58','YYYY-MM-DD HH24:MI:SS'),'Y','Y',30,4,'N',0,2,1)
;

-- Jun 13, 2013 10:00:59 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202187 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jun 13, 2013 10:00:59 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200095,14,'N','N',7057,40,'Y',202188,'Y','The Country defines a Country.  Each Country must be defined before it can be used in any document.','D','Country ','Country','f9bd6fb5-c072-4344-9dd8-03f8329fe789','Y','N',100,0,TO_DATE('2013-06-13 10:00:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-06-13 10:00:59','YYYY-MM-DD HH24:MI:SS'),'Y','Y',40,1,'N',0,2,1)
;

-- Jun 13, 2013 10:00:59 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202188 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jun 13, 2013 10:01:00 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200095,14,'Y','N',7053,50,'Y',202189,'N','The Region identifies a unique Region for this Country.','D','Identifies a geographical Region','Region','86b81f79-8fc7-4ee1-8d14-c1b5b5ec72f0','Y','N',100,0,TO_DATE('2013-06-13 10:00:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-06-13 10:00:59','YYYY-MM-DD HH24:MI:SS'),'Y','Y',50,4,'N',0,2,1)
;

-- Jun 13, 2013 10:01:00 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202189 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jun 13, 2013 10:01:00 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES (1,'N',200095,60,'N','N',1233,60,'Y',202190,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','D','Alphanumeric identifier of the entity','Name','4941981e-61fb-489a-89bc-79760dc2362d','Y','N',100,0,TO_DATE('2013-06-13 10:01:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-06-13 10:01:00','YYYY-MM-DD HH24:MI:SS'),'Y','Y',60,1,'N',0,5,1)
;

-- Jun 13, 2013 10:01:00 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202190 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jun 13, 2013 10:01:01 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200095,1,'N','N',1109,70,'Y',202191,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','2b497371-c40f-4236-8afa-f2431b121ca2','Y','N',100,0,TO_DATE('2013-06-13 10:01:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-06-13 10:01:00','YYYY-MM-DD HH24:MI:SS'),'Y','Y',70,2,'N',0,2,1)
;

-- Jun 13, 2013 10:01:01 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202191 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jun 13, 2013 10:01:02 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200095,11,'N','N',7051,80,'Y',202192,'N','The Postal Code or ZIP identifies the postal code for this entity''s address.','D','Postal code','ZIP','c6408f16-0fa3-4b77-94f1-6a1d162a0f3f','Y','N',100,0,TO_DATE('2013-06-13 10:01:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-06-13 10:01:01','YYYY-MM-DD HH24:MI:SS'),'Y','Y',80,1,'N',0,2,1)
;

-- Jun 13, 2013 10:01:02 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202192 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jun 13, 2013 10:01:02 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200095,11,'Y','N',7055,90,'Y',202193,'N','Phone Area Code','D','Phone Area Code','Area Code','3aaaa4ed-885b-4670-9f71-87e14cc278c4','Y','N',100,0,TO_DATE('2013-06-13 10:01:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-06-13 10:01:02','YYYY-MM-DD HH24:MI:SS'),'Y','Y',90,4,'N',0,2,1)
;

-- Jun 13, 2013 10:01:02 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202193 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jun 13, 2013 10:01:03 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200095,11,'N','N',7054,100,'Y',202194,'N','UN/Locode is a combination of a 2-character country code and a 3-character location code, e.g. BEANR is known as the city of Antwerp (ANR) which is located in Belgium (BE).
<p>See: http://www.unece.org/cefact/locode/service/main.htm','D','Location code - UN/LOCODE ','Locode','76ff8f96-236f-4977-bd43-7f9c3a613be5','Y','N',100,0,TO_DATE('2013-06-13 10:01:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-06-13 10:01:02','YYYY-MM-DD HH24:MI:SS'),'Y','Y',100,1,'N',0,2,1)
;

-- Jun 13, 2013 10:01:03 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202194 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jun 13, 2013 10:01:03 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200095,15,'Y','N',7056,110,'Y',202195,'N','This column contains the geographical coordinates (latitude/longitude) of the location.<p>
In order to avoid unnecessary use of non-standard characters and space, the following standard presentation is used:<br>
0000N 00000W 0000S 00000E <br>
where the two last digits refer to minutes and the two or three first digits indicate the degrees','D','Location coordinate','Coordinates','cd58632f-e015-4439-9807-feed94a0be2e','Y','N',100,0,TO_DATE('2013-06-13 10:01:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-06-13 10:01:03','YYYY-MM-DD HH24:MI:SS'),'Y','Y',110,4,'N',0,2,1)
;

-- Jun 13, 2013 10:01:03 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202195 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jun 13, 2013 10:01:43 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
UPDATE AD_Field SET IsReadOnly='Y', DefaultValue='-1',Updated=TO_DATE('2013-06-13 10:01:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202189
;

-- Jun 13, 2013 10:07:08 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
UPDATE AD_Tab SET WhereClause='C_Region_ID IS NULL AND C_Country_ID = @C_Country_ID@',Updated=TO_DATE('2013-06-13 10:07:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200095
;


-- Jun 13, 2013 10:40:56 AM COT
-- IDEMPIERE-978 Creating cities is assigning wrong region
UPDATE AD_Tab SET AD_Column_ID=7057, TabLevel=1,Updated=TO_DATE('2013-06-13 10:40:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200095
;


SELECT register_migration_script('20130613110000_IDEMPIERE-978.sql') FROM dual
;

