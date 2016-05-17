SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3046 Add Currency Field to Cost Adjustment Window
-- Mar 3, 2016 3:11:22 PM SGT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Description,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200091,'C_Currency in accounting schema','Available currencies are based on the schemas currency.','S','C_Currency_ID in (SELECT C_Currency_ID FROM C_AcctSchema Where AD_Client_ID = @AD_Client_ID@)',0,0,'Y',TO_DATE('2016-03-03 15:11:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-03-03 15:11:21','YYYY-MM-DD HH24:MI:SS'),100,'D','b632eb71-14ab-498f-b956-58f549082dea')
;

-- Mar 3, 2016 3:12:38 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212647,0,'Currency','The Currency for this record','Indicates the Currency to be used when processing or reporting on this record',321,200091,'C_Currency_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2016-03-03 15:12:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-03-03 15:12:37','YYYY-MM-DD HH24:MI:SS'),100,193,'Y','N','D','N','N','N','Y','a10d0295-362d-42c5-a84e-5c33ae7f0fb7','Y',0,'N','N','N')
;

-- Mar 3, 2016 3:13:00 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212648,0,'Currency Type','Currency Conversion Rate Type','The Currency Conversion Rate Type lets you define different type of rates, e.g. Spot, Corporate and/or Sell/Buy rates.',321,'C_ConversionType_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2016-03-03 15:12:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-03-03 15:12:59','YYYY-MM-DD HH24:MI:SS'),100,2278,'Y','N','D','N','N','N','Y','94ead663-3677-4bd0-ae50-152acbb36471','Y',0,'N','N','N')
;

-- Mar 3, 2016 3:13:05 PM SGT
UPDATE AD_Column SET FKConstraintName='CConversionType_MInventory', FKConstraintType='N',Updated=TO_DATE('2016-03-03 15:13:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212648
;

-- Mar 3, 2016 3:13:05 PM SGT
ALTER TABLE M_Inventory ADD C_ConversionType_ID NUMBER(10) DEFAULT NULL 
;

-- Mar 3, 2016 3:13:05 PM SGT
ALTER TABLE M_Inventory ADD CONSTRAINT CConversionType_MInventory FOREIGN KEY (C_ConversionType_ID) REFERENCES c_conversiontype(c_conversiontype_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 3, 2016 3:13:24 PM SGT
UPDATE AD_Column SET FKConstraintName='CCurrency_MInventory', FKConstraintType='N',Updated=TO_DATE('2016-03-03 15:13:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212647
;

-- Mar 3, 2016 3:13:24 PM SGT
ALTER TABLE M_Inventory ADD C_Currency_ID NUMBER(10) DEFAULT NULL 
;

-- Mar 3, 2016 3:13:24 PM SGT
ALTER TABLE M_Inventory ADD CONSTRAINT CCurrency_MInventory FOREIGN KEY (C_Currency_ID) REFERENCES c_currency(c_currency_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 3, 2016 3:14:33 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204145,'Currency','The Currency for this record','Indicates the Currency to be used when processing or reporting on this record',200102,212647,'Y',0,170,0,'N','N','N','N',0,0,'Y',TO_DATE('2016-03-03 15:14:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-03-03 15:14:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4db70d18-3eec-45a6-a023-b2e15ac2a075','Y',200,1,1,1,'N','N','N')
;

-- Mar 3, 2016 3:14:49 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204146,'Currency Type','Currency Conversion Rate Type','The Currency Conversion Rate Type lets you define different type of rates, e.g. Spot, Corporate and/or Sell/Buy rates.',200102,212648,'Y',0,180,0,'N','N','N','N',0,0,'Y',TO_DATE('2016-03-03 15:14:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-03-03 15:14:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2bac096b-6a89-4643-8594-4cbbbd56b829','Y',210,1,1,1,'N','N','N')
;

-- Mar 3, 2016 3:15:23 PM SGT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=204145
;

-- Mar 3, 2016 3:15:23 PM SGT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=204146
;

-- Mar 3, 2016 3:15:23 PM SGT
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=202316
;

-- Mar 3, 2016 3:15:23 PM SGT
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=202303
;

-- Mar 3, 2016 3:15:23 PM SGT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=202305
;

-- Mar 3, 2016 3:15:23 PM SGT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=202306
;

-- Mar 3, 2016 3:15:23 PM SGT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=202307
;

-- Mar 3, 2016 3:15:23 PM SGT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=202308
;

-- Mar 3, 2016 3:15:23 PM SGT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=202309
;

-- Mar 3, 2016 3:15:23 PM SGT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=202310
;

-- Mar 3, 2016 3:15:23 PM SGT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=202313
;

-- Mar 3, 2016 3:15:23 PM SGT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=202314
;

-- Mar 3, 2016 3:15:23 PM SGT
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=202315
;

update m_inventory 
set c_currency_id = (select a.c_currency_id from c_acctschema a,
			ad_clientinfo ci where ci.c_acctschema1_id = a.c_acctschema_id 
			and ci.ad_client_id = m_inventory.ad_client_id)
where c_doctype_id in (select c_doctype_id from c_doctype where ad_client_id = m_inventory.ad_client_id 
			and docsubtypeinv ='CA' and docbasetype='MMI' and isactive='Y')
;



-- IDEMPIERE-3046 Add Currency Field to Cost Adjustment Window
-- Mar 3, 2016 3:32:39 PM SGT
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2016-03-03 15:32:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212647
;

-- Mar 3, 2016 3:32:54 PM SGT
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2016-03-03 15:32:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212648
;

-- Mar 3, 2016 3:34:51 PM SGT
UPDATE AD_Field SET DisplayLogic='@C_Currency_ID@!@$C_Currency_ID@',Updated=TO_DATE('2016-03-03 15:34:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204146
;

-- Mar 21, 2016 7:12:45 PM SGT
UPDATE AD_Val_Rule SET Code='C_Currency_ID in (SELECT C_Currency_ID FROM C_AcctSchema Where AD_Client_ID = @AD_Client_ID@ AND (IsMemberOfAcctSchema(AD_Client_ID,@AD_Org_ID@,C_AcctSchema_ID) OR AD_OrgOnly_ID Is NULL ))',Updated=TO_DATE('2016-03-15 01:12:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200091
;

CREATE or REPLACE FUNCTION IsMemberOfAcctSchema( p_AD_Client_ID NUMBER , p_AD_Org_ID NUMBER , p_C_AcctSchema_ID NUMBER ) 
RETURN boolean AS 
 v_ad_org_id NUMBER ;
 v_count NUMBER ;
BEGIN
v_ad_org_id := -1;
v_count :=0 ;
SELECT count(*) into v_count from C_AcctSchema c 
Where C_AcctSchema_ID <> p_C_AcctSchema_ID
and AD_OrgOnly_ID= p_AD_Org_ID;


if (v_count = 0 ) Then
	WITH tr(level, parent_name, name, ad_org_id) as (
	 select 0, null as parentName, ad_org.name, tn.node_id 
	 from ad_tree t
	 join ad_treenode tn on t.ad_tree_id=tn.ad_tree_id
	 join ad_org on tn.node_id=ad_org.ad_org_id
	 join c_acctschema ca on ad_org.ad_org_id=ca.AD_OrgOnly_ID and ca.C_AcctSchema_ID=p_C_AcctSchema_ID
	 where t.treetype='OO' AND t.ad_client_id= p_AD_Client_ID 
	 and ((tn.parent_id = 0 and ad_org.issummary='Y') or (ad_org.ad_org_id=p_AD_Org_ID))
	   UNION ALL select level+1, tr.name, ad_org.name, tn.node_id
	 from ad_tree t
	 join ad_treenode tn on t.ad_tree_id=tn.ad_tree_id
	 join ad_org on tn.node_id=ad_org.ad_org_id
	 join tr on tr.ad_org_id=tn.parent_id 
			where tn.node_id=p_AD_Org_ID)
	 select ad_org_id into v_ad_org_id from tr where ad_org_id=p_ad_org_id;
END IF;

   return v_ad_org_id=p_ad_org_id;
END;
/

SELECT register_migration_script('201603031539_IDEMPIERE-3046.sql') FROM dual
;

