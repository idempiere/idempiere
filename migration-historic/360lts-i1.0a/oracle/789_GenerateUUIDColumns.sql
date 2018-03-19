-- Mar 29, 2011 10:40:12 AM COT
-- UUID Generator
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54446,0,'A_Asset_UU',TO_DATE('2011-03-29 10:40:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Asset_UU','A_Asset_UU',TO_DATE('2011-03-29 10:40:11','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60352,54446,0,10,539,'A_Asset_UU',TO_DATE('2011-03-29 10:40:11','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Asset_UU',TO_DATE('2011-03-29 10:40:11','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Asset ADD A_Asset_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Asset_UU_idx ON a_asset(A_Asset_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54447,0,'A_Asset_Acct_UU',TO_DATE('2011-03-29 10:40:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Asset_Acct_UU','A_Asset_Acct_UU',TO_DATE('2011-03-29 10:40:14','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60353,54447,0,10,53123,'A_Asset_Acct_UU',TO_DATE('2011-03-29 10:40:14','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Asset_Acct_UU',TO_DATE('2011-03-29 10:40:14','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Asset_Acct ADD A_Asset_Acct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Asset_Acct_UU_idx ON a_asset_acct(A_Asset_Acct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54448,0,'A_Asset_Addition_UU',TO_DATE('2011-03-29 10:40:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Asset_Addition_UU','A_Asset_Addition_UU',TO_DATE('2011-03-29 10:40:16','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60354,54448,0,10,53137,'A_Asset_Addition_UU',TO_DATE('2011-03-29 10:40:16','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Asset_Addition_UU',TO_DATE('2011-03-29 10:40:16','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Asset_Addition ADD A_Asset_Addition_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Asset_Addition_UU_idx ON a_asset_addition(A_Asset_Addition_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54449,0,'A_Asset_Change_UU',TO_DATE('2011-03-29 10:40:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Asset_Change_UU','A_Asset_Change_UU',TO_DATE('2011-03-29 10:40:18','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60355,54449,0,10,53133,'A_Asset_Change_UU',TO_DATE('2011-03-29 10:40:18','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Asset_Change_UU',TO_DATE('2011-03-29 10:40:18','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Asset_Change ADD A_Asset_Change_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Asset_Change_UU_idx ON a_asset_change(A_Asset_Change_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54450,0,'A_Asset_Delivery_UU',TO_DATE('2011-03-29 10:40:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Asset_Delivery_UU','A_Asset_Delivery_UU',TO_DATE('2011-03-29 10:40:19','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60356,54450,0,10,541,'A_Asset_Delivery_UU',TO_DATE('2011-03-29 10:40:19','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Asset_Delivery_UU',TO_DATE('2011-03-29 10:40:19','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Asset_Delivery ADD A_Asset_Delivery_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Asset_Delivery_UU_idx ON a_asset_delivery(A_Asset_Delivery_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54451,0,'A_Asset_Disposed_UU',TO_DATE('2011-03-29 10:40:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Asset_Disposed_UU','A_Asset_Disposed_UU',TO_DATE('2011-03-29 10:40:21','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60357,54451,0,10,53127,'A_Asset_Disposed_UU',TO_DATE('2011-03-29 10:40:21','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Asset_Disposed_UU',TO_DATE('2011-03-29 10:40:21','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Asset_Disposed ADD A_Asset_Disposed_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Asset_Disposed_UU_idx ON a_asset_disposed(A_Asset_Disposed_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54452,0,'A_Asset_Group_UU',TO_DATE('2011-03-29 10:40:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Asset_Group_UU','A_Asset_Group_UU',TO_DATE('2011-03-29 10:40:22','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60358,54452,0,10,542,'A_Asset_Group_UU',TO_DATE('2011-03-29 10:40:22','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Asset_Group_UU',TO_DATE('2011-03-29 10:40:22','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Asset_Group ADD A_Asset_Group_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Asset_Group_UU_idx ON a_asset_group(A_Asset_Group_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54453,0,'A_Asset_Group_Acct_UU',TO_DATE('2011-03-29 10:40:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Asset_Group_Acct_UU','A_Asset_Group_Acct_UU',TO_DATE('2011-03-29 10:40:24','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60359,54453,0,10,53130,'A_Asset_Group_Acct_UU',TO_DATE('2011-03-29 10:40:24','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Asset_Group_Acct_UU',TO_DATE('2011-03-29 10:40:24','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Asset_Group_Acct ADD A_Asset_Group_Acct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Asset_Group_Acct_UU_idx ON a_asset_group_acct(A_Asset_Group_Acct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54454,0,'A_Asset_Info_Fin_UU',TO_DATE('2011-03-29 10:40:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Asset_Info_Fin_UU','A_Asset_Info_Fin_UU',TO_DATE('2011-03-29 10:40:26','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60360,54454,0,10,53132,'A_Asset_Info_Fin_UU',TO_DATE('2011-03-29 10:40:26','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Asset_Info_Fin_UU',TO_DATE('2011-03-29 10:40:26','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Asset_Info_Fin ADD A_Asset_Info_Fin_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Asset_Info_Fin_UU_idx ON a_asset_info_fin(A_Asset_Info_Fin_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54455,0,'A_Asset_Info_Ins_UU',TO_DATE('2011-03-29 10:40:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Asset_Info_Ins_UU','A_Asset_Info_Ins_UU',TO_DATE('2011-03-29 10:40:27','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60361,54455,0,10,53135,'A_Asset_Info_Ins_UU',TO_DATE('2011-03-29 10:40:27','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Asset_Info_Ins_UU',TO_DATE('2011-03-29 10:40:27','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Asset_Info_Ins ADD A_Asset_Info_Ins_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Asset_Info_Ins_UU_idx ON a_asset_info_ins(A_Asset_Info_Ins_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54456,0,'A_Asset_Info_Lic_UU',TO_DATE('2011-03-29 10:40:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Asset_Info_Lic_UU','A_Asset_Info_Lic_UU',TO_DATE('2011-03-29 10:40:29','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60362,54456,0,10,53134,'A_Asset_Info_Lic_UU',TO_DATE('2011-03-29 10:40:29','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Asset_Info_Lic_UU',TO_DATE('2011-03-29 10:40:29','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Asset_Info_Lic ADD A_Asset_Info_Lic_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Asset_Info_Lic_UU_idx ON a_asset_info_lic(A_Asset_Info_Lic_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54457,0,'A_Asset_Info_Oth_UU',TO_DATE('2011-03-29 10:40:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Asset_Info_Oth_UU','A_Asset_Info_Oth_UU',TO_DATE('2011-03-29 10:40:31','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60363,54457,0,10,53136,'A_Asset_Info_Oth_UU',TO_DATE('2011-03-29 10:40:31','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Asset_Info_Oth_UU',TO_DATE('2011-03-29 10:40:31','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Asset_Info_Oth ADD A_Asset_Info_Oth_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Asset_Info_Oth_UU_idx ON a_asset_info_oth(A_Asset_Info_Oth_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54458,0,'A_Asset_Info_Tax_UU',TO_DATE('2011-03-29 10:40:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Asset_Info_Tax_UU','A_Asset_Info_Tax_UU',TO_DATE('2011-03-29 10:40:32','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60364,54458,0,10,53131,'A_Asset_Info_Tax_UU',TO_DATE('2011-03-29 10:40:32','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Asset_Info_Tax_UU',TO_DATE('2011-03-29 10:40:32','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Asset_Info_Tax ADD A_Asset_Info_Tax_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Asset_Info_Tax_UU_idx ON a_asset_info_tax(A_Asset_Info_Tax_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54459,0,'A_Asset_Retirement_UU',TO_DATE('2011-03-29 10:40:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Asset_Retirement_UU','A_Asset_Retirement_UU',TO_DATE('2011-03-29 10:40:37','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60365,54459,0,10,540,'A_Asset_Retirement_UU',TO_DATE('2011-03-29 10:40:37','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Asset_Retirement_UU',TO_DATE('2011-03-29 10:40:37','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Asset_Retirement ADD A_Asset_Retirement_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Asset_Retirement_UU_idx ON a_asset_retirement(A_Asset_Retirement_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54460,0,'A_Asset_Reval_Entry_UU',TO_DATE('2011-03-29 10:40:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Asset_Reval_Entry_UU','A_Asset_Reval_Entry_UU',TO_DATE('2011-03-29 10:40:39','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60366,54460,0,10,53119,'A_Asset_Reval_Entry_UU',TO_DATE('2011-03-29 10:40:39','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Asset_Reval_Entry_UU',TO_DATE('2011-03-29 10:40:39','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Asset_Reval_Entry ADD A_Asset_Reval_Entry_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Asset_Reval_Entry_UU_idx ON a_asset_reval_entry(A_Asset_Reval_Entry_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54461,0,'A_Asset_Reval_Index_UU',TO_DATE('2011-03-29 10:40:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Asset_Reval_Index_UU','A_Asset_Reval_Index_UU',TO_DATE('2011-03-29 10:40:40','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60367,54461,0,10,53120,'A_Asset_Reval_Index_UU',TO_DATE('2011-03-29 10:40:40','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Asset_Reval_Index_UU',TO_DATE('2011-03-29 10:40:40','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Asset_Reval_Index ADD A_Asset_Reval_Index_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Asset_Reval_Index_UU_idx ON a_asset_reval_index(A_Asset_Reval_Index_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54462,0,'A_Asset_Split_UU',TO_DATE('2011-03-29 10:40:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Asset_Split_UU','A_Asset_Split_UU',TO_DATE('2011-03-29 10:40:42','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60368,54462,0,10,53122,'A_Asset_Split_UU',TO_DATE('2011-03-29 10:40:42','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Asset_Split_UU',TO_DATE('2011-03-29 10:40:42','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Asset_Split ADD A_Asset_Split_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Asset_Split_UU_idx ON a_asset_split(A_Asset_Split_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54463,0,'A_Asset_Spread_UU',TO_DATE('2011-03-29 10:40:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Asset_Spread_UU','A_Asset_Spread_UU',TO_DATE('2011-03-29 10:40:44','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60369,54463,0,10,53126,'A_Asset_Spread_UU',TO_DATE('2011-03-29 10:40:44','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Asset_Spread_UU',TO_DATE('2011-03-29 10:40:44','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Asset_Spread ADD A_Asset_Spread_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Asset_Spread_UU_idx ON a_asset_spread(A_Asset_Spread_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54464,0,'A_Asset_Transfer_UU',TO_DATE('2011-03-29 10:40:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Asset_Transfer_UU','A_Asset_Transfer_UU',TO_DATE('2011-03-29 10:40:45','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60370,54464,0,10,53128,'A_Asset_Transfer_UU',TO_DATE('2011-03-29 10:40:45','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Asset_Transfer_UU',TO_DATE('2011-03-29 10:40:45','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Asset_Transfer ADD A_Asset_Transfer_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Asset_Transfer_UU_idx ON a_asset_transfer(A_Asset_Transfer_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54465,0,'A_Asset_Use_UU',TO_DATE('2011-03-29 10:40:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Asset_Use_UU','A_Asset_Use_UU',TO_DATE('2011-03-29 10:40:47','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60371,54465,0,10,53138,'A_Asset_Use_UU',TO_DATE('2011-03-29 10:40:47','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Asset_Use_UU',TO_DATE('2011-03-29 10:40:47','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Asset_Use ADD A_Asset_Use_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Asset_Use_UU_idx ON a_asset_use(A_Asset_Use_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54466,0,'AD_AccessLog_UU',TO_DATE('2011-03-29 10:40:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_AccessLog_UU','AD_AccessLog_UU',TO_DATE('2011-03-29 10:40:48','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60372,54466,0,10,717,'AD_AccessLog_UU',TO_DATE('2011-03-29 10:40:48','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_AccessLog_UU',TO_DATE('2011-03-29 10:40:48','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_AccessLog ADD AD_AccessLog_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_AccessLog_UU_idx ON ad_accesslog(AD_AccessLog_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54467,0,'AD_Alert_UU',TO_DATE('2011-03-29 10:40:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Alert_UU','AD_Alert_UU',TO_DATE('2011-03-29 10:40:50','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60373,54467,0,10,594,'AD_Alert_UU',TO_DATE('2011-03-29 10:40:50','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Alert_UU',TO_DATE('2011-03-29 10:40:50','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Alert ADD AD_Alert_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Alert_UU_idx ON ad_alert(AD_Alert_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54468,0,'AD_AlertProcessor_UU',TO_DATE('2011-03-29 10:40:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_AlertProcessor_UU','AD_AlertProcessor_UU',TO_DATE('2011-03-29 10:40:52','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60374,54468,0,10,700,'AD_AlertProcessor_UU',TO_DATE('2011-03-29 10:40:52','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_AlertProcessor_UU',TO_DATE('2011-03-29 10:40:52','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_AlertProcessor ADD AD_AlertProcessor_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_AlertProcessor_UU_idx ON ad_alertprocessor(AD_AlertProcessor_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54469,0,'AD_AlertProcessorLog_UU',TO_DATE('2011-03-29 10:40:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_AlertProcessorLog_UU','AD_AlertProcessorLog_UU',TO_DATE('2011-03-29 10:40:53','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60375,54469,0,10,699,'AD_AlertProcessorLog_UU',TO_DATE('2011-03-29 10:40:53','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_AlertProcessorLog_UU',TO_DATE('2011-03-29 10:40:53','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_AlertProcessorLog ADD AD_AlertProcessorLog_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_AlertProcessorLog_UU_idx ON ad_alertprocessorlog(AD_AlertProcessorLog_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54470,0,'AD_AlertRecipient_UU',TO_DATE('2011-03-29 10:40:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_AlertRecipient_UU','AD_AlertRecipient_UU',TO_DATE('2011-03-29 10:40:55','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60376,54470,0,10,592,'AD_AlertRecipient_UU',TO_DATE('2011-03-29 10:40:55','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_AlertRecipient_UU',TO_DATE('2011-03-29 10:40:55','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_AlertRecipient ADD AD_AlertRecipient_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_AlertRecipient_UU_idx ON ad_alertrecipient(AD_AlertRecipient_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54471,0,'AD_AlertRule_UU',TO_DATE('2011-03-29 10:40:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_AlertRule_UU','AD_AlertRule_UU',TO_DATE('2011-03-29 10:40:56','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60377,54471,0,10,593,'AD_AlertRule_UU',TO_DATE('2011-03-29 10:40:56','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_AlertRule_UU',TO_DATE('2011-03-29 10:40:56','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_AlertRule ADD AD_AlertRule_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_AlertRule_UU_idx ON ad_alertrule(AD_AlertRule_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54472,0,'AD_Archive_UU',TO_DATE('2011-03-29 10:40:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Archive_UU','AD_Archive_UU',TO_DATE('2011-03-29 10:40:58','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60378,54472,0,10,754,'AD_Archive_UU',TO_DATE('2011-03-29 10:40:58','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Archive_UU',TO_DATE('2011-03-29 10:40:58','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Archive ADD AD_Archive_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Archive_UU_idx ON ad_archive(AD_Archive_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54473,0,'AD_Attachment_UU',TO_DATE('2011-03-29 10:41:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Attachment_UU','AD_Attachment_UU',TO_DATE('2011-03-29 10:41:00','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60379,54473,0,10,254,'AD_Attachment_UU',TO_DATE('2011-03-29 10:41:00','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Attachment_UU',TO_DATE('2011-03-29 10:41:00','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Attachment ADD AD_Attachment_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Attachment_UU_idx ON ad_attachment(AD_Attachment_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54474,0,'AD_AttachmentNote_UU',TO_DATE('2011-03-29 10:41:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_AttachmentNote_UU','AD_AttachmentNote_UU',TO_DATE('2011-03-29 10:41:02','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60380,54474,0,10,705,'AD_AttachmentNote_UU',TO_DATE('2011-03-29 10:41:02','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_AttachmentNote_UU',TO_DATE('2011-03-29 10:41:02','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_AttachmentNote ADD AD_AttachmentNote_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_AttachmentNote_UU_idx ON ad_attachmentnote(AD_AttachmentNote_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54475,0,'AD_Attribute_UU',TO_DATE('2011-03-29 10:41:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Attribute_UU','AD_Attribute_UU',TO_DATE('2011-03-29 10:41:03','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60381,54475,0,10,405,'AD_Attribute_UU',TO_DATE('2011-03-29 10:41:03','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Attribute_UU',TO_DATE('2011-03-29 10:41:03','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Attribute ADD AD_Attribute_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Attribute_UU_idx ON ad_attribute(AD_Attribute_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54476,0,'AD_Attribute_Value_UU',TO_DATE('2011-03-29 10:41:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Attribute_Value_UU','AD_Attribute_Value_UU',TO_DATE('2011-03-29 10:41:05','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60382,54476,0,10,406,'AD_Attribute_Value_UU',TO_DATE('2011-03-29 10:41:05','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Attribute_Value_UU',TO_DATE('2011-03-29 10:41:05','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Attribute_Value ADD AD_Attribute_Value_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Attribute_Value_UU_idx ON ad_attribute_value(AD_Attribute_Value_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54477,0,'AD_ChangeLog_UU',TO_DATE('2011-03-29 10:41:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_ChangeLog_UU','AD_ChangeLog_UU',TO_DATE('2011-03-29 10:41:07','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60383,54477,0,10,580,'AD_ChangeLog_UU',TO_DATE('2011-03-29 10:41:07','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_ChangeLog_UU',TO_DATE('2011-03-29 10:41:07','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_ChangeLog ADD AD_ChangeLog_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_ChangeLog_UU_idx ON ad_changelog(AD_ChangeLog_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54478,0,'AD_Client_UU',TO_DATE('2011-03-29 10:41:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Client_UU','AD_Client_UU',TO_DATE('2011-03-29 10:41:08','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60384,54478,0,10,112,'AD_Client_UU',TO_DATE('2011-03-29 10:41:08','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Client_UU',TO_DATE('2011-03-29 10:41:08','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Client ADD AD_Client_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Client_UU_idx ON ad_client(AD_Client_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54479,0,'AD_ClientInfo_UU',TO_DATE('2011-03-29 10:41:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_ClientInfo_UU','AD_ClientInfo_UU',TO_DATE('2011-03-29 10:41:10','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60385,54479,0,10,227,'AD_ClientInfo_UU',TO_DATE('2011-03-29 10:41:10','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_ClientInfo_UU',TO_DATE('2011-03-29 10:41:10','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_ClientInfo ADD AD_ClientInfo_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_ClientInfo_UU_idx ON ad_clientinfo(AD_ClientInfo_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54480,0,'AD_ClientShare_UU',TO_DATE('2011-03-29 10:41:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_ClientShare_UU','AD_ClientShare_UU',TO_DATE('2011-03-29 10:41:11','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60386,54480,0,10,827,'AD_ClientShare_UU',TO_DATE('2011-03-29 10:41:11','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_ClientShare_UU',TO_DATE('2011-03-29 10:41:11','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_ClientShare ADD AD_ClientShare_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_ClientShare_UU_idx ON ad_clientshare(AD_ClientShare_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54481,0,'AD_Color_UU',TO_DATE('2011-03-29 10:41:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Color_UU','AD_Color_UU',TO_DATE('2011-03-29 10:41:12','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60387,54481,0,10,457,'AD_Color_UU',TO_DATE('2011-03-29 10:41:12','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Color_UU',TO_DATE('2011-03-29 10:41:12','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Color ADD AD_Color_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Color_UU_idx ON ad_color(AD_Color_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54482,0,'AD_Column_UU',TO_DATE('2011-03-29 10:41:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Column_UU','AD_Column_UU',TO_DATE('2011-03-29 10:41:15','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60388,54482,0,10,101,'AD_Column_UU',TO_DATE('2011-03-29 10:41:15','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Column_UU',TO_DATE('2011-03-29 10:41:15','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Column ADD AD_Column_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Column_UU_idx ON ad_column(AD_Column_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54483,0,'AD_Column_Access_UU',TO_DATE('2011-03-29 10:41:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Column_Access_UU','AD_Column_Access_UU',TO_DATE('2011-03-29 10:41:17','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60389,54483,0,10,571,'AD_Column_Access_UU',TO_DATE('2011-03-29 10:41:17','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Column_Access_UU',TO_DATE('2011-03-29 10:41:17','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Column_Access ADD AD_Column_Access_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Column_Access_UU_idx ON ad_column_access(AD_Column_Access_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54484,0,'AD_Column_Trl_UU',TO_DATE('2011-03-29 10:41:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Column_Trl_UU','AD_Column_Trl_UU',TO_DATE('2011-03-29 10:41:19','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60390,54484,0,10,752,'AD_Column_Trl_UU',TO_DATE('2011-03-29 10:41:19','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Column_Trl_UU',TO_DATE('2011-03-29 10:41:19','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Column_Trl MODIFY AD_Column_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Column_Trl_UU_idx ON ad_column_trl(AD_Column_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54485,0,'AD_Desktop_UU',TO_DATE('2011-03-29 10:41:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Desktop_UU','AD_Desktop_UU',TO_DATE('2011-03-29 10:41:21','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60391,54485,0,10,458,'AD_Desktop_UU',TO_DATE('2011-03-29 10:41:21','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Desktop_UU',TO_DATE('2011-03-29 10:41:21','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Desktop ADD AD_Desktop_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Desktop_UU_idx ON ad_desktop(AD_Desktop_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54486,0,'AD_Desktop_Trl_UU',TO_DATE('2011-03-29 10:41:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Desktop_Trl_UU','AD_Desktop_Trl_UU',TO_DATE('2011-03-29 10:41:24','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60392,54486,0,10,460,'AD_Desktop_Trl_UU',TO_DATE('2011-03-29 10:41:24','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Desktop_Trl_UU',TO_DATE('2011-03-29 10:41:24','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Desktop_Trl ADD AD_Desktop_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Desktop_Trl_UU_idx ON ad_desktop_trl(AD_Desktop_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54487,0,'AD_DesktopWorkbench_UU',TO_DATE('2011-03-29 10:41:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_DesktopWorkbench_UU','AD_DesktopWorkbench_UU',TO_DATE('2011-03-29 10:41:25','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60393,54487,0,10,459,'AD_DesktopWorkbench_UU',TO_DATE('2011-03-29 10:41:25','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_DesktopWorkbench_UU',TO_DATE('2011-03-29 10:41:25','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_DesktopWorkbench ADD AD_DesktopWorkbench_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_DesktopWorkbench_UU_idx ON ad_desktopworkbench(AD_DesktopWorkbench_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54488,0,'AD_Document_Action_Access_UU',TO_DATE('2011-03-29 10:41:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Document_Action_Access_UU','AD_Document_Action_Access_UU',TO_DATE('2011-03-29 10:41:26','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60394,54488,0,10,53012,'AD_Document_Action_Access_UU',TO_DATE('2011-03-29 10:41:26','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Document_Action_Access_UU',TO_DATE('2011-03-29 10:41:26','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Document_Action_Access ADD AD_Document_Action_Access_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Document_Action_Acce_UU_idx ON ad_document_action_access(AD_Document_Action_Access_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54489,0,'AD_Element_UU',TO_DATE('2011-03-29 10:41:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Element_UU','AD_Element_UU',TO_DATE('2011-03-29 10:41:28','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60395,54489,0,10,276,'AD_Element_UU',TO_DATE('2011-03-29 10:41:28','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Element_UU',TO_DATE('2011-03-29 10:41:28','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Element ADD AD_Element_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Element_UU_idx ON ad_element(AD_Element_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54490,0,'AD_Element_Trl_UU',TO_DATE('2011-03-29 10:41:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Element_Trl_UU','AD_Element_Trl_UU',TO_DATE('2011-03-29 10:41:29','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60396,54490,0,10,277,'AD_Element_Trl_UU',TO_DATE('2011-03-29 10:41:29','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Element_Trl_UU',TO_DATE('2011-03-29 10:41:29','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Element_Trl ADD AD_Element_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Element_Trl_UU_idx ON ad_element_trl(AD_Element_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54491,0,'AD_EntityType_UU',TO_DATE('2011-03-29 10:41:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_EntityType_UU','AD_EntityType_UU',TO_DATE('2011-03-29 10:41:31','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60397,54491,0,10,882,'AD_EntityType_UU',TO_DATE('2011-03-29 10:41:31','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_EntityType_UU',TO_DATE('2011-03-29 10:41:31','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_EntityType ADD AD_EntityType_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_EntityType_UU_idx ON ad_entitytype(AD_EntityType_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54492,0,'A_Depreciation_UU',TO_DATE('2011-03-29 10:41:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Depreciation_UU','A_Depreciation_UU',TO_DATE('2011-03-29 10:41:33','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60398,54492,0,10,53112,'A_Depreciation_UU',TO_DATE('2011-03-29 10:41:33','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Depreciation_UU',TO_DATE('2011-03-29 10:41:33','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Depreciation ADD A_Depreciation_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Depreciation_UU_idx ON a_depreciation(A_Depreciation_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54493,0,'A_Depreciation_Build_UU',TO_DATE('2011-03-29 10:41:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Depreciation_Build_UU','A_Depreciation_Build_UU',TO_DATE('2011-03-29 10:41:34','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60399,54493,0,10,53129,'A_Depreciation_Build_UU',TO_DATE('2011-03-29 10:41:34','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Depreciation_Build_UU',TO_DATE('2011-03-29 10:41:34','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Depreciation_Build ADD A_Depreciation_Build_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Depreciation_Build_UU_idx ON a_depreciation_build(A_Depreciation_Build_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54494,0,'A_Depreciation_Convention_UU',TO_DATE('2011-03-29 10:41:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Depreciation_Convention_UU','A_Depreciation_Convention_UU',TO_DATE('2011-03-29 10:41:36','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60400,54494,0,10,53125,'A_Depreciation_Convention_UU',TO_DATE('2011-03-29 10:41:36','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Depreciation_Convention_UU',TO_DATE('2011-03-29 10:41:36','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Depreciation_Convention ADD A_Depreciation_Convention_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Depreciation_Conventi_UU_idx ON a_depreciation_convention(A_Depreciation_Convention_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54495,0,'A_Depreciation_Entry_UU',TO_DATE('2011-03-29 10:41:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Depreciation_Entry_UU','A_Depreciation_Entry_UU',TO_DATE('2011-03-29 10:41:37','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60401,54495,0,10,53121,'A_Depreciation_Entry_UU',TO_DATE('2011-03-29 10:41:37','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Depreciation_Entry_UU',TO_DATE('2011-03-29 10:41:37','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Depreciation_Entry ADD A_Depreciation_Entry_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Depreciation_Entry_UU_idx ON a_depreciation_entry(A_Depreciation_Entry_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54496,0,'A_Depreciation_Exp_UU',TO_DATE('2011-03-29 10:41:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Depreciation_Exp_UU','A_Depreciation_Exp_UU',TO_DATE('2011-03-29 10:41:38','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60402,54496,0,10,53115,'A_Depreciation_Exp_UU',TO_DATE('2011-03-29 10:41:38','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Depreciation_Exp_UU',TO_DATE('2011-03-29 10:41:38','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Depreciation_Exp ADD A_Depreciation_Exp_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Depreciation_Exp_UU_idx ON a_depreciation_exp(A_Depreciation_Exp_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54497,0,'A_Depreciation_Forecast_UU',TO_DATE('2011-03-29 10:41:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Depreciation_Forecast_UU','A_Depreciation_Forecast_UU',TO_DATE('2011-03-29 10:41:40','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60403,54497,0,10,53118,'A_Depreciation_Forecast_UU',TO_DATE('2011-03-29 10:41:40','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Depreciation_Forecast_UU',TO_DATE('2011-03-29 10:41:40','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Depreciation_Forecast ADD A_Depreciation_Forecast_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Depreciation_Forecast_UU_idx ON a_depreciation_forecast(A_Depreciation_Forecast_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54498,0,'A_Depreciation_Method_UU',TO_DATE('2011-03-29 10:41:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Depreciation_Method_UU','A_Depreciation_Method_UU',TO_DATE('2011-03-29 10:41:44','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60404,54498,0,10,53124,'A_Depreciation_Method_UU',TO_DATE('2011-03-29 10:41:44','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Depreciation_Method_UU',TO_DATE('2011-03-29 10:41:44','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Depreciation_Method ADD A_Depreciation_Method_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Depreciation_Method_UU_idx ON a_depreciation_method(A_Depreciation_Method_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54499,0,'A_Depreciation_Table_Detail_UU',TO_DATE('2011-03-29 10:41:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Depreciation_Table_Detail_UU','A_Depreciation_Table_Detail_UU',TO_DATE('2011-03-29 10:41:46','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60405,54499,0,10,53113,'A_Depreciation_Table_Detail_UU',TO_DATE('2011-03-29 10:41:45','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Depreciation_Table_Detail_UU',TO_DATE('2011-03-29 10:41:45','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Depreciation_Table_Detail ADD A_Depreciation_Table_Detail_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Depreciation_Table_De_UU_idx ON a_depreciation_table_detail(A_Depreciation_Table_Detail_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54500,0,'A_Depreciation_Table_Header_UU',TO_DATE('2011-03-29 10:41:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Depreciation_Table_Header_UU','A_Depreciation_Table_Header_UU',TO_DATE('2011-03-29 10:41:50','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60406,54500,0,10,53114,'A_Depreciation_Table_Header_UU',TO_DATE('2011-03-29 10:41:50','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Depreciation_Table_Header_UU',TO_DATE('2011-03-29 10:41:50','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Depreciation_Table_Header ADD A_Depreciation_Table_Header_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Depreciation_Table_He_UU_idx ON a_depreciation_table_header(A_Depreciation_Table_Header_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54501,0,'A_Depreciation_Workfile_UU',TO_DATE('2011-03-29 10:41:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Depreciation_Workfile_UU','A_Depreciation_Workfile_UU',TO_DATE('2011-03-29 10:41:51','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60407,54501,0,10,53116,'A_Depreciation_Workfile_UU',TO_DATE('2011-03-29 10:41:51','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Depreciation_Workfile_UU',TO_DATE('2011-03-29 10:41:51','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Depreciation_Workfile ADD A_Depreciation_Workfile_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Depreciation_Workfile_UU_idx ON a_depreciation_workfile(A_Depreciation_Workfile_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54502,0,'AD_Error_UU',TO_DATE('2011-03-29 10:41:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Error_UU','AD_Error_UU',TO_DATE('2011-03-29 10:41:53','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60408,54502,0,10,380,'AD_Error_UU',TO_DATE('2011-03-29 10:41:53','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Error_UU',TO_DATE('2011-03-29 10:41:53','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Error ADD AD_Error_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Error_UU_idx ON ad_error(AD_Error_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54503,0,'AD_Field_UU',TO_DATE('2011-03-29 10:41:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Field_UU','AD_Field_UU',TO_DATE('2011-03-29 10:41:55','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60409,54503,0,10,107,'AD_Field_UU',TO_DATE('2011-03-29 10:41:55','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Field_UU',TO_DATE('2011-03-29 10:41:55','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Field ADD AD_Field_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Field_UU_idx ON ad_field(AD_Field_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54504,0,'AD_FieldGroup_UU',TO_DATE('2011-03-29 10:41:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_FieldGroup_UU','AD_FieldGroup_UU',TO_DATE('2011-03-29 10:41:57','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60410,54504,0,10,414,'AD_FieldGroup_UU',TO_DATE('2011-03-29 10:41:57','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_FieldGroup_UU',TO_DATE('2011-03-29 10:41:57','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_FieldGroup ADD AD_FieldGroup_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_FieldGroup_UU_idx ON ad_fieldgroup(AD_FieldGroup_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54505,0,'AD_FieldGroup_Trl_UU',TO_DATE('2011-03-29 10:41:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_FieldGroup_Trl_UU','AD_FieldGroup_Trl_UU',TO_DATE('2011-03-29 10:41:59','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60411,54505,0,10,415,'AD_FieldGroup_Trl_UU',TO_DATE('2011-03-29 10:41:59','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_FieldGroup_Trl_UU',TO_DATE('2011-03-29 10:41:59','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_FieldGroup_Trl ADD AD_FieldGroup_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_FieldGroup_Trl_UU_idx ON ad_fieldgroup_trl(AD_FieldGroup_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54506,0,'AD_Field_Trl_UU',TO_DATE('2011-03-29 10:42:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Field_Trl_UU','AD_Field_Trl_UU',TO_DATE('2011-03-29 10:42:00','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60412,54506,0,10,127,'AD_Field_Trl_UU',TO_DATE('2011-03-29 10:42:00','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Field_Trl_UU',TO_DATE('2011-03-29 10:42:00','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Field_Trl ADD AD_Field_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Field_Trl_UU_idx ON ad_field_trl(AD_Field_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54507,0,'AD_Find_UU',TO_DATE('2011-03-29 10:42:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Find_UU','AD_Find_UU',TO_DATE('2011-03-29 10:42:02','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60413,54507,0,10,404,'AD_Find_UU',TO_DATE('2011-03-29 10:42:02','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Find_UU',TO_DATE('2011-03-29 10:42:02','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Find ADD AD_Find_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Find_UU_idx ON ad_find(AD_Find_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54508,0,'AD_Form_UU',TO_DATE('2011-03-29 10:42:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Form_UU','AD_Form_UU',TO_DATE('2011-03-29 10:42:04','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60414,54508,0,10,376,'AD_Form_UU',TO_DATE('2011-03-29 10:42:04','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Form_UU',TO_DATE('2011-03-29 10:42:04','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Form ADD AD_Form_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Form_UU_idx ON ad_form(AD_Form_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54509,0,'AD_Form_Access_UU',TO_DATE('2011-03-29 10:42:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Form_Access_UU','AD_Form_Access_UU',TO_DATE('2011-03-29 10:42:05','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60415,54509,0,10,378,'AD_Form_Access_UU',TO_DATE('2011-03-29 10:42:05','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Form_Access_UU',TO_DATE('2011-03-29 10:42:05','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Form_Access ADD AD_Form_Access_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Form_Access_UU_idx ON ad_form_access(AD_Form_Access_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54510,0,'AD_Form_Trl_UU',TO_DATE('2011-03-29 10:42:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Form_Trl_UU','AD_Form_Trl_UU',TO_DATE('2011-03-29 10:42:07','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60416,54510,0,10,377,'AD_Form_Trl_UU',TO_DATE('2011-03-29 10:42:07','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Form_Trl_UU',TO_DATE('2011-03-29 10:42:07','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Form_Trl ADD AD_Form_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Form_Trl_UU_idx ON ad_form_trl(AD_Form_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54511,0,'AD_HouseKeeping_UU',TO_DATE('2011-03-29 10:42:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_HouseKeeping_UU','AD_HouseKeeping_UU',TO_DATE('2011-03-29 10:42:09','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60417,54511,0,10,53147,'AD_HouseKeeping_UU',TO_DATE('2011-03-29 10:42:09','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_HouseKeeping_UU',TO_DATE('2011-03-29 10:42:09','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_HouseKeeping ADD AD_HouseKeeping_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_HouseKeeping_UU_idx ON ad_housekeeping(AD_HouseKeeping_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54512,0,'AD_Image_UU',TO_DATE('2011-03-29 10:42:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Image_UU','AD_Image_UU',TO_DATE('2011-03-29 10:42:13','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60418,54512,0,10,461,'AD_Image_UU',TO_DATE('2011-03-29 10:42:13','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Image_UU',TO_DATE('2011-03-29 10:42:13','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Image ADD AD_Image_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Image_UU_idx ON ad_image(AD_Image_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54513,0,'AD_ImpFormat_UU',TO_DATE('2011-03-29 10:42:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_ImpFormat_UU','AD_ImpFormat_UU',TO_DATE('2011-03-29 10:42:14','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60419,54513,0,10,381,'AD_ImpFormat_UU',TO_DATE('2011-03-29 10:42:14','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_ImpFormat_UU',TO_DATE('2011-03-29 10:42:14','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_ImpFormat ADD AD_ImpFormat_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_ImpFormat_UU_idx ON ad_impformat(AD_ImpFormat_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54514,0,'AD_ImpFormat_Row_UU',TO_DATE('2011-03-29 10:42:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_ImpFormat_Row_UU','AD_ImpFormat_Row_UU',TO_DATE('2011-03-29 10:42:16','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60420,54514,0,10,382,'AD_ImpFormat_Row_UU',TO_DATE('2011-03-29 10:42:16','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_ImpFormat_Row_UU',TO_DATE('2011-03-29 10:42:16','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_ImpFormat_Row ADD AD_ImpFormat_Row_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_ImpFormat_Row_UU_idx ON ad_impformat_row(AD_ImpFormat_Row_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54515,0,'AD_InfoColumn_UU',TO_DATE('2011-03-29 10:42:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_InfoColumn_UU','AD_InfoColumn_UU',TO_DATE('2011-03-29 10:42:18','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60421,54515,0,10,897,'AD_InfoColumn_UU',TO_DATE('2011-03-29 10:42:18','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_InfoColumn_UU',TO_DATE('2011-03-29 10:42:18','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_InfoColumn ADD AD_InfoColumn_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_InfoColumn_UU_idx ON ad_infocolumn(AD_InfoColumn_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54516,0,'AD_InfoColumn_Trl_UU',TO_DATE('2011-03-29 10:42:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_InfoColumn_Trl_UU','AD_InfoColumn_Trl_UU',TO_DATE('2011-03-29 10:42:20','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60422,54516,0,10,898,'AD_InfoColumn_Trl_UU',TO_DATE('2011-03-29 10:42:20','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_InfoColumn_Trl_UU',TO_DATE('2011-03-29 10:42:20','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_InfoColumn_Trl ADD AD_InfoColumn_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_InfoColumn_Trl_UU_idx ON ad_infocolumn_trl(AD_InfoColumn_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54517,0,'AD_InfoWindow_UU',TO_DATE('2011-03-29 10:42:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_InfoWindow_UU','AD_InfoWindow_UU',TO_DATE('2011-03-29 10:42:21','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60423,54517,0,10,895,'AD_InfoWindow_UU',TO_DATE('2011-03-29 10:42:21','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_InfoWindow_UU',TO_DATE('2011-03-29 10:42:21','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_InfoWindow ADD AD_InfoWindow_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_InfoWindow_UU_idx ON ad_infowindow(AD_InfoWindow_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54518,0,'AD_InfoWindow_Trl_UU',TO_DATE('2011-03-29 10:42:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_InfoWindow_Trl_UU','AD_InfoWindow_Trl_UU',TO_DATE('2011-03-29 10:42:23','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60424,54518,0,10,896,'AD_InfoWindow_Trl_UU',TO_DATE('2011-03-29 10:42:23','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_InfoWindow_Trl_UU',TO_DATE('2011-03-29 10:42:23','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_InfoWindow_Trl ADD AD_InfoWindow_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_InfoWindow_Trl_UU_idx ON ad_infowindow_trl(AD_InfoWindow_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54519,0,'AD_Issue_UU',TO_DATE('2011-03-29 10:42:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Issue_UU','AD_Issue_UU',TO_DATE('2011-03-29 10:42:25','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60425,54519,0,10,828,'AD_Issue_UU',TO_DATE('2011-03-29 10:42:25','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Issue_UU',TO_DATE('2011-03-29 10:42:25','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Issue ADD AD_Issue_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Issue_UU_idx ON ad_issue(AD_Issue_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54520,0,'AD_LabelPrinter_UU',TO_DATE('2011-03-29 10:42:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_LabelPrinter_UU','AD_LabelPrinter_UU',TO_DATE('2011-03-29 10:42:26','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60426,54520,0,10,626,'AD_LabelPrinter_UU',TO_DATE('2011-03-29 10:42:26','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_LabelPrinter_UU',TO_DATE('2011-03-29 10:42:26','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_LabelPrinter ADD AD_LabelPrinter_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_LabelPrinter_UU_idx ON ad_labelprinter(AD_LabelPrinter_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54521,0,'AD_LabelPrinterFunction_UU',TO_DATE('2011-03-29 10:42:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_LabelPrinterFunction_UU','AD_LabelPrinterFunction_UU',TO_DATE('2011-03-29 10:42:27','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60427,54521,0,10,624,'AD_LabelPrinterFunction_UU',TO_DATE('2011-03-29 10:42:27','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_LabelPrinterFunction_UU',TO_DATE('2011-03-29 10:42:27','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_LabelPrinterFunction ADD AD_LabelPrinterFunction_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_LabelPrinterFunction_UU_idx ON ad_labelprinterfunction(AD_LabelPrinterFunction_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54522,0,'AD_Language_UU',TO_DATE('2011-03-29 10:42:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Language_UU','AD_Language_UU',TO_DATE('2011-03-29 10:42:29','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60428,54522,0,10,111,'AD_Language_UU',TO_DATE('2011-03-29 10:42:29','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Language_UU',TO_DATE('2011-03-29 10:42:29','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Language ADD AD_Language_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Language_UU_idx ON ad_language(AD_Language_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54523,0,'AD_LdapAccess_UU',TO_DATE('2011-03-29 10:42:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_LdapAccess_UU','AD_LdapAccess_UU',TO_DATE('2011-03-29 10:42:31','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60429,54523,0,10,904,'AD_LdapAccess_UU',TO_DATE('2011-03-29 10:42:31','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_LdapAccess_UU',TO_DATE('2011-03-29 10:42:31','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_LdapAccess ADD AD_LdapAccess_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_LdapAccess_UU_idx ON ad_ldapaccess(AD_LdapAccess_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54524,0,'AD_LdapProcessor_UU',TO_DATE('2011-03-29 10:42:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_LdapProcessor_UU','AD_LdapProcessor_UU',TO_DATE('2011-03-29 10:42:33','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60430,54524,0,10,902,'AD_LdapProcessor_UU',TO_DATE('2011-03-29 10:42:33','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_LdapProcessor_UU',TO_DATE('2011-03-29 10:42:33','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_LdapProcessor ADD AD_LdapProcessor_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_LdapProcessor_UU_idx ON ad_ldapprocessor(AD_LdapProcessor_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54525,0,'AD_LdapProcessorLog_UU',TO_DATE('2011-03-29 10:42:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_LdapProcessorLog_UU','AD_LdapProcessorLog_UU',TO_DATE('2011-03-29 10:42:36','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60431,54525,0,10,903,'AD_LdapProcessorLog_UU',TO_DATE('2011-03-29 10:42:36','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_LdapProcessorLog_UU',TO_DATE('2011-03-29 10:42:36','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_LdapProcessorLog ADD AD_LdapProcessorLog_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_LdapProcessorLog_UU_idx ON ad_ldapprocessorlog(AD_LdapProcessorLog_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54526,0,'AD_Menu_UU',TO_DATE('2011-03-29 10:42:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Menu_UU','AD_Menu_UU',TO_DATE('2011-03-29 10:42:37','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60432,54526,0,10,116,'AD_Menu_UU',TO_DATE('2011-03-29 10:42:37','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Menu_UU',TO_DATE('2011-03-29 10:42:37','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Menu ADD AD_Menu_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Menu_UU_idx ON ad_menu(AD_Menu_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54527,0,'AD_Menu_Trl_UU',TO_DATE('2011-03-29 10:42:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Menu_Trl_UU','AD_Menu_Trl_UU',TO_DATE('2011-03-29 10:42:38','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60433,54527,0,10,120,'AD_Menu_Trl_UU',TO_DATE('2011-03-29 10:42:38','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Menu_Trl_UU',TO_DATE('2011-03-29 10:42:38','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Menu_Trl ADD AD_Menu_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Menu_Trl_UU_idx ON ad_menu_trl(AD_Menu_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54528,0,'AD_Message_UU',TO_DATE('2011-03-29 10:42:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Message_UU','AD_Message_UU',TO_DATE('2011-03-29 10:42:40','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60434,54528,0,10,109,'AD_Message_UU',TO_DATE('2011-03-29 10:42:40','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Message_UU',TO_DATE('2011-03-29 10:42:40','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Message ADD AD_Message_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Message_UU_idx ON ad_message(AD_Message_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54529,0,'AD_Message_Trl_UU',TO_DATE('2011-03-29 10:42:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Message_Trl_UU','AD_Message_Trl_UU',TO_DATE('2011-03-29 10:42:41','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60435,54529,0,10,119,'AD_Message_Trl_UU',TO_DATE('2011-03-29 10:42:41','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Message_Trl_UU',TO_DATE('2011-03-29 10:42:41','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Message_Trl ADD AD_Message_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Message_Trl_UU_idx ON ad_message_trl(AD_Message_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54530,0,'AD_MigrationScript_UU',TO_DATE('2011-03-29 10:42:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_MigrationScript_UU','AD_MigrationScript_UU',TO_DATE('2011-03-29 10:42:43','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60436,54530,0,10,53064,'AD_MigrationScript_UU',TO_DATE('2011-03-29 10:42:43','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_MigrationScript_UU',TO_DATE('2011-03-29 10:42:43','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_MigrationScript ADD AD_MigrationScript_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_MigrationScript_UU_idx ON ad_migrationscript(AD_MigrationScript_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54531,0,'AD_ModelValidator_UU',TO_DATE('2011-03-29 10:42:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_ModelValidator_UU','AD_ModelValidator_UU',TO_DATE('2011-03-29 10:42:45','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60437,54531,0,10,53014,'AD_ModelValidator_UU',TO_DATE('2011-03-29 10:42:45','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_ModelValidator_UU',TO_DATE('2011-03-29 10:42:45','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_ModelValidator ADD AD_ModelValidator_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_ModelValidator_UU_idx ON ad_modelvalidator(AD_ModelValidator_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54532,0,'AD_Modification_UU',TO_DATE('2011-03-29 10:42:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Modification_UU','AD_Modification_UU',TO_DATE('2011-03-29 10:42:46','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60438,54532,0,10,883,'AD_Modification_UU',TO_DATE('2011-03-29 10:42:46','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Modification_UU',TO_DATE('2011-03-29 10:42:46','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Modification ADD AD_Modification_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Modification_UU_idx ON ad_modification(AD_Modification_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54533,0,'AD_Note_UU',TO_DATE('2011-03-29 10:42:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Note_UU','AD_Note_UU',TO_DATE('2011-03-29 10:42:48','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60439,54533,0,10,389,'AD_Note_UU',TO_DATE('2011-03-29 10:42:48','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Note_UU',TO_DATE('2011-03-29 10:42:48','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Note ADD AD_Note_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Note_UU_idx ON ad_note(AD_Note_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54534,0,'AD_Org_UU',TO_DATE('2011-03-29 10:42:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Org_UU','AD_Org_UU',TO_DATE('2011-03-29 10:42:49','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60440,54534,0,10,155,'AD_Org_UU',TO_DATE('2011-03-29 10:42:49','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Org_UU',TO_DATE('2011-03-29 10:42:49','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Org ADD AD_Org_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Org_UU_idx ON ad_org(AD_Org_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54535,0,'AD_OrgInfo_UU',TO_DATE('2011-03-29 10:42:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_OrgInfo_UU','AD_OrgInfo_UU',TO_DATE('2011-03-29 10:42:51','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60441,54535,0,10,228,'AD_OrgInfo_UU',TO_DATE('2011-03-29 10:42:51','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_OrgInfo_UU',TO_DATE('2011-03-29 10:42:51','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_OrgInfo ADD AD_OrgInfo_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_OrgInfo_UU_idx ON ad_orginfo(AD_OrgInfo_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54536,0,'AD_OrgType_UU',TO_DATE('2011-03-29 10:42:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_OrgType_UU','AD_OrgType_UU',TO_DATE('2011-03-29 10:42:53','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60442,54536,0,10,689,'AD_OrgType_UU',TO_DATE('2011-03-29 10:42:53','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_OrgType_UU',TO_DATE('2011-03-29 10:42:53','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_OrgType ADD AD_OrgType_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_OrgType_UU_idx ON ad_orgtype(AD_OrgType_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54537,0,'AD_Package_Exp_UU',TO_DATE('2011-03-29 10:42:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Package_Exp_UU','AD_Package_Exp_UU',TO_DATE('2011-03-29 10:42:55','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60443,54537,0,10,50005,'AD_Package_Exp_UU',TO_DATE('2011-03-29 10:42:55','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Package_Exp_UU',TO_DATE('2011-03-29 10:42:55','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Package_Exp ADD AD_Package_Exp_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Package_Exp_UU_idx ON ad_package_exp(AD_Package_Exp_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54538,0,'AD_Package_Exp_Common_UU',TO_DATE('2011-03-29 10:42:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Package_Exp_Common_UU','AD_Package_Exp_Common_UU',TO_DATE('2011-03-29 10:42:56','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60444,54538,0,10,50007,'AD_Package_Exp_Common_UU',TO_DATE('2011-03-29 10:42:56','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Package_Exp_Common_UU',TO_DATE('2011-03-29 10:42:56','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Package_Exp_Common ADD AD_Package_Exp_Common_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Package_Exp_Common_UU_idx ON ad_package_exp_common(AD_Package_Exp_Common_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54539,0,'AD_Package_Exp_Detail_UU',TO_DATE('2011-03-29 10:42:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Package_Exp_Detail_UU','AD_Package_Exp_Detail_UU',TO_DATE('2011-03-29 10:42:58','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60445,54539,0,10,50006,'AD_Package_Exp_Detail_UU',TO_DATE('2011-03-29 10:42:58','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Package_Exp_Detail_UU',TO_DATE('2011-03-29 10:42:58','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Package_Exp_Detail ADD AD_Package_Exp_Detail_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Package_Exp_Detail_UU_idx ON ad_package_exp_detail(AD_Package_Exp_Detail_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54540,0,'AD_Package_Imp_UU',TO_DATE('2011-03-29 10:43:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Package_Imp_UU','AD_Package_Imp_UU',TO_DATE('2011-03-29 10:43:00','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60446,54540,0,10,50003,'AD_Package_Imp_UU',TO_DATE('2011-03-29 10:43:00','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Package_Imp_UU',TO_DATE('2011-03-29 10:43:00','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Package_Imp ADD AD_Package_Imp_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Package_Imp_UU_idx ON ad_package_imp(AD_Package_Imp_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54541,0,'AD_Package_Imp_Backup_UU',TO_DATE('2011-03-29 10:43:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Package_Imp_Backup_UU','AD_Package_Imp_Backup_UU',TO_DATE('2011-03-29 10:43:03','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60447,54541,0,10,50002,'AD_Package_Imp_Backup_UU',TO_DATE('2011-03-29 10:43:02','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Package_Imp_Backup_UU',TO_DATE('2011-03-29 10:43:02','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Package_Imp_Backup ADD AD_Package_Imp_Backup_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Package_Imp_Backup_UU_idx ON ad_package_imp_backup(AD_Package_Imp_Backup_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54542,0,'AD_Package_Imp_Detail_UU',TO_DATE('2011-03-29 10:43:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Package_Imp_Detail_UU','AD_Package_Imp_Detail_UU',TO_DATE('2011-03-29 10:43:05','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60448,54542,0,10,50004,'AD_Package_Imp_Detail_UU',TO_DATE('2011-03-29 10:43:05','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Package_Imp_Detail_UU',TO_DATE('2011-03-29 10:43:05','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Package_Imp_Detail ADD AD_Package_Imp_Detail_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Package_Imp_Detail_UU_idx ON ad_package_imp_detail(AD_Package_Imp_Detail_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54543,0,'AD_Package_Imp_Inst_UU',TO_DATE('2011-03-29 10:43:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Package_Imp_Inst_UU','AD_Package_Imp_Inst_UU',TO_DATE('2011-03-29 10:43:07','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60449,54543,0,10,50001,'AD_Package_Imp_Inst_UU',TO_DATE('2011-03-29 10:43:07','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Package_Imp_Inst_UU',TO_DATE('2011-03-29 10:43:07','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Package_Imp_Inst ADD AD_Package_Imp_Inst_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Package_Imp_Inst_UU_idx ON ad_package_imp_inst(AD_Package_Imp_Inst_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54544,0,'AD_Package_Imp_Proc_UU',TO_DATE('2011-03-29 10:43:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Package_Imp_Proc_UU','AD_Package_Imp_Proc_UU',TO_DATE('2011-03-29 10:43:08','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60450,54544,0,10,50008,'AD_Package_Imp_Proc_UU',TO_DATE('2011-03-29 10:43:08','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Package_Imp_Proc_UU',TO_DATE('2011-03-29 10:43:08','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Package_Imp_Proc ADD AD_Package_Imp_Proc_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Package_Imp_Proc_UU_idx ON ad_package_imp_proc(AD_Package_Imp_Proc_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54545,0,'AD_PInstance_UU',TO_DATE('2011-03-29 10:43:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PInstance_UU','AD_PInstance_UU',TO_DATE('2011-03-29 10:43:10','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60451,54545,0,10,282,'AD_PInstance_UU',TO_DATE('2011-03-29 10:43:10','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_PInstance_UU',TO_DATE('2011-03-29 10:43:10','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_PInstance ADD AD_PInstance_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_PInstance_UU_idx ON ad_pinstance(AD_PInstance_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54546,0,'AD_PInstance_Log_UU',TO_DATE('2011-03-29 10:43:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PInstance_Log_UU','AD_PInstance_Log_UU',TO_DATE('2011-03-29 10:43:11','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60452,54546,0,10,578,'AD_PInstance_Log_UU',TO_DATE('2011-03-29 10:43:11','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_PInstance_Log_UU',TO_DATE('2011-03-29 10:43:11','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_PInstance_Log ADD AD_PInstance_Log_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_PInstance_Log_UU_idx ON ad_pinstance_log(AD_PInstance_Log_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54547,0,'AD_PInstance_Para_UU',TO_DATE('2011-03-29 10:43:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PInstance_Para_UU','AD_PInstance_Para_UU',TO_DATE('2011-03-29 10:43:13','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60453,54547,0,10,283,'AD_PInstance_Para_UU',TO_DATE('2011-03-29 10:43:13','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_PInstance_Para_UU',TO_DATE('2011-03-29 10:43:13','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_PInstance_Para ADD AD_PInstance_Para_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_PInstance_Para_UU_idx ON ad_pinstance_para(AD_PInstance_Para_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54548,0,'AD_Preference_UU',TO_DATE('2011-03-29 10:43:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Preference_UU','AD_Preference_UU',TO_DATE('2011-03-29 10:43:15','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60454,54548,0,10,195,'AD_Preference_UU',TO_DATE('2011-03-29 10:43:15','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Preference_UU',TO_DATE('2011-03-29 10:43:15','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Preference ADD AD_Preference_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Preference_UU_idx ON ad_preference(AD_Preference_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54549,0,'AD_PrintColor_UU',TO_DATE('2011-03-29 10:43:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PrintColor_UU','AD_PrintColor_UU',TO_DATE('2011-03-29 10:43:17','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60455,54549,0,10,490,'AD_PrintColor_UU',TO_DATE('2011-03-29 10:43:17','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_PrintColor_UU',TO_DATE('2011-03-29 10:43:17','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_PrintColor ADD AD_PrintColor_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_PrintColor_UU_idx ON ad_printcolor(AD_PrintColor_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54550,0,'AD_PrintFont_UU',TO_DATE('2011-03-29 10:43:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PrintFont_UU','AD_PrintFont_UU',TO_DATE('2011-03-29 10:43:19','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60456,54550,0,10,491,'AD_PrintFont_UU',TO_DATE('2011-03-29 10:43:19','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_PrintFont_UU',TO_DATE('2011-03-29 10:43:19','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_PrintFont ADD AD_PrintFont_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_PrintFont_UU_idx ON ad_printfont(AD_PrintFont_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54551,0,'AD_PrintForm_UU',TO_DATE('2011-03-29 10:43:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PrintForm_UU','AD_PrintForm_UU',TO_DATE('2011-03-29 10:43:21','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60457,54551,0,10,454,'AD_PrintForm_UU',TO_DATE('2011-03-29 10:43:21','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_PrintForm_UU',TO_DATE('2011-03-29 10:43:21','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_PrintForm ADD AD_PrintForm_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_PrintForm_UU_idx ON ad_printform(AD_PrintForm_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54552,0,'AD_PrintFormat_UU',TO_DATE('2011-03-29 10:43:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PrintFormat_UU','AD_PrintFormat_UU',TO_DATE('2011-03-29 10:43:23','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60458,54552,0,10,493,'AD_PrintFormat_UU',TO_DATE('2011-03-29 10:43:23','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_PrintFormat_UU',TO_DATE('2011-03-29 10:43:23','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_PrintFormat ADD AD_PrintFormat_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_PrintFormat_UU_idx ON ad_printformat(AD_PrintFormat_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54553,0,'AD_PrintFormatItem_UU',TO_DATE('2011-03-29 10:43:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PrintFormatItem_UU','AD_PrintFormatItem_UU',TO_DATE('2011-03-29 10:43:25','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60459,54553,0,10,489,'AD_PrintFormatItem_UU',TO_DATE('2011-03-29 10:43:25','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_PrintFormatItem_UU',TO_DATE('2011-03-29 10:43:25','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_PrintFormatItem ADD AD_PrintFormatItem_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_PrintFormatItem_UU_idx ON ad_printformatitem(AD_PrintFormatItem_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54554,0,'AD_PrintFormatItem_Trl_UU',TO_DATE('2011-03-29 10:43:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PrintFormatItem_Trl_UU','AD_PrintFormatItem_Trl_UU',TO_DATE('2011-03-29 10:43:28','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60460,54554,0,10,522,'AD_PrintFormatItem_Trl_UU',TO_DATE('2011-03-29 10:43:28','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_PrintFormatItem_Trl_UU',TO_DATE('2011-03-29 10:43:28','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_PrintFormatItem_Trl ADD AD_PrintFormatItem_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_PrintFormatItem_Trl_UU_idx ON ad_printformatitem_trl(AD_PrintFormatItem_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54555,0,'AD_PrintGraph_UU',TO_DATE('2011-03-29 10:43:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PrintGraph_UU','AD_PrintGraph_UU',TO_DATE('2011-03-29 10:43:29','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60461,54555,0,10,521,'AD_PrintGraph_UU',TO_DATE('2011-03-29 10:43:29','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_PrintGraph_UU',TO_DATE('2011-03-29 10:43:29','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_PrintGraph ADD AD_PrintGraph_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_PrintGraph_UU_idx ON ad_printgraph(AD_PrintGraph_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54556,0,'AD_PrintLabel_UU',TO_DATE('2011-03-29 10:43:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PrintLabel_UU','AD_PrintLabel_UU',TO_DATE('2011-03-29 10:43:30','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60462,54556,0,10,570,'AD_PrintLabel_UU',TO_DATE('2011-03-29 10:43:30','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_PrintLabel_UU',TO_DATE('2011-03-29 10:43:30','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_PrintLabel ADD AD_PrintLabel_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_PrintLabel_UU_idx ON ad_printlabel(AD_PrintLabel_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54557,0,'AD_PrintLabelLine_UU',TO_DATE('2011-03-29 10:43:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PrintLabelLine_UU','AD_PrintLabelLine_UU',TO_DATE('2011-03-29 10:43:32','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60463,54557,0,10,569,'AD_PrintLabelLine_UU',TO_DATE('2011-03-29 10:43:32','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_PrintLabelLine_UU',TO_DATE('2011-03-29 10:43:32','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_PrintLabelLine ADD AD_PrintLabelLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_PrintLabelLine_UU_idx ON ad_printlabelline(AD_PrintLabelLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54558,0,'AD_PrintLabelLine_Trl_UU',TO_DATE('2011-03-29 10:43:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PrintLabelLine_Trl_UU','AD_PrintLabelLine_Trl_UU',TO_DATE('2011-03-29 10:43:33','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60464,54558,0,10,568,'AD_PrintLabelLine_Trl_UU',TO_DATE('2011-03-29 10:43:33','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_PrintLabelLine_Trl_UU',TO_DATE('2011-03-29 10:43:33','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_PrintLabelLine_Trl ADD AD_PrintLabelLine_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_PrintLabelLine_Trl_UU_idx ON ad_printlabelline_trl(AD_PrintLabelLine_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54559,0,'AD_PrintPaper_UU',TO_DATE('2011-03-29 10:43:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PrintPaper_UU','AD_PrintPaper_UU',TO_DATE('2011-03-29 10:43:35','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60465,54559,0,10,492,'AD_PrintPaper_UU',TO_DATE('2011-03-29 10:43:35','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_PrintPaper_UU',TO_DATE('2011-03-29 10:43:35','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_PrintPaper ADD AD_PrintPaper_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_PrintPaper_UU_idx ON ad_printpaper(AD_PrintPaper_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54560,0,'AD_PrintTableFormat_UU',TO_DATE('2011-03-29 10:43:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PrintTableFormat_UU','AD_PrintTableFormat_UU',TO_DATE('2011-03-29 10:43:36','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60466,54560,0,10,523,'AD_PrintTableFormat_UU',TO_DATE('2011-03-29 10:43:36','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_PrintTableFormat_UU',TO_DATE('2011-03-29 10:43:36','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_PrintTableFormat ADD AD_PrintTableFormat_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_PrintTableFormat_UU_idx ON ad_printtableformat(AD_PrintTableFormat_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54561,0,'AD_Private_Access_UU',TO_DATE('2011-03-29 10:43:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Private_Access_UU','AD_Private_Access_UU',TO_DATE('2011-03-29 10:43:38','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60467,54561,0,10,627,'AD_Private_Access_UU',TO_DATE('2011-03-29 10:43:38','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Private_Access_UU',TO_DATE('2011-03-29 10:43:38','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Private_Access ADD AD_Private_Access_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Private_Access_UU_idx ON ad_private_access(AD_Private_Access_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54562,0,'AD_Process_UU',TO_DATE('2011-03-29 10:43:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Process_UU','AD_Process_UU',TO_DATE('2011-03-29 10:43:39','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60468,54562,0,10,284,'AD_Process_UU',TO_DATE('2011-03-29 10:43:39','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Process_UU',TO_DATE('2011-03-29 10:43:39','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Process ADD AD_Process_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Process_UU_idx ON ad_process(AD_Process_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54563,0,'AD_Process_Access_UU',TO_DATE('2011-03-29 10:43:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Process_Access_UU','AD_Process_Access_UU',TO_DATE('2011-03-29 10:43:41','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60469,54563,0,10,197,'AD_Process_Access_UU',TO_DATE('2011-03-29 10:43:41','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Process_Access_UU',TO_DATE('2011-03-29 10:43:41','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Process_Access ADD AD_Process_Access_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Process_Access_UU_idx ON ad_process_access(AD_Process_Access_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54564,0,'AD_Process_Para_UU',TO_DATE('2011-03-29 10:43:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Process_Para_UU','AD_Process_Para_UU',TO_DATE('2011-03-29 10:43:42','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60470,54564,0,10,285,'AD_Process_Para_UU',TO_DATE('2011-03-29 10:43:42','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Process_Para_UU',TO_DATE('2011-03-29 10:43:42','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Process_Para ADD AD_Process_Para_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Process_Para_UU_idx ON ad_process_para(AD_Process_Para_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54565,0,'AD_Process_Para_Trl_UU',TO_DATE('2011-03-29 10:43:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Process_Para_Trl_UU','AD_Process_Para_Trl_UU',TO_DATE('2011-03-29 10:43:44','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60471,54565,0,10,286,'AD_Process_Para_Trl_UU',TO_DATE('2011-03-29 10:43:44','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Process_Para_Trl_UU',TO_DATE('2011-03-29 10:43:44','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Process_Para_Trl ADD AD_Process_Para_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Process_Para_Trl_UU_idx ON ad_process_para_trl(AD_Process_Para_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54566,0,'AD_Process_Trl_UU',TO_DATE('2011-03-29 10:43:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Process_Trl_UU','AD_Process_Trl_UU',TO_DATE('2011-03-29 10:43:46','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60472,54566,0,10,287,'AD_Process_Trl_UU',TO_DATE('2011-03-29 10:43:46','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Process_Trl_UU',TO_DATE('2011-03-29 10:43:46','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Process_Trl ADD AD_Process_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Process_Trl_UU_idx ON ad_process_trl(AD_Process_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54567,0,'AD_Record_Access_UU',TO_DATE('2011-03-29 10:43:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Record_Access_UU','AD_Record_Access_UU',TO_DATE('2011-03-29 10:43:47','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60473,54567,0,10,567,'AD_Record_Access_UU',TO_DATE('2011-03-29 10:43:47','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Record_Access_UU',TO_DATE('2011-03-29 10:43:47','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Record_Access ADD AD_Record_Access_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Record_Access_UU_idx ON ad_record_access(AD_Record_Access_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54568,0,'AD_Reference_UU',TO_DATE('2011-03-29 10:43:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Reference_UU','AD_Reference_UU',TO_DATE('2011-03-29 10:43:49','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60474,54568,0,10,102,'AD_Reference_UU',TO_DATE('2011-03-29 10:43:49','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Reference_UU',TO_DATE('2011-03-29 10:43:49','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Reference ADD AD_Reference_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Reference_UU_idx ON ad_reference(AD_Reference_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54569,0,'AD_Reference_Trl_UU',TO_DATE('2011-03-29 10:43:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Reference_Trl_UU','AD_Reference_Trl_UU',TO_DATE('2011-03-29 10:43:50','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60475,54569,0,10,126,'AD_Reference_Trl_UU',TO_DATE('2011-03-29 10:43:50','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Reference_Trl_UU',TO_DATE('2011-03-29 10:43:50','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Reference_Trl ADD AD_Reference_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Reference_Trl_UU_idx ON ad_reference_trl(AD_Reference_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54570,0,'AD_Ref_List_UU',TO_DATE('2011-03-29 10:43:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Ref_List_UU','AD_Ref_List_UU',TO_DATE('2011-03-29 10:43:52','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60476,54570,0,10,104,'AD_Ref_List_UU',TO_DATE('2011-03-29 10:43:52','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Ref_List_UU',TO_DATE('2011-03-29 10:43:52','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Ref_List ADD AD_Ref_List_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Ref_List_UU_idx ON ad_ref_list(AD_Ref_List_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54571,0,'AD_Ref_List_Trl_UU',TO_DATE('2011-03-29 10:43:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Ref_List_Trl_UU','AD_Ref_List_Trl_UU',TO_DATE('2011-03-29 10:43:53','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60477,54571,0,10,136,'AD_Ref_List_Trl_UU',TO_DATE('2011-03-29 10:43:53','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Ref_List_Trl_UU',TO_DATE('2011-03-29 10:43:53','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Ref_List_Trl ADD AD_Ref_List_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Ref_List_Trl_UU_idx ON ad_ref_list_trl(AD_Ref_List_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54572,0,'AD_Ref_Table_UU',TO_DATE('2011-03-29 10:43:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Ref_Table_UU','AD_Ref_Table_UU',TO_DATE('2011-03-29 10:43:55','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60478,54572,0,10,103,'AD_Ref_Table_UU',TO_DATE('2011-03-29 10:43:55','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Ref_Table_UU',TO_DATE('2011-03-29 10:43:55','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Ref_Table ADD AD_Ref_Table_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Ref_Table_UU_idx ON ad_ref_table(AD_Ref_Table_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54573,0,'AD_Registration_UU',TO_DATE('2011-03-29 10:43:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Registration_UU','AD_Registration_UU',TO_DATE('2011-03-29 10:43:56','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60479,54573,0,10,625,'AD_Registration_UU',TO_DATE('2011-03-29 10:43:56','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Registration_UU',TO_DATE('2011-03-29 10:43:56','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Registration ADD AD_Registration_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Registration_UU_idx ON ad_registration(AD_Registration_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54574,0,'AD_RelationType_UU',TO_DATE('2011-03-29 10:43:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_RelationType_UU','AD_RelationType_UU',TO_DATE('2011-03-29 10:43:59','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60480,54574,0,10,53246,'AD_RelationType_UU',TO_DATE('2011-03-29 10:43:59','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_RelationType_UU',TO_DATE('2011-03-29 10:43:59','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_RelationType ADD AD_RelationType_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_RelationType_UU_idx ON ad_relationtype(AD_RelationType_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54575,0,'AD_Replication_UU',TO_DATE('2011-03-29 10:44:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Replication_UU','AD_Replication_UU',TO_DATE('2011-03-29 10:44:01','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60481,54575,0,10,605,'AD_Replication_UU',TO_DATE('2011-03-29 10:44:01','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Replication_UU',TO_DATE('2011-03-29 10:44:01','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Replication ADD AD_Replication_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Replication_UU_idx ON ad_replication(AD_Replication_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54576,0,'AD_ReplicationDocument_UU',TO_DATE('2011-03-29 10:44:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_ReplicationDocument_UU','AD_ReplicationDocument_UU',TO_DATE('2011-03-29 10:44:03','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60482,54576,0,10,53071,'AD_ReplicationDocument_UU',TO_DATE('2011-03-29 10:44:03','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_ReplicationDocument_UU',TO_DATE('2011-03-29 10:44:03','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_ReplicationDocument ADD AD_ReplicationDocument_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_ReplicationDocument_UU_idx ON ad_replicationdocument(AD_ReplicationDocument_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54577,0,'AD_Replication_Log_UU',TO_DATE('2011-03-29 10:44:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Replication_Log_UU','AD_Replication_Log_UU',TO_DATE('2011-03-29 10:44:07','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60483,54577,0,10,604,'AD_Replication_Log_UU',TO_DATE('2011-03-29 10:44:07','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Replication_Log_UU',TO_DATE('2011-03-29 10:44:07','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Replication_Log ADD AD_Replication_Log_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Replication_Log_UU_idx ON ad_replication_log(AD_Replication_Log_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54578,0,'AD_Replication_Run_UU',TO_DATE('2011-03-29 10:44:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Replication_Run_UU','AD_Replication_Run_UU',TO_DATE('2011-03-29 10:44:10','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60484,54578,0,10,603,'AD_Replication_Run_UU',TO_DATE('2011-03-29 10:44:10','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Replication_Run_UU',TO_DATE('2011-03-29 10:44:10','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Replication_Run ADD AD_Replication_Run_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Replication_Run_UU_idx ON ad_replication_run(AD_Replication_Run_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54579,0,'AD_ReplicationStrategy_UU',TO_DATE('2011-03-29 10:44:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_ReplicationStrategy_UU','AD_ReplicationStrategy_UU',TO_DATE('2011-03-29 10:44:12','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60485,54579,0,10,602,'AD_ReplicationStrategy_UU',TO_DATE('2011-03-29 10:44:12','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_ReplicationStrategy_UU',TO_DATE('2011-03-29 10:44:12','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_ReplicationStrategy ADD AD_ReplicationStrategy_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_ReplicationStrategy_UU_idx ON ad_replicationstrategy(AD_ReplicationStrategy_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54580,0,'AD_ReplicationTable_UU',TO_DATE('2011-03-29 10:44:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_ReplicationTable_UU','AD_ReplicationTable_UU',TO_DATE('2011-03-29 10:44:14','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60486,54580,0,10,601,'AD_ReplicationTable_UU',TO_DATE('2011-03-29 10:44:14','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_ReplicationTable_UU',TO_DATE('2011-03-29 10:44:14','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_ReplicationTable ADD AD_ReplicationTable_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_ReplicationTable_UU_idx ON ad_replicationtable(AD_ReplicationTable_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54581,0,'AD_ReportView_UU',TO_DATE('2011-03-29 10:44:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_ReportView_UU','AD_ReportView_UU',TO_DATE('2011-03-29 10:44:15','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60487,54581,0,10,361,'AD_ReportView_UU',TO_DATE('2011-03-29 10:44:15','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_ReportView_UU',TO_DATE('2011-03-29 10:44:15','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_ReportView ADD AD_ReportView_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_ReportView_UU_idx ON ad_reportview(AD_ReportView_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54582,0,'AD_ReportView_Col_UU',TO_DATE('2011-03-29 10:44:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_ReportView_Col_UU','AD_ReportView_Col_UU',TO_DATE('2011-03-29 10:44:18','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60488,54582,0,10,428,'AD_ReportView_Col_UU',TO_DATE('2011-03-29 10:44:18','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_ReportView_Col_UU',TO_DATE('2011-03-29 10:44:18','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_ReportView_Col ADD AD_ReportView_Col_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_ReportView_Col_UU_idx ON ad_reportview_col(AD_ReportView_Col_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54583,0,'AD_Role_UU',TO_DATE('2011-03-29 10:44:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Role_UU','AD_Role_UU',TO_DATE('2011-03-29 10:44:20','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60489,54583,0,10,156,'AD_Role_UU',TO_DATE('2011-03-29 10:44:20','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Role_UU',TO_DATE('2011-03-29 10:44:20','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Role ADD AD_Role_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Role_UU_idx ON ad_role(AD_Role_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54584,0,'AD_Role_Included_UU',TO_DATE('2011-03-29 10:44:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Role_Included_UU','AD_Role_Included_UU',TO_DATE('2011-03-29 10:44:21','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60490,54584,0,10,53222,'AD_Role_Included_UU',TO_DATE('2011-03-29 10:44:21','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Role_Included_UU',TO_DATE('2011-03-29 10:44:21','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Role_Included ADD AD_Role_Included_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Role_Included_UU_idx ON ad_role_included(AD_Role_Included_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54585,0,'AD_Role_OrgAccess_UU',TO_DATE('2011-03-29 10:44:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Role_OrgAccess_UU','AD_Role_OrgAccess_UU',TO_DATE('2011-03-29 10:44:22','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60491,54585,0,10,422,'AD_Role_OrgAccess_UU',TO_DATE('2011-03-29 10:44:22','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Role_OrgAccess_UU',TO_DATE('2011-03-29 10:44:22','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Role_OrgAccess ADD AD_Role_OrgAccess_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Role_OrgAccess_UU_idx ON ad_role_orgaccess(AD_Role_OrgAccess_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54586,0,'AD_Rule_UU',TO_DATE('2011-03-29 10:44:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Rule_UU','AD_Rule_UU',TO_DATE('2011-03-29 10:44:24','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60492,54586,0,10,53058,'AD_Rule_UU',TO_DATE('2011-03-29 10:44:24','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Rule_UU',TO_DATE('2011-03-29 10:44:24','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Rule ADD AD_Rule_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Rule_UU_idx ON ad_rule(AD_Rule_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54587,0,'AD_Scheduler_UU',TO_DATE('2011-03-29 10:44:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Scheduler_UU','AD_Scheduler_UU',TO_DATE('2011-03-29 10:44:26','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60493,54587,0,10,688,'AD_Scheduler_UU',TO_DATE('2011-03-29 10:44:25','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Scheduler_UU',TO_DATE('2011-03-29 10:44:25','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Scheduler ADD AD_Scheduler_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Scheduler_UU_idx ON ad_scheduler(AD_Scheduler_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54588,0,'AD_SchedulerLog_UU',TO_DATE('2011-03-29 10:44:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_SchedulerLog_UU','AD_SchedulerLog_UU',TO_DATE('2011-03-29 10:44:28','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60494,54588,0,10,687,'AD_SchedulerLog_UU',TO_DATE('2011-03-29 10:44:28','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_SchedulerLog_UU',TO_DATE('2011-03-29 10:44:28','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_SchedulerLog ADD AD_SchedulerLog_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_SchedulerLog_UU_idx ON ad_schedulerlog(AD_SchedulerLog_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54589,0,'AD_Scheduler_Para_UU',TO_DATE('2011-03-29 10:44:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Scheduler_Para_UU','AD_Scheduler_Para_UU',TO_DATE('2011-03-29 10:44:32','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60495,54589,0,10,698,'AD_Scheduler_Para_UU',TO_DATE('2011-03-29 10:44:32','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Scheduler_Para_UU',TO_DATE('2011-03-29 10:44:32','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Scheduler_Para ADD AD_Scheduler_Para_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Scheduler_Para_UU_idx ON ad_scheduler_para(AD_Scheduler_Para_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54590,0,'AD_SchedulerRecipient_UU',TO_DATE('2011-03-29 10:44:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_SchedulerRecipient_UU','AD_SchedulerRecipient_UU',TO_DATE('2011-03-29 10:44:36','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60496,54590,0,10,704,'AD_SchedulerRecipient_UU',TO_DATE('2011-03-29 10:44:36','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_SchedulerRecipient_UU',TO_DATE('2011-03-29 10:44:36','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_SchedulerRecipient ADD AD_SchedulerRecipient_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_SchedulerRecipient_UU_idx ON ad_schedulerrecipient(AD_SchedulerRecipient_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54591,0,'AD_SearchDefinition_UU',TO_DATE('2011-03-29 10:44:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_SearchDefinition_UU','AD_SearchDefinition_UU',TO_DATE('2011-03-29 10:44:37','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60497,54591,0,10,53169,'AD_SearchDefinition_UU',TO_DATE('2011-03-29 10:44:37','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_SearchDefinition_UU',TO_DATE('2011-03-29 10:44:37','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_SearchDefinition ADD AD_SearchDefinition_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_SearchDefinition_UU_idx ON ad_searchdefinition(AD_SearchDefinition_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54592,0,'AD_Sequence_UU',TO_DATE('2011-03-29 10:44:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Sequence_UU','AD_Sequence_UU',TO_DATE('2011-03-29 10:44:38','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60498,54592,0,10,115,'AD_Sequence_UU',TO_DATE('2011-03-29 10:44:38','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Sequence_UU',TO_DATE('2011-03-29 10:44:38','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Sequence ADD AD_Sequence_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Sequence_UU_idx ON ad_sequence(AD_Sequence_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54593,0,'AD_Sequence_Audit_UU',TO_DATE('2011-03-29 10:44:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Sequence_Audit_UU','AD_Sequence_Audit_UU',TO_DATE('2011-03-29 10:44:40','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60499,54593,0,10,121,'AD_Sequence_Audit_UU',TO_DATE('2011-03-29 10:44:40','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Sequence_Audit_UU',TO_DATE('2011-03-29 10:44:40','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Sequence_Audit ADD AD_Sequence_Audit_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Sequence_Audit_UU_idx ON ad_sequence_audit(AD_Sequence_Audit_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54594,0,'AD_Sequence_No_UU',TO_DATE('2011-03-29 10:44:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Sequence_No_UU','AD_Sequence_No_UU',TO_DATE('2011-03-29 10:44:42','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60500,54594,0,10,122,'AD_Sequence_No_UU',TO_DATE('2011-03-29 10:44:42','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Sequence_No_UU',TO_DATE('2011-03-29 10:44:42','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Sequence_No ADD AD_Sequence_No_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Sequence_No_UU_idx ON ad_sequence_no(AD_Sequence_No_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54595,0,'AD_Session_UU',TO_DATE('2011-03-29 10:44:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Session_UU','AD_Session_UU',TO_DATE('2011-03-29 10:44:43','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60501,54595,0,10,566,'AD_Session_UU',TO_DATE('2011-03-29 10:44:43','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Session_UU',TO_DATE('2011-03-29 10:44:43','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Session ADD AD_Session_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Session_UU_idx ON ad_session(AD_Session_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54596,0,'AD_SysConfig_UU',TO_DATE('2011-03-29 10:44:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_SysConfig_UU','AD_SysConfig_UU',TO_DATE('2011-03-29 10:44:45','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60502,54596,0,10,50009,'AD_SysConfig_UU',TO_DATE('2011-03-29 10:44:45','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_SysConfig_UU',TO_DATE('2011-03-29 10:44:45','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_SysConfig ADD AD_SysConfig_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_SysConfig_UU_idx ON ad_sysconfig(AD_SysConfig_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54597,0,'AD_System_UU',TO_DATE('2011-03-29 10:44:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_System_UU','AD_System_UU',TO_DATE('2011-03-29 10:44:46','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60503,54597,0,10,531,'AD_System_UU',TO_DATE('2011-03-29 10:44:46','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_System_UU',TO_DATE('2011-03-29 10:44:46','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_System ADD AD_System_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_System_UU_idx ON ad_system(AD_System_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54598,0,'AD_Tab_UU',TO_DATE('2011-03-29 10:44:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Tab_UU','AD_Tab_UU',TO_DATE('2011-03-29 10:44:48','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60504,54598,0,10,106,'AD_Tab_UU',TO_DATE('2011-03-29 10:44:48','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Tab_UU',TO_DATE('2011-03-29 10:44:48','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Tab ADD AD_Tab_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Tab_UU_idx ON ad_tab(AD_Tab_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54599,0,'AD_Table_UU',TO_DATE('2011-03-29 10:44:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Table_UU','AD_Table_UU',TO_DATE('2011-03-29 10:44:50','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60505,54599,0,10,100,'AD_Table_UU',TO_DATE('2011-03-29 10:44:50','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Table_UU',TO_DATE('2011-03-29 10:44:50','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Table ADD AD_Table_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Table_UU_idx ON ad_table(AD_Table_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54600,0,'AD_Table_Access_UU',TO_DATE('2011-03-29 10:44:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Table_Access_UU','AD_Table_Access_UU',TO_DATE('2011-03-29 10:44:51','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60506,54600,0,10,565,'AD_Table_Access_UU',TO_DATE('2011-03-29 10:44:51','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Table_Access_UU',TO_DATE('2011-03-29 10:44:51','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Table_Access ADD AD_Table_Access_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Table_Access_UU_idx ON ad_table_access(AD_Table_Access_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54601,0,'AD_Table_ScriptValidator_UU',TO_DATE('2011-03-29 10:44:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Table_ScriptValidator_UU','AD_Table_ScriptValidator_UU',TO_DATE('2011-03-29 10:44:53','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60507,54601,0,10,53059,'AD_Table_ScriptValidator_UU',TO_DATE('2011-03-29 10:44:53','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Table_ScriptValidator_UU',TO_DATE('2011-03-29 10:44:53','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Table_ScriptValidator ADD AD_Table_ScriptValidator_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Table_ScriptValidato_UU_idx ON ad_table_scriptvalidator(AD_Table_ScriptValidator_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54602,0,'AD_Table_Trl_UU',TO_DATE('2011-03-29 10:44:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Table_Trl_UU','AD_Table_Trl_UU',TO_DATE('2011-03-29 10:44:55','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60508,54602,0,10,746,'AD_Table_Trl_UU',TO_DATE('2011-03-29 10:44:55','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Table_Trl_UU',TO_DATE('2011-03-29 10:44:55','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Table_Trl ADD AD_Table_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Table_Trl_UU_idx ON ad_table_trl(AD_Table_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54603,0,'AD_Tab_Trl_UU',TO_DATE('2011-03-29 10:44:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Tab_Trl_UU','AD_Tab_Trl_UU',TO_DATE('2011-03-29 10:44:56','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60509,54603,0,10,123,'AD_Tab_Trl_UU',TO_DATE('2011-03-29 10:44:56','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Tab_Trl_UU',TO_DATE('2011-03-29 10:44:56','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Tab_Trl ADD AD_Tab_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Tab_Trl_UU_idx ON ad_tab_trl(AD_Tab_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54604,0,'AD_Task_UU',TO_DATE('2011-03-29 10:45:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Task_UU','AD_Task_UU',TO_DATE('2011-03-29 10:45:00','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60510,54604,0,10,118,'AD_Task_UU',TO_DATE('2011-03-29 10:45:00','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Task_UU',TO_DATE('2011-03-29 10:45:00','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Task ADD AD_Task_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Task_UU_idx ON ad_task(AD_Task_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54605,0,'AD_Task_Access_UU',TO_DATE('2011-03-29 10:45:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Task_Access_UU','AD_Task_Access_UU',TO_DATE('2011-03-29 10:45:02','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60511,54605,0,10,199,'AD_Task_Access_UU',TO_DATE('2011-03-29 10:45:02','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Task_Access_UU',TO_DATE('2011-03-29 10:45:02','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Task_Access ADD AD_Task_Access_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Task_Access_UU_idx ON ad_task_access(AD_Task_Access_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54606,0,'AD_TaskInstance_UU',TO_DATE('2011-03-29 10:45:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_TaskInstance_UU','AD_TaskInstance_UU',TO_DATE('2011-03-29 10:45:03','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60512,54606,0,10,125,'AD_TaskInstance_UU',TO_DATE('2011-03-29 10:45:03','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_TaskInstance_UU',TO_DATE('2011-03-29 10:45:03','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_TaskInstance ADD AD_TaskInstance_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_TaskInstance_UU_idx ON ad_taskinstance(AD_TaskInstance_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54607,0,'AD_Task_Trl_UU',TO_DATE('2011-03-29 10:45:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Task_Trl_UU','AD_Task_Trl_UU',TO_DATE('2011-03-29 10:45:04','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60513,54607,0,10,124,'AD_Task_Trl_UU',TO_DATE('2011-03-29 10:45:04','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Task_Trl_UU',TO_DATE('2011-03-29 10:45:04','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Task_Trl ADD AD_Task_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Task_Trl_UU_idx ON ad_task_trl(AD_Task_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54608,0,'AD_Tree_UU',TO_DATE('2011-03-29 10:45:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Tree_UU','AD_Tree_UU',TO_DATE('2011-03-29 10:45:06','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60514,54608,0,10,288,'AD_Tree_UU',TO_DATE('2011-03-29 10:45:06','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Tree_UU',TO_DATE('2011-03-29 10:45:06','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Tree ADD AD_Tree_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Tree_UU_idx ON ad_tree(AD_Tree_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54609,0,'AD_TreeBar_UU',TO_DATE('2011-03-29 10:45:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_TreeBar_UU','AD_TreeBar_UU',TO_DATE('2011-03-29 10:45:08','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60515,54609,0,10,456,'AD_TreeBar_UU',TO_DATE('2011-03-29 10:45:08','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_TreeBar_UU',TO_DATE('2011-03-29 10:45:08','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_TreeBar ADD AD_TreeBar_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_TreeBar_UU_idx ON ad_treebar(AD_TreeBar_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54610,0,'AD_TreeNode_UU',TO_DATE('2011-03-29 10:45:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_TreeNode_UU','AD_TreeNode_UU',TO_DATE('2011-03-29 10:45:10','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60516,54610,0,10,289,'AD_TreeNode_UU',TO_DATE('2011-03-29 10:45:10','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_TreeNode_UU',TO_DATE('2011-03-29 10:45:10','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_TreeNode ADD AD_TreeNode_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_TreeNode_UU_idx ON ad_treenode(AD_TreeNode_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54611,0,'AD_TreeNodeBP_UU',TO_DATE('2011-03-29 10:45:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_TreeNodeBP_UU','AD_TreeNodeBP_UU',TO_DATE('2011-03-29 10:45:12','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60517,54611,0,10,451,'AD_TreeNodeBP_UU',TO_DATE('2011-03-29 10:45:12','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_TreeNodeBP_UU',TO_DATE('2011-03-29 10:45:12','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_TreeNodeBP ADD AD_TreeNodeBP_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_TreeNodeBP_UU_idx ON ad_treenodebp(AD_TreeNodeBP_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54612,0,'AD_TreeNodeCMC_UU',TO_DATE('2011-03-29 10:45:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_TreeNodeCMC_UU','AD_TreeNodeCMC_UU',TO_DATE('2011-03-29 10:45:16','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60518,54612,0,10,845,'AD_TreeNodeCMC_UU',TO_DATE('2011-03-29 10:45:16','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_TreeNodeCMC_UU',TO_DATE('2011-03-29 10:45:16','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_TreeNodeCMC ADD AD_TreeNodeCMC_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_TreeNodeCMC_UU_idx ON ad_treenodecmc(AD_TreeNodeCMC_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54613,0,'AD_TreeNodeCMM_UU',TO_DATE('2011-03-29 10:45:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_TreeNodeCMM_UU','AD_TreeNodeCMM_UU',TO_DATE('2011-03-29 10:45:18','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60519,54613,0,10,846,'AD_TreeNodeCMM_UU',TO_DATE('2011-03-29 10:45:18','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_TreeNodeCMM_UU',TO_DATE('2011-03-29 10:45:18','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_TreeNodeCMM ADD AD_TreeNodeCMM_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_TreeNodeCMM_UU_idx ON ad_treenodecmm(AD_TreeNodeCMM_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54614,0,'AD_TreeNodeCMS_UU',TO_DATE('2011-03-29 10:45:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_TreeNodeCMS_UU','AD_TreeNodeCMS_UU',TO_DATE('2011-03-29 10:45:20','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60520,54614,0,10,847,'AD_TreeNodeCMS_UU',TO_DATE('2011-03-29 10:45:20','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_TreeNodeCMS_UU',TO_DATE('2011-03-29 10:45:20','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_TreeNodeCMS ADD AD_TreeNodeCMS_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_TreeNodeCMS_UU_idx ON ad_treenodecms(AD_TreeNodeCMS_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54615,0,'AD_TreeNodeCMT_UU',TO_DATE('2011-03-29 10:45:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_TreeNodeCMT_UU','AD_TreeNodeCMT_UU',TO_DATE('2011-03-29 10:45:22','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60521,54615,0,10,848,'AD_TreeNodeCMT_UU',TO_DATE('2011-03-29 10:45:22','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_TreeNodeCMT_UU',TO_DATE('2011-03-29 10:45:22','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_TreeNodeCMT ADD AD_TreeNodeCMT_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_TreeNodeCMT_UU_idx ON ad_treenodecmt(AD_TreeNodeCMT_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54616,0,'AD_TreeNodeMM_UU',TO_DATE('2011-03-29 10:45:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_TreeNodeMM_UU','AD_TreeNodeMM_UU',TO_DATE('2011-03-29 10:45:24','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60522,54616,0,10,452,'AD_TreeNodeMM_UU',TO_DATE('2011-03-29 10:45:24','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_TreeNodeMM_UU',TO_DATE('2011-03-29 10:45:24','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_TreeNodeMM ADD AD_TreeNodeMM_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_TreeNodeMM_UU_idx ON ad_treenodemm(AD_TreeNodeMM_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54617,0,'AD_TreeNodePR_UU',TO_DATE('2011-03-29 10:45:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_TreeNodePR_UU','AD_TreeNodePR_UU',TO_DATE('2011-03-29 10:45:25','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60523,54617,0,10,453,'AD_TreeNodePR_UU',TO_DATE('2011-03-29 10:45:25','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_TreeNodePR_UU',TO_DATE('2011-03-29 10:45:25','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_TreeNodePR ADD AD_TreeNodePR_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_TreeNodePR_UU_idx ON ad_treenodepr(AD_TreeNodePR_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54618,0,'AD_TreeNodeU1_UU',TO_DATE('2011-03-29 10:45:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_TreeNodeU1_UU','AD_TreeNodeU1_UU',TO_DATE('2011-03-29 10:45:26','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60524,54618,0,10,852,'AD_TreeNodeU1_UU',TO_DATE('2011-03-29 10:45:26','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_TreeNodeU1_UU',TO_DATE('2011-03-29 10:45:26','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_TreeNodeU1 ADD AD_TreeNodeU1_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_TreeNodeU1_UU_idx ON ad_treenodeu1(AD_TreeNodeU1_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54619,0,'AD_TreeNodeU2_UU',TO_DATE('2011-03-29 10:45:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_TreeNodeU2_UU','AD_TreeNodeU2_UU',TO_DATE('2011-03-29 10:45:28','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60525,54619,0,10,851,'AD_TreeNodeU2_UU',TO_DATE('2011-03-29 10:45:28','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_TreeNodeU2_UU',TO_DATE('2011-03-29 10:45:28','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_TreeNodeU2 ADD AD_TreeNodeU2_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_TreeNodeU2_UU_idx ON ad_treenodeu2(AD_TreeNodeU2_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54620,0,'AD_TreeNodeU3_UU',TO_DATE('2011-03-29 10:45:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_TreeNodeU3_UU','AD_TreeNodeU3_UU',TO_DATE('2011-03-29 10:45:29','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60526,54620,0,10,850,'AD_TreeNodeU3_UU',TO_DATE('2011-03-29 10:45:29','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_TreeNodeU3_UU',TO_DATE('2011-03-29 10:45:29','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_TreeNodeU3 ADD AD_TreeNodeU3_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_TreeNodeU3_UU_idx ON ad_treenodeu3(AD_TreeNodeU3_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54621,0,'AD_TreeNodeU4_UU',TO_DATE('2011-03-29 10:45:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_TreeNodeU4_UU','AD_TreeNodeU4_UU',TO_DATE('2011-03-29 10:45:32','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60527,54621,0,10,849,'AD_TreeNodeU4_UU',TO_DATE('2011-03-29 10:45:32','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_TreeNodeU4_UU',TO_DATE('2011-03-29 10:45:32','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_TreeNodeU4 ADD AD_TreeNodeU4_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_TreeNodeU4_UU_idx ON ad_treenodeu4(AD_TreeNodeU4_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54622,0,'AD_User_UU',TO_DATE('2011-03-29 10:45:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_User_UU','AD_User_UU',TO_DATE('2011-03-29 10:45:36','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60528,54622,0,10,114,'AD_User_UU',TO_DATE('2011-03-29 10:45:36','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_User_UU',TO_DATE('2011-03-29 10:45:36','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_User ADD AD_User_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_User_UU_idx ON ad_user(AD_User_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54623,0,'AD_UserBPAccess_UU',TO_DATE('2011-03-29 10:45:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_UserBPAccess_UU','AD_UserBPAccess_UU',TO_DATE('2011-03-29 10:45:37','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60529,54623,0,10,813,'AD_UserBPAccess_UU',TO_DATE('2011-03-29 10:45:37','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_UserBPAccess_UU',TO_DATE('2011-03-29 10:45:37','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_UserBPAccess ADD AD_UserBPAccess_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_UserBPAccess_UU_idx ON ad_userbpaccess(AD_UserBPAccess_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54624,0,'AD_UserDef_Field_UU',TO_DATE('2011-03-29 10:45:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_UserDef_Field_UU','AD_UserDef_Field_UU',TO_DATE('2011-03-29 10:45:38','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60530,54624,0,10,464,'AD_UserDef_Field_UU',TO_DATE('2011-03-29 10:45:38','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_UserDef_Field_UU',TO_DATE('2011-03-29 10:45:38','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_UserDef_Field ADD AD_UserDef_Field_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_UserDef_Field_UU_idx ON ad_userdef_field(AD_UserDef_Field_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54625,0,'AD_UserDef_Tab_UU',TO_DATE('2011-03-29 10:45:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_UserDef_Tab_UU','AD_UserDef_Tab_UU',TO_DATE('2011-03-29 10:45:40','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60531,54625,0,10,466,'AD_UserDef_Tab_UU',TO_DATE('2011-03-29 10:45:40','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_UserDef_Tab_UU',TO_DATE('2011-03-29 10:45:40','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_UserDef_Tab ADD AD_UserDef_Tab_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_UserDef_Tab_UU_idx ON ad_userdef_tab(AD_UserDef_Tab_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54626,0,'AD_UserDef_Win_UU',TO_DATE('2011-03-29 10:45:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_UserDef_Win_UU','AD_UserDef_Win_UU',TO_DATE('2011-03-29 10:45:49','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60532,54626,0,10,467,'AD_UserDef_Win_UU',TO_DATE('2011-03-29 10:45:49','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_UserDef_Win_UU',TO_DATE('2011-03-29 10:45:49','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_UserDef_Win ADD AD_UserDef_Win_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_UserDef_Win_UU_idx ON ad_userdef_win(AD_UserDef_Win_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54627,0,'AD_UserMail_UU',TO_DATE('2011-03-29 10:45:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_UserMail_UU','AD_UserMail_UU',TO_DATE('2011-03-29 10:45:51','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60533,54627,0,10,782,'AD_UserMail_UU',TO_DATE('2011-03-29 10:45:51','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_UserMail_UU',TO_DATE('2011-03-29 10:45:51','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_UserMail ADD AD_UserMail_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_UserMail_UU_idx ON ad_usermail(AD_UserMail_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54628,0,'AD_User_OrgAccess_UU',TO_DATE('2011-03-29 10:45:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_User_OrgAccess_UU','AD_User_OrgAccess_UU',TO_DATE('2011-03-29 10:45:52','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60534,54628,0,10,769,'AD_User_OrgAccess_UU',TO_DATE('2011-03-29 10:45:52','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_User_OrgAccess_UU',TO_DATE('2011-03-29 10:45:52','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_User_OrgAccess ADD AD_User_OrgAccess_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_User_OrgAccess_UU_idx ON ad_user_orgaccess(AD_User_OrgAccess_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54629,0,'AD_UserQuery_UU',TO_DATE('2011-03-29 10:45:54','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_UserQuery_UU','AD_UserQuery_UU',TO_DATE('2011-03-29 10:45:54','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60535,54629,0,10,814,'AD_UserQuery_UU',TO_DATE('2011-03-29 10:45:54','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_UserQuery_UU',TO_DATE('2011-03-29 10:45:54','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_UserQuery ADD AD_UserQuery_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_UserQuery_UU_idx ON ad_userquery(AD_UserQuery_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54630,0,'AD_User_Roles_UU',TO_DATE('2011-03-29 10:45:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_User_Roles_UU','AD_User_Roles_UU',TO_DATE('2011-03-29 10:45:55','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60536,54630,0,10,157,'AD_User_Roles_UU',TO_DATE('2011-03-29 10:45:55','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_User_Roles_UU',TO_DATE('2011-03-29 10:45:55','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_User_Roles ADD AD_User_Roles_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_User_Roles_UU_idx ON ad_user_roles(AD_User_Roles_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54631,0,'AD_User_Substitute_UU',TO_DATE('2011-03-29 10:45:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_User_Substitute_UU','AD_User_Substitute_UU',TO_DATE('2011-03-29 10:45:58','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60537,54631,0,10,642,'AD_User_Substitute_UU',TO_DATE('2011-03-29 10:45:58','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_User_Substitute_UU',TO_DATE('2011-03-29 10:45:58','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_User_Substitute ADD AD_User_Substitute_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_User_Substitute_UU_idx ON ad_user_substitute(AD_User_Substitute_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54632,0,'AD_Val_Rule_UU',TO_DATE('2011-03-29 10:45:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Val_Rule_UU','AD_Val_Rule_UU',TO_DATE('2011-03-29 10:45:59','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60538,54632,0,10,108,'AD_Val_Rule_UU',TO_DATE('2011-03-29 10:45:59','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Val_Rule_UU',TO_DATE('2011-03-29 10:45:59','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Val_Rule ADD AD_Val_Rule_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Val_Rule_UU_idx ON ad_val_rule(AD_Val_Rule_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54633,0,'AD_WF_Activity_UU',TO_DATE('2011-03-29 10:46:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_WF_Activity_UU','AD_WF_Activity_UU',TO_DATE('2011-03-29 10:46:01','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60539,54633,0,10,644,'AD_WF_Activity_UU',TO_DATE('2011-03-29 10:46:01','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_WF_Activity_UU',TO_DATE('2011-03-29 10:46:01','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_WF_Activity ADD AD_WF_Activity_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_WF_Activity_UU_idx ON ad_wf_activity(AD_WF_Activity_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54634,0,'AD_WF_ActivityResult_UU',TO_DATE('2011-03-29 10:46:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_WF_ActivityResult_UU','AD_WF_ActivityResult_UU',TO_DATE('2011-03-29 10:46:03','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60540,54634,0,10,650,'AD_WF_ActivityResult_UU',TO_DATE('2011-03-29 10:46:03','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_WF_ActivityResult_UU',TO_DATE('2011-03-29 10:46:03','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_WF_ActivityResult ADD AD_WF_ActivityResult_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_WF_ActivityResult_UU_idx ON ad_wf_activityresult(AD_WF_ActivityResult_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54635,0,'AD_WF_Block_UU',TO_DATE('2011-03-29 10:46:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_WF_Block_UU','AD_WF_Block_UU',TO_DATE('2011-03-29 10:46:05','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60541,54635,0,10,647,'AD_WF_Block_UU',TO_DATE('2011-03-29 10:46:05','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_WF_Block_UU',TO_DATE('2011-03-29 10:46:05','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_WF_Block ADD AD_WF_Block_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_WF_Block_UU_idx ON ad_wf_block(AD_WF_Block_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54636,0,'AD_WF_EventAudit_UU',TO_DATE('2011-03-29 10:46:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_WF_EventAudit_UU','AD_WF_EventAudit_UU',TO_DATE('2011-03-29 10:46:06','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60542,54636,0,10,649,'AD_WF_EventAudit_UU',TO_DATE('2011-03-29 10:46:06','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_WF_EventAudit_UU',TO_DATE('2011-03-29 10:46:06','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_WF_EventAudit ADD AD_WF_EventAudit_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_WF_EventAudit_UU_idx ON ad_wf_eventaudit(AD_WF_EventAudit_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54637,0,'AD_WF_NextCondition_UU',TO_DATE('2011-03-29 10:46:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_WF_NextCondition_UU','AD_WF_NextCondition_UU',TO_DATE('2011-03-29 10:46:08','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60543,54637,0,10,706,'AD_WF_NextCondition_UU',TO_DATE('2011-03-29 10:46:08','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_WF_NextCondition_UU',TO_DATE('2011-03-29 10:46:08','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_WF_NextCondition ADD AD_WF_NextCondition_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_WF_NextCondition_UU_idx ON ad_wf_nextcondition(AD_WF_NextCondition_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54638,0,'AD_WF_Node_UU',TO_DATE('2011-03-29 10:46:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_WF_Node_UU','AD_WF_Node_UU',TO_DATE('2011-03-29 10:46:10','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60544,54638,0,10,129,'AD_WF_Node_UU',TO_DATE('2011-03-29 10:46:10','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_WF_Node_UU',TO_DATE('2011-03-29 10:46:10','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_WF_Node ADD AD_WF_Node_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_WF_Node_UU_idx ON ad_wf_node(AD_WF_Node_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54639,0,'AD_WF_NodeNext_UU',TO_DATE('2011-03-29 10:46:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_WF_NodeNext_UU','AD_WF_NodeNext_UU',TO_DATE('2011-03-29 10:46:11','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60545,54639,0,10,131,'AD_WF_NodeNext_UU',TO_DATE('2011-03-29 10:46:11','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_WF_NodeNext_UU',TO_DATE('2011-03-29 10:46:11','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_WF_NodeNext ADD AD_WF_NodeNext_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_WF_NodeNext_UU_idx ON ad_wf_nodenext(AD_WF_NodeNext_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54640,0,'AD_WF_Node_Para_UU',TO_DATE('2011-03-29 10:46:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_WF_Node_Para_UU','AD_WF_Node_Para_UU',TO_DATE('2011-03-29 10:46:14','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60546,54640,0,10,643,'AD_WF_Node_Para_UU',TO_DATE('2011-03-29 10:46:14','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_WF_Node_Para_UU',TO_DATE('2011-03-29 10:46:14','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_WF_Node_Para ADD AD_WF_Node_Para_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_WF_Node_Para_UU_idx ON ad_wf_node_para(AD_WF_Node_Para_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54641,0,'AD_WF_Node_Trl_UU',TO_DATE('2011-03-29 10:46:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_WF_Node_Trl_UU','AD_WF_Node_Trl_UU',TO_DATE('2011-03-29 10:46:15','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60547,54641,0,10,130,'AD_WF_Node_Trl_UU',TO_DATE('2011-03-29 10:46:15','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_WF_Node_Trl_UU',TO_DATE('2011-03-29 10:46:15','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_WF_Node_Trl ADD AD_WF_Node_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_WF_Node_Trl_UU_idx ON ad_wf_node_trl(AD_WF_Node_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54642,0,'AD_WF_Process_UU',TO_DATE('2011-03-29 10:46:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_WF_Process_UU','AD_WF_Process_UU',TO_DATE('2011-03-29 10:46:17','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60548,54642,0,10,645,'AD_WF_Process_UU',TO_DATE('2011-03-29 10:46:17','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_WF_Process_UU',TO_DATE('2011-03-29 10:46:17','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_WF_Process ADD AD_WF_Process_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_WF_Process_UU_idx ON ad_wf_process(AD_WF_Process_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54643,0,'AD_WF_ProcessData_UU',TO_DATE('2011-03-29 10:46:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_WF_ProcessData_UU','AD_WF_ProcessData_UU',TO_DATE('2011-03-29 10:46:19','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60549,54643,0,10,648,'AD_WF_ProcessData_UU',TO_DATE('2011-03-29 10:46:19','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_WF_ProcessData_UU',TO_DATE('2011-03-29 10:46:19','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_WF_ProcessData ADD AD_WF_ProcessData_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_WF_ProcessData_UU_idx ON ad_wf_processdata(AD_WF_ProcessData_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54644,0,'AD_WF_Responsible_UU',TO_DATE('2011-03-29 10:46:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_WF_Responsible_UU','AD_WF_Responsible_UU',TO_DATE('2011-03-29 10:46:20','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60550,54644,0,10,646,'AD_WF_Responsible_UU',TO_DATE('2011-03-29 10:46:20','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_WF_Responsible_UU',TO_DATE('2011-03-29 10:46:20','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_WF_Responsible ADD AD_WF_Responsible_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_WF_Responsible_UU_idx ON ad_wf_responsible(AD_WF_Responsible_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54645,0,'AD_Window_UU',TO_DATE('2011-03-29 10:46:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Window_UU','AD_Window_UU',TO_DATE('2011-03-29 10:46:22','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60551,54645,0,10,105,'AD_Window_UU',TO_DATE('2011-03-29 10:46:22','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Window_UU',TO_DATE('2011-03-29 10:46:22','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Window ADD AD_Window_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Window_UU_idx ON ad_window(AD_Window_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54646,0,'AD_Window_Access_UU',TO_DATE('2011-03-29 10:46:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Window_Access_UU','AD_Window_Access_UU',TO_DATE('2011-03-29 10:46:24','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60552,54646,0,10,201,'AD_Window_Access_UU',TO_DATE('2011-03-29 10:46:24','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Window_Access_UU',TO_DATE('2011-03-29 10:46:24','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Window_Access ADD AD_Window_Access_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Window_Access_UU_idx ON ad_window_access(AD_Window_Access_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54647,0,'AD_Window_Trl_UU',TO_DATE('2011-03-29 10:46:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Window_Trl_UU','AD_Window_Trl_UU',TO_DATE('2011-03-29 10:46:26','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60553,54647,0,10,132,'AD_Window_Trl_UU',TO_DATE('2011-03-29 10:46:26','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Window_Trl_UU',TO_DATE('2011-03-29 10:46:26','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Window_Trl ADD AD_Window_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Window_Trl_UU_idx ON ad_window_trl(AD_Window_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54648,0,'AD_Workbench_UU',TO_DATE('2011-03-29 10:46:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Workbench_UU','AD_Workbench_UU',TO_DATE('2011-03-29 10:46:33','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60554,54648,0,10,468,'AD_Workbench_UU',TO_DATE('2011-03-29 10:46:33','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Workbench_UU',TO_DATE('2011-03-29 10:46:33','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Workbench ADD AD_Workbench_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Workbench_UU_idx ON ad_workbench(AD_Workbench_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54649,0,'AD_Workbench_Trl_UU',TO_DATE('2011-03-29 10:46:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Workbench_Trl_UU','AD_Workbench_Trl_UU',TO_DATE('2011-03-29 10:46:36','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60555,54649,0,10,470,'AD_Workbench_Trl_UU',TO_DATE('2011-03-29 10:46:36','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Workbench_Trl_UU',TO_DATE('2011-03-29 10:46:36','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Workbench_Trl ADD AD_Workbench_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Workbench_Trl_UU_idx ON ad_workbench_trl(AD_Workbench_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54650,0,'AD_WorkbenchWindow_UU',TO_DATE('2011-03-29 10:46:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_WorkbenchWindow_UU','AD_WorkbenchWindow_UU',TO_DATE('2011-03-29 10:46:37','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60556,54650,0,10,469,'AD_WorkbenchWindow_UU',TO_DATE('2011-03-29 10:46:37','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_WorkbenchWindow_UU',TO_DATE('2011-03-29 10:46:37','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_WorkbenchWindow ADD AD_WorkbenchWindow_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_WorkbenchWindow_UU_idx ON ad_workbenchwindow(AD_WorkbenchWindow_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54651,0,'AD_Workflow_UU',TO_DATE('2011-03-29 10:46:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Workflow_UU','AD_Workflow_UU',TO_DATE('2011-03-29 10:46:39','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60557,54651,0,10,117,'AD_Workflow_UU',TO_DATE('2011-03-29 10:46:39','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Workflow_UU',TO_DATE('2011-03-29 10:46:39','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Workflow ADD AD_Workflow_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Workflow_UU_idx ON ad_workflow(AD_Workflow_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54652,0,'AD_Workflow_Access_UU',TO_DATE('2011-03-29 10:46:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Workflow_Access_UU','AD_Workflow_Access_UU',TO_DATE('2011-03-29 10:46:43','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60558,54652,0,10,202,'AD_Workflow_Access_UU',TO_DATE('2011-03-29 10:46:43','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Workflow_Access_UU',TO_DATE('2011-03-29 10:46:43','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Workflow_Access ADD AD_Workflow_Access_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Workflow_Access_UU_idx ON ad_workflow_access(AD_Workflow_Access_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54653,0,'AD_WorkflowProcessor_UU',TO_DATE('2011-03-29 10:46:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_WorkflowProcessor_UU','AD_WorkflowProcessor_UU',TO_DATE('2011-03-29 10:46:45','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60559,54653,0,10,697,'AD_WorkflowProcessor_UU',TO_DATE('2011-03-29 10:46:45','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_WorkflowProcessor_UU',TO_DATE('2011-03-29 10:46:45','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_WorkflowProcessor ADD AD_WorkflowProcessor_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_WorkflowProcessor_UU_idx ON ad_workflowprocessor(AD_WorkflowProcessor_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54654,0,'AD_WorkflowProcessorLog_UU',TO_DATE('2011-03-29 10:46:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_WorkflowProcessorLog_UU','AD_WorkflowProcessorLog_UU',TO_DATE('2011-03-29 10:46:47','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60560,54654,0,10,696,'AD_WorkflowProcessorLog_UU',TO_DATE('2011-03-29 10:46:47','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_WorkflowProcessorLog_UU',TO_DATE('2011-03-29 10:46:47','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_WorkflowProcessorLog ADD AD_WorkflowProcessorLog_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_WorkflowProcessorLog_UU_idx ON ad_workflowprocessorlog(AD_WorkflowProcessorLog_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54655,0,'AD_Workflow_Trl_UU',TO_DATE('2011-03-29 10:46:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Workflow_Trl_UU','AD_Workflow_Trl_UU',TO_DATE('2011-03-29 10:46:49','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60561,54655,0,10,133,'AD_Workflow_Trl_UU',TO_DATE('2011-03-29 10:46:49','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','AD_Workflow_Trl_UU',TO_DATE('2011-03-29 10:46:49','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE AD_Workflow_Trl ADD AD_Workflow_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX AD_Workflow_Trl_UU_idx ON ad_workflow_trl(AD_Workflow_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54656,0,'A_Registration_UU',TO_DATE('2011-03-29 10:46:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Registration_UU','A_Registration_UU',TO_DATE('2011-03-29 10:46:51','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60562,54656,0,10,651,'A_Registration_UU',TO_DATE('2011-03-29 10:46:51','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_Registration_UU',TO_DATE('2011-03-29 10:46:51','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_Registration ADD A_Registration_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_Registration_UU_idx ON a_registration(A_Registration_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54657,0,'A_RegistrationAttribute_UU',TO_DATE('2011-03-29 10:46:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_RegistrationAttribute_UU','A_RegistrationAttribute_UU',TO_DATE('2011-03-29 10:46:53','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60563,54657,0,10,652,'A_RegistrationAttribute_UU',TO_DATE('2011-03-29 10:46:53','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_RegistrationAttribute_UU',TO_DATE('2011-03-29 10:46:53','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_RegistrationAttribute ADD A_RegistrationAttribute_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_RegistrationAttribute_UU_idx ON a_registrationattribute(A_RegistrationAttribute_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54658,0,'A_RegistrationProduct_UU',TO_DATE('2011-03-29 10:46:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_RegistrationProduct_UU','A_RegistrationProduct_UU',TO_DATE('2011-03-29 10:46:55','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60564,54658,0,10,715,'A_RegistrationProduct_UU',TO_DATE('2011-03-29 10:46:55','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_RegistrationProduct_UU',TO_DATE('2011-03-29 10:46:55','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_RegistrationProduct ADD A_RegistrationProduct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_RegistrationProduct_UU_idx ON a_registrationproduct(A_RegistrationProduct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54659,0,'A_RegistrationValue_UU',TO_DATE('2011-03-29 10:46:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_RegistrationValue_UU','A_RegistrationValue_UU',TO_DATE('2011-03-29 10:46:56','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60565,54659,0,10,653,'A_RegistrationValue_UU',TO_DATE('2011-03-29 10:46:56','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','A_RegistrationValue_UU',TO_DATE('2011-03-29 10:46:56','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE A_RegistrationValue ADD A_RegistrationValue_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX A_RegistrationValue_UU_idx ON a_registrationvalue(A_RegistrationValue_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54660,0,'ASP_ClientException_UU',TO_DATE('2011-03-29 10:46:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ASP_ClientException_UU','ASP_ClientException_UU',TO_DATE('2011-03-29 10:46:58','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60566,54660,0,10,53057,'ASP_ClientException_UU',TO_DATE('2011-03-29 10:46:58','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','ASP_ClientException_UU',TO_DATE('2011-03-29 10:46:58','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE ASP_ClientException ADD ASP_ClientException_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX ASP_ClientException_UU_idx ON asp_clientexception(ASP_ClientException_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54661,0,'ASP_ClientLevel_UU',TO_DATE('2011-03-29 10:47:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ASP_ClientLevel_UU','ASP_ClientLevel_UU',TO_DATE('2011-03-29 10:47:00','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60567,54661,0,10,53056,'ASP_ClientLevel_UU',TO_DATE('2011-03-29 10:47:00','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','ASP_ClientLevel_UU',TO_DATE('2011-03-29 10:47:00','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE ASP_ClientLevel ADD ASP_ClientLevel_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX ASP_ClientLevel_UU_idx ON asp_clientlevel(ASP_ClientLevel_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54662,0,'ASP_Field_UU',TO_DATE('2011-03-29 10:47:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ASP_Field_UU','ASP_Field_UU',TO_DATE('2011-03-29 10:47:02','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60568,54662,0,10,53048,'ASP_Field_UU',TO_DATE('2011-03-29 10:47:02','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','ASP_Field_UU',TO_DATE('2011-03-29 10:47:02','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE ASP_Field ADD ASP_Field_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX ASP_Field_UU_idx ON asp_field(ASP_Field_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54663,0,'ASP_Form_UU',TO_DATE('2011-03-29 10:47:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ASP_Form_UU','ASP_Form_UU',TO_DATE('2011-03-29 10:47:04','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60569,54663,0,10,53051,'ASP_Form_UU',TO_DATE('2011-03-29 10:47:04','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','ASP_Form_UU',TO_DATE('2011-03-29 10:47:04','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE ASP_Form ADD ASP_Form_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX ASP_Form_UU_idx ON asp_form(ASP_Form_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54664,0,'ASP_Level_UU',TO_DATE('2011-03-29 10:47:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ASP_Level_UU','ASP_Level_UU',TO_DATE('2011-03-29 10:47:05','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60570,54664,0,10,53055,'ASP_Level_UU',TO_DATE('2011-03-29 10:47:05','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','ASP_Level_UU',TO_DATE('2011-03-29 10:47:05','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE ASP_Level ADD ASP_Level_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX ASP_Level_UU_idx ON asp_level(ASP_Level_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54665,0,'ASP_Module_UU',TO_DATE('2011-03-29 10:47:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ASP_Module_UU','ASP_Module_UU',TO_DATE('2011-03-29 10:47:07','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60571,54665,0,10,53054,'ASP_Module_UU',TO_DATE('2011-03-29 10:47:07','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','ASP_Module_UU',TO_DATE('2011-03-29 10:47:07','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE ASP_Module ADD ASP_Module_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX ASP_Module_UU_idx ON asp_module(ASP_Module_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54666,0,'ASP_Process_UU',TO_DATE('2011-03-29 10:47:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ASP_Process_UU','ASP_Process_UU',TO_DATE('2011-03-29 10:47:08','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60572,54666,0,10,53049,'ASP_Process_UU',TO_DATE('2011-03-29 10:47:08','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','ASP_Process_UU',TO_DATE('2011-03-29 10:47:08','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE ASP_Process ADD ASP_Process_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX ASP_Process_UU_idx ON asp_process(ASP_Process_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54667,0,'ASP_Process_Para_UU',TO_DATE('2011-03-29 10:47:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ASP_Process_Para_UU','ASP_Process_Para_UU',TO_DATE('2011-03-29 10:47:10','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60573,54667,0,10,53050,'ASP_Process_Para_UU',TO_DATE('2011-03-29 10:47:10','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','ASP_Process_Para_UU',TO_DATE('2011-03-29 10:47:10','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE ASP_Process_Para ADD ASP_Process_Para_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX ASP_Process_Para_UU_idx ON asp_process_para(ASP_Process_Para_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54668,0,'ASP_Tab_UU',TO_DATE('2011-03-29 10:47:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ASP_Tab_UU','ASP_Tab_UU',TO_DATE('2011-03-29 10:47:11','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60574,54668,0,10,53047,'ASP_Tab_UU',TO_DATE('2011-03-29 10:47:11','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','ASP_Tab_UU',TO_DATE('2011-03-29 10:47:11','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE ASP_Tab ADD ASP_Tab_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX ASP_Tab_UU_idx ON asp_tab(ASP_Tab_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54669,0,'ASP_Task_UU',TO_DATE('2011-03-29 10:47:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ASP_Task_UU','ASP_Task_UU',TO_DATE('2011-03-29 10:47:12','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60575,54669,0,10,53052,'ASP_Task_UU',TO_DATE('2011-03-29 10:47:12','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','ASP_Task_UU',TO_DATE('2011-03-29 10:47:12','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE ASP_Task ADD ASP_Task_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX ASP_Task_UU_idx ON asp_task(ASP_Task_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54670,0,'ASP_Window_UU',TO_DATE('2011-03-29 10:47:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ASP_Window_UU','ASP_Window_UU',TO_DATE('2011-03-29 10:47:14','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60576,54670,0,10,53046,'ASP_Window_UU',TO_DATE('2011-03-29 10:47:14','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','ASP_Window_UU',TO_DATE('2011-03-29 10:47:14','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE ASP_Window ADD ASP_Window_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX ASP_Window_UU_idx ON asp_window(ASP_Window_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54671,0,'ASP_Workflow_UU',TO_DATE('2011-03-29 10:47:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ASP_Workflow_UU','ASP_Workflow_UU',TO_DATE('2011-03-29 10:47:15','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60577,54671,0,10,53053,'ASP_Workflow_UU',TO_DATE('2011-03-29 10:47:15','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','ASP_Workflow_UU',TO_DATE('2011-03-29 10:47:15','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE ASP_Workflow ADD ASP_Workflow_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX ASP_Workflow_UU_idx ON asp_workflow(ASP_Workflow_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54672,0,'B_Bid_UU',TO_DATE('2011-03-29 10:47:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','B_Bid_UU','B_Bid_UU',TO_DATE('2011-03-29 10:47:17','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60578,54672,0,10,686,'B_Bid_UU',TO_DATE('2011-03-29 10:47:17','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','B_Bid_UU',TO_DATE('2011-03-29 10:47:17','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE B_Bid ADD B_Bid_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX B_Bid_UU_idx ON b_bid(B_Bid_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54673,0,'B_BidComment_UU',TO_DATE('2011-03-29 10:47:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','B_BidComment_UU','B_BidComment_UU',TO_DATE('2011-03-29 10:47:19','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60579,54673,0,10,685,'B_BidComment_UU',TO_DATE('2011-03-29 10:47:19','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','B_BidComment_UU',TO_DATE('2011-03-29 10:47:19','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE B_BidComment ADD B_BidComment_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX B_BidComment_UU_idx ON b_bidcomment(B_BidComment_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54674,0,'B_Buyer_UU',TO_DATE('2011-03-29 10:47:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','B_Buyer_UU','B_Buyer_UU',TO_DATE('2011-03-29 10:47:22','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60580,54674,0,10,684,'B_Buyer_UU',TO_DATE('2011-03-29 10:47:22','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','B_Buyer_UU',TO_DATE('2011-03-29 10:47:22','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE B_Buyer ADD B_Buyer_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX B_Buyer_UU_idx ON b_buyer(B_Buyer_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54675,0,'B_BuyerFunds_UU',TO_DATE('2011-03-29 10:47:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','B_BuyerFunds_UU','B_BuyerFunds_UU',TO_DATE('2011-03-29 10:47:23','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60581,54675,0,10,683,'B_BuyerFunds_UU',TO_DATE('2011-03-29 10:47:23','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','B_BuyerFunds_UU',TO_DATE('2011-03-29 10:47:23','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE B_BuyerFunds ADD B_BuyerFunds_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX B_BuyerFunds_UU_idx ON b_buyerfunds(B_BuyerFunds_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54676,0,'B_Offer_UU',TO_DATE('2011-03-29 10:47:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','B_Offer_UU','B_Offer_UU',TO_DATE('2011-03-29 10:47:25','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60582,54676,0,10,682,'B_Offer_UU',TO_DATE('2011-03-29 10:47:25','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','B_Offer_UU',TO_DATE('2011-03-29 10:47:25','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE B_Offer ADD B_Offer_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX B_Offer_UU_idx ON b_offer(B_Offer_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54677,0,'B_Seller_UU',TO_DATE('2011-03-29 10:47:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','B_Seller_UU','B_Seller_UU',TO_DATE('2011-03-29 10:47:26','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60583,54677,0,10,681,'B_Seller_UU',TO_DATE('2011-03-29 10:47:26','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','B_Seller_UU',TO_DATE('2011-03-29 10:47:26','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE B_Seller ADD B_Seller_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX B_Seller_UU_idx ON b_seller(B_Seller_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54678,0,'B_SellerFunds_UU',TO_DATE('2011-03-29 10:47:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','B_SellerFunds_UU','B_SellerFunds_UU',TO_DATE('2011-03-29 10:47:27','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60584,54678,0,10,680,'B_SellerFunds_UU',TO_DATE('2011-03-29 10:47:27','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','B_SellerFunds_UU',TO_DATE('2011-03-29 10:47:27','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE B_SellerFunds ADD B_SellerFunds_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX B_SellerFunds_UU_idx ON b_sellerfunds(B_SellerFunds_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54679,0,'B_Topic_UU',TO_DATE('2011-03-29 10:47:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','B_Topic_UU','B_Topic_UU',TO_DATE('2011-03-29 10:47:29','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60585,54679,0,10,679,'B_Topic_UU',TO_DATE('2011-03-29 10:47:29','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','B_Topic_UU',TO_DATE('2011-03-29 10:47:29','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE B_Topic ADD B_Topic_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX B_Topic_UU_idx ON b_topic(B_Topic_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54680,0,'B_TopicCategory_UU',TO_DATE('2011-03-29 10:47:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','B_TopicCategory_UU','B_TopicCategory_UU',TO_DATE('2011-03-29 10:47:31','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60586,54680,0,10,691,'B_TopicCategory_UU',TO_DATE('2011-03-29 10:47:31','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','B_TopicCategory_UU',TO_DATE('2011-03-29 10:47:31','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE B_TopicCategory ADD B_TopicCategory_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX B_TopicCategory_UU_idx ON b_topiccategory(B_TopicCategory_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54681,0,'B_TopicType_UU',TO_DATE('2011-03-29 10:47:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','B_TopicType_UU','B_TopicType_UU',TO_DATE('2011-03-29 10:47:33','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60587,54681,0,10,690,'B_TopicType_UU',TO_DATE('2011-03-29 10:47:33','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','B_TopicType_UU',TO_DATE('2011-03-29 10:47:33','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE B_TopicType ADD B_TopicType_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX B_TopicType_UU_idx ON b_topictype(B_TopicType_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54682,0,'C_AcctProcessor_UU',TO_DATE('2011-03-29 10:47:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_AcctProcessor_UU','C_AcctProcessor_UU',TO_DATE('2011-03-29 10:47:34','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60588,54682,0,10,695,'C_AcctProcessor_UU',TO_DATE('2011-03-29 10:47:34','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_AcctProcessor_UU',TO_DATE('2011-03-29 10:47:34','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_AcctProcessor ADD C_AcctProcessor_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_AcctProcessor_UU_idx ON c_acctprocessor(C_AcctProcessor_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54683,0,'C_AcctProcessorLog_UU',TO_DATE('2011-03-29 10:47:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_AcctProcessorLog_UU','C_AcctProcessorLog_UU',TO_DATE('2011-03-29 10:47:35','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60589,54683,0,10,694,'C_AcctProcessorLog_UU',TO_DATE('2011-03-29 10:47:35','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_AcctProcessorLog_UU',TO_DATE('2011-03-29 10:47:35','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_AcctProcessorLog ADD C_AcctProcessorLog_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_AcctProcessorLog_UU_idx ON c_acctprocessorlog(C_AcctProcessorLog_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54684,0,'C_AcctSchema_UU',TO_DATE('2011-03-29 10:47:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_AcctSchema_UU','C_AcctSchema_UU',TO_DATE('2011-03-29 10:47:39','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60590,54684,0,10,265,'C_AcctSchema_UU',TO_DATE('2011-03-29 10:47:39','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_AcctSchema_UU',TO_DATE('2011-03-29 10:47:39','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_AcctSchema ADD C_AcctSchema_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_AcctSchema_UU_idx ON c_acctschema(C_AcctSchema_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54685,0,'C_AcctSchema_Default_UU',TO_DATE('2011-03-29 10:47:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_AcctSchema_Default_UU','C_AcctSchema_Default_UU',TO_DATE('2011-03-29 10:47:40','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60591,54685,0,10,315,'C_AcctSchema_Default_UU',TO_DATE('2011-03-29 10:47:40','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_AcctSchema_Default_UU',TO_DATE('2011-03-29 10:47:40','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_AcctSchema_Default ADD C_AcctSchema_Default_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_AcctSchema_Default_UU_idx ON c_acctschema_default(C_AcctSchema_Default_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54686,0,'C_AcctSchema_Element_UU',TO_DATE('2011-03-29 10:47:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_AcctSchema_Element_UU','C_AcctSchema_Element_UU',TO_DATE('2011-03-29 10:47:41','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60592,54686,0,10,279,'C_AcctSchema_Element_UU',TO_DATE('2011-03-29 10:47:41','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_AcctSchema_Element_UU',TO_DATE('2011-03-29 10:47:41','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_AcctSchema_Element ADD C_AcctSchema_Element_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_AcctSchema_Element_UU_idx ON c_acctschema_element(C_AcctSchema_Element_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54687,0,'C_AcctSchema_GL_UU',TO_DATE('2011-03-29 10:47:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_AcctSchema_GL_UU','C_AcctSchema_GL_UU',TO_DATE('2011-03-29 10:47:43','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60593,54687,0,10,266,'C_AcctSchema_GL_UU',TO_DATE('2011-03-29 10:47:43','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_AcctSchema_GL_UU',TO_DATE('2011-03-29 10:47:43','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_AcctSchema_GL ADD C_AcctSchema_GL_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_AcctSchema_GL_UU_idx ON c_acctschema_gl(C_AcctSchema_GL_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54688,0,'C_Activity_UU',TO_DATE('2011-03-29 10:47:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Activity_UU','C_Activity_UU',TO_DATE('2011-03-29 10:47:45','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60594,54688,0,10,316,'C_Activity_UU',TO_DATE('2011-03-29 10:47:45','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Activity_UU',TO_DATE('2011-03-29 10:47:45','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Activity ADD C_Activity_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Activity_UU_idx ON c_activity(C_Activity_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54689,0,'C_AllocationHdr_UU',TO_DATE('2011-03-29 10:47:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_AllocationHdr_UU','C_AllocationHdr_UU',TO_DATE('2011-03-29 10:47:49','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60595,54689,0,10,735,'C_AllocationHdr_UU',TO_DATE('2011-03-29 10:47:49','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_AllocationHdr_UU',TO_DATE('2011-03-29 10:47:49','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_AllocationHdr ADD C_AllocationHdr_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_AllocationHdr_UU_idx ON c_allocationhdr(C_AllocationHdr_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54690,0,'C_AllocationLine_UU',TO_DATE('2011-03-29 10:47:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_AllocationLine_UU','C_AllocationLine_UU',TO_DATE('2011-03-29 10:47:51','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60596,54690,0,10,390,'C_AllocationLine_UU',TO_DATE('2011-03-29 10:47:51','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_AllocationLine_UU',TO_DATE('2011-03-29 10:47:51','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_AllocationLine ADD C_AllocationLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_AllocationLine_UU_idx ON c_allocationline(C_AllocationLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54691,0,'C_Bank_UU',TO_DATE('2011-03-29 10:47:54','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Bank_UU','C_Bank_UU',TO_DATE('2011-03-29 10:47:54','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60597,54691,0,10,296,'C_Bank_UU',TO_DATE('2011-03-29 10:47:54','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Bank_UU',TO_DATE('2011-03-29 10:47:54','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Bank ADD C_Bank_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Bank_UU_idx ON c_bank(C_Bank_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54692,0,'C_BankAccount_UU',TO_DATE('2011-03-29 10:47:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_BankAccount_UU','C_BankAccount_UU',TO_DATE('2011-03-29 10:47:57','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60598,54692,0,10,297,'C_BankAccount_UU',TO_DATE('2011-03-29 10:47:57','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_BankAccount_UU',TO_DATE('2011-03-29 10:47:57','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_BankAccount ADD C_BankAccount_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_BankAccount_UU_idx ON c_bankaccount(C_BankAccount_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54693,0,'C_BankAccount_Acct_UU',TO_DATE('2011-03-29 10:47:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_BankAccount_Acct_UU','C_BankAccount_Acct_UU',TO_DATE('2011-03-29 10:47:59','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60599,54693,0,10,391,'C_BankAccount_Acct_UU',TO_DATE('2011-03-29 10:47:59','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_BankAccount_Acct_UU',TO_DATE('2011-03-29 10:47:59','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_BankAccount_Acct ADD C_BankAccount_Acct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_BankAccount_Acct_UU_idx ON c_bankaccount_acct(C_BankAccount_Acct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54694,0,'C_BankAccountDoc_UU',TO_DATE('2011-03-29 10:48:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_BankAccountDoc_UU','C_BankAccountDoc_UU',TO_DATE('2011-03-29 10:48:01','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60600,54694,0,10,455,'C_BankAccountDoc_UU',TO_DATE('2011-03-29 10:48:01','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_BankAccountDoc_UU',TO_DATE('2011-03-29 10:48:01','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_BankAccountDoc ADD C_BankAccountDoc_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_BankAccountDoc_UU_idx ON c_bankaccountdoc(C_BankAccountDoc_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54695,0,'C_BankStatement_UU',TO_DATE('2011-03-29 10:48:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_BankStatement_UU','C_BankStatement_UU',TO_DATE('2011-03-29 10:48:05','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60601,54695,0,10,392,'C_BankStatement_UU',TO_DATE('2011-03-29 10:48:05','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_BankStatement_UU',TO_DATE('2011-03-29 10:48:05','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_BankStatement ADD C_BankStatement_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_BankStatement_UU_idx ON c_bankstatement(C_BankStatement_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54696,0,'C_BankStatementLine_UU',TO_DATE('2011-03-29 10:48:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_BankStatementLine_UU','C_BankStatementLine_UU',TO_DATE('2011-03-29 10:48:06','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60602,54696,0,10,393,'C_BankStatementLine_UU',TO_DATE('2011-03-29 10:48:06','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_BankStatementLine_UU',TO_DATE('2011-03-29 10:48:06','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_BankStatementLine ADD C_BankStatementLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_BankStatementLine_UU_idx ON c_bankstatementline(C_BankStatementLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54697,0,'C_BankStatementLoader_UU',TO_DATE('2011-03-29 10:48:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_BankStatementLoader_UU','C_BankStatementLoader_UU',TO_DATE('2011-03-29 10:48:09','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60603,54697,0,10,640,'C_BankStatementLoader_UU',TO_DATE('2011-03-29 10:48:09','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_BankStatementLoader_UU',TO_DATE('2011-03-29 10:48:09','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_BankStatementLoader ADD C_BankStatementLoader_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_BankStatementLoader_UU_idx ON c_bankstatementloader(C_BankStatementLoader_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54698,0,'C_BankStatementMatcher_UU',TO_DATE('2011-03-29 10:48:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_BankStatementMatcher_UU','C_BankStatementMatcher_UU',TO_DATE('2011-03-29 10:48:11','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60604,54698,0,10,658,'C_BankStatementMatcher_UU',TO_DATE('2011-03-29 10:48:11','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_BankStatementMatcher_UU',TO_DATE('2011-03-29 10:48:11','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_BankStatementMatcher ADD C_BankStatementMatcher_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_BankStatementMatcher_UU_idx ON c_bankstatementmatcher(C_BankStatementMatcher_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54699,0,'C_BPartner_UU',TO_DATE('2011-03-29 10:48:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_BPartner_UU','C_BPartner_UU',TO_DATE('2011-03-29 10:48:13','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60605,54699,0,10,291,'C_BPartner_UU',TO_DATE('2011-03-29 10:48:13','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_BPartner_UU',TO_DATE('2011-03-29 10:48:13','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_BPartner ADD C_BPartner_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_BPartner_UU_idx ON c_bpartner(C_BPartner_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54700,0,'C_BPartner_Location_UU',TO_DATE('2011-03-29 10:48:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_BPartner_Location_UU','C_BPartner_Location_UU',TO_DATE('2011-03-29 10:48:15','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60606,54700,0,10,293,'C_BPartner_Location_UU',TO_DATE('2011-03-29 10:48:15','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_BPartner_Location_UU',TO_DATE('2011-03-29 10:48:15','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_BPartner_Location ADD C_BPartner_Location_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_BPartner_Location_UU_idx ON c_bpartner_location(C_BPartner_Location_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54701,0,'C_BPartner_Product_UU',TO_DATE('2011-03-29 10:48:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_BPartner_Product_UU','C_BPartner_Product_UU',TO_DATE('2011-03-29 10:48:17','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60607,54701,0,10,632,'C_BPartner_Product_UU',TO_DATE('2011-03-29 10:48:17','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_BPartner_Product_UU',TO_DATE('2011-03-29 10:48:17','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_BPartner_Product ADD C_BPartner_Product_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_BPartner_Product_UU_idx ON c_bpartner_product(C_BPartner_Product_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54702,0,'C_BP_BankAccount_UU',TO_DATE('2011-03-29 10:48:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_BP_BankAccount_UU','C_BP_BankAccount_UU',TO_DATE('2011-03-29 10:48:19','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60608,54702,0,10,298,'C_BP_BankAccount_UU',TO_DATE('2011-03-29 10:48:19','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_BP_BankAccount_UU',TO_DATE('2011-03-29 10:48:19','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_BP_BankAccount ADD C_BP_BankAccount_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_BP_BankAccount_UU_idx ON c_bp_bankaccount(C_BP_BankAccount_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54703,0,'C_BP_Customer_Acct_UU',TO_DATE('2011-03-29 10:48:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_BP_Customer_Acct_UU','C_BP_Customer_Acct_UU',TO_DATE('2011-03-29 10:48:20','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60609,54703,0,10,183,'C_BP_Customer_Acct_UU',TO_DATE('2011-03-29 10:48:20','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_BP_Customer_Acct_UU',TO_DATE('2011-03-29 10:48:20','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_BP_Customer_Acct ADD C_BP_Customer_Acct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_BP_Customer_Acct_UU_idx ON c_bp_customer_acct(C_BP_Customer_Acct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54704,0,'C_BP_EDI_UU',TO_DATE('2011-03-29 10:48:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_BP_EDI_UU','C_BP_EDI_UU',TO_DATE('2011-03-29 10:48:22','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60610,54704,0,10,366,'C_BP_EDI_UU',TO_DATE('2011-03-29 10:48:22','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_BP_EDI_UU',TO_DATE('2011-03-29 10:48:22','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_BP_EDI ADD C_BP_EDI_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_BP_EDI_UU_idx ON c_bp_edi(C_BP_EDI_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54705,0,'C_BP_Employee_Acct_UU',TO_DATE('2011-03-29 10:48:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_BP_Employee_Acct_UU','C_BP_Employee_Acct_UU',TO_DATE('2011-03-29 10:48:23','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60611,54705,0,10,184,'C_BP_Employee_Acct_UU',TO_DATE('2011-03-29 10:48:23','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_BP_Employee_Acct_UU',TO_DATE('2011-03-29 10:48:23','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_BP_Employee_Acct ADD C_BP_Employee_Acct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_BP_Employee_Acct_UU_idx ON c_bp_employee_acct(C_BP_Employee_Acct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54706,0,'C_BP_Group_UU',TO_DATE('2011-03-29 10:48:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_BP_Group_UU','C_BP_Group_UU',TO_DATE('2011-03-29 10:48:25','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60612,54706,0,10,394,'C_BP_Group_UU',TO_DATE('2011-03-29 10:48:25','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_BP_Group_UU',TO_DATE('2011-03-29 10:48:25','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_BP_Group ADD C_BP_Group_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_BP_Group_UU_idx ON c_bp_group(C_BP_Group_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54707,0,'C_BP_Group_Acct_UU',TO_DATE('2011-03-29 10:48:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_BP_Group_Acct_UU','C_BP_Group_Acct_UU',TO_DATE('2011-03-29 10:48:26','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60613,54707,0,10,395,'C_BP_Group_Acct_UU',TO_DATE('2011-03-29 10:48:26','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_BP_Group_Acct_UU',TO_DATE('2011-03-29 10:48:26','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_BP_Group_Acct ADD C_BP_Group_Acct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_BP_Group_Acct_UU_idx ON c_bp_group_acct(C_BP_Group_Acct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54708,0,'C_BP_Relation_UU',TO_DATE('2011-03-29 10:48:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_BP_Relation_UU','C_BP_Relation_UU',TO_DATE('2011-03-29 10:48:28','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60614,54708,0,10,678,'C_BP_Relation_UU',TO_DATE('2011-03-29 10:48:28','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_BP_Relation_UU',TO_DATE('2011-03-29 10:48:28','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_BP_Relation ADD C_BP_Relation_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_BP_Relation_UU_idx ON c_bp_relation(C_BP_Relation_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54709,0,'C_BP_Vendor_Acct_UU',TO_DATE('2011-03-29 10:48:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_BP_Vendor_Acct_UU','C_BP_Vendor_Acct_UU',TO_DATE('2011-03-29 10:48:30','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60615,54709,0,10,185,'C_BP_Vendor_Acct_UU',TO_DATE('2011-03-29 10:48:30','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_BP_Vendor_Acct_UU',TO_DATE('2011-03-29 10:48:30','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_BP_Vendor_Acct ADD C_BP_Vendor_Acct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_BP_Vendor_Acct_UU_idx ON c_bp_vendor_acct(C_BP_Vendor_Acct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54710,0,'C_BP_Withholding_UU',TO_DATE('2011-03-29 10:48:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_BP_Withholding_UU','C_BP_Withholding_UU',TO_DATE('2011-03-29 10:48:32','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60616,54710,0,10,299,'C_BP_Withholding_UU',TO_DATE('2011-03-29 10:48:32','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_BP_Withholding_UU',TO_DATE('2011-03-29 10:48:32','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_BP_Withholding ADD C_BP_Withholding_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_BP_Withholding_UU_idx ON c_bp_withholding(C_BP_Withholding_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54711,0,'C_Calendar_UU',TO_DATE('2011-03-29 10:48:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Calendar_UU','C_Calendar_UU',TO_DATE('2011-03-29 10:48:33','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60617,54711,0,10,139,'C_Calendar_UU',TO_DATE('2011-03-29 10:48:33','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Calendar_UU',TO_DATE('2011-03-29 10:48:33','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Calendar ADD C_Calendar_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Calendar_UU_idx ON c_calendar(C_Calendar_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54712,0,'C_Campaign_UU',TO_DATE('2011-03-29 10:48:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Campaign_UU','C_Campaign_UU',TO_DATE('2011-03-29 10:48:34','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60618,54712,0,10,274,'C_Campaign_UU',TO_DATE('2011-03-29 10:48:34','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Campaign_UU',TO_DATE('2011-03-29 10:48:34','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Campaign ADD C_Campaign_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Campaign_UU_idx ON c_campaign(C_Campaign_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54713,0,'C_Cash_UU',TO_DATE('2011-03-29 10:48:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Cash_UU','C_Cash_UU',TO_DATE('2011-03-29 10:48:36','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60619,54713,0,10,407,'C_Cash_UU',TO_DATE('2011-03-29 10:48:36','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Cash_UU',TO_DATE('2011-03-29 10:48:36','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Cash ADD C_Cash_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Cash_UU_idx ON c_cash(C_Cash_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54714,0,'C_CashBook_UU',TO_DATE('2011-03-29 10:48:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_CashBook_UU','C_CashBook_UU',TO_DATE('2011-03-29 10:48:37','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60620,54714,0,10,408,'C_CashBook_UU',TO_DATE('2011-03-29 10:48:37','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_CashBook_UU',TO_DATE('2011-03-29 10:48:37','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_CashBook ADD C_CashBook_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_CashBook_UU_idx ON c_cashbook(C_CashBook_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54715,0,'C_CashBook_Acct_UU',TO_DATE('2011-03-29 10:48:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_CashBook_Acct_UU','C_CashBook_Acct_UU',TO_DATE('2011-03-29 10:48:39','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60621,54715,0,10,409,'C_CashBook_Acct_UU',TO_DATE('2011-03-29 10:48:39','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_CashBook_Acct_UU',TO_DATE('2011-03-29 10:48:39','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_CashBook_Acct ADD C_CashBook_Acct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_CashBook_Acct_UU_idx ON c_cashbook_acct(C_CashBook_Acct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54716,0,'C_CashLine_UU',TO_DATE('2011-03-29 10:48:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_CashLine_UU','C_CashLine_UU',TO_DATE('2011-03-29 10:48:40','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60622,54716,0,10,410,'C_CashLine_UU',TO_DATE('2011-03-29 10:48:40','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_CashLine_UU',TO_DATE('2011-03-29 10:48:40','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_CashLine ADD C_CashLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_CashLine_UU_idx ON c_cashline(C_CashLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54717,0,'C_CashPlan_UU',TO_DATE('2011-03-29 10:48:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_CashPlan_UU','C_CashPlan_UU',TO_DATE('2011-03-29 10:48:42','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60623,54717,0,10,53297,'C_CashPlan_UU',TO_DATE('2011-03-29 10:48:42','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_CashPlan_UU',TO_DATE('2011-03-29 10:48:42','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_CashPlan ADD C_CashPlan_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_CashPlan_UU_idx ON c_cashplan(C_CashPlan_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54718,0,'C_CashPlanLine_UU',TO_DATE('2011-03-29 10:48:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_CashPlanLine_UU','C_CashPlanLine_UU',TO_DATE('2011-03-29 10:48:44','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60624,54718,0,10,53298,'C_CashPlanLine_UU',TO_DATE('2011-03-29 10:48:44','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_CashPlanLine_UU',TO_DATE('2011-03-29 10:48:44','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_CashPlanLine ADD C_CashPlanLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_CashPlanLine_UU_idx ON c_cashplanline(C_CashPlanLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54719,0,'C_Channel_UU',TO_DATE('2011-03-29 10:48:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Channel_UU','C_Channel_UU',TO_DATE('2011-03-29 10:48:48','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60625,54719,0,10,275,'C_Channel_UU',TO_DATE('2011-03-29 10:48:48','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Channel_UU',TO_DATE('2011-03-29 10:48:48','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Channel ADD C_Channel_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Channel_UU_idx ON c_channel(C_Channel_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54720,0,'C_Charge_UU',TO_DATE('2011-03-29 10:48:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Charge_UU','C_Charge_UU',TO_DATE('2011-03-29 10:48:50','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60626,54720,0,10,313,'C_Charge_UU',TO_DATE('2011-03-29 10:48:50','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Charge_UU',TO_DATE('2011-03-29 10:48:50','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Charge ADD C_Charge_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Charge_UU_idx ON c_charge(C_Charge_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54721,0,'C_Charge_Acct_UU',TO_DATE('2011-03-29 10:48:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Charge_Acct_UU','C_Charge_Acct_UU',TO_DATE('2011-03-29 10:48:51','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60627,54721,0,10,396,'C_Charge_Acct_UU',TO_DATE('2011-03-29 10:48:51','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Charge_Acct_UU',TO_DATE('2011-03-29 10:48:51','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Charge_Acct ADD C_Charge_Acct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Charge_Acct_UU_idx ON c_charge_acct(C_Charge_Acct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54722,0,'C_Charge_Trl_UU',TO_DATE('2011-03-29 10:48:54','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Charge_Trl_UU','C_Charge_Trl_UU',TO_DATE('2011-03-29 10:48:54','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60628,54722,0,10,53187,'C_Charge_Trl_UU',TO_DATE('2011-03-29 10:48:54','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Charge_Trl_UU',TO_DATE('2011-03-29 10:48:54','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Charge_Trl ADD C_Charge_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Charge_Trl_UU_idx ON c_charge_trl(C_Charge_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54723,0,'C_ChargeType_UU',TO_DATE('2011-03-29 10:48:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_ChargeType_UU','C_ChargeType_UU',TO_DATE('2011-03-29 10:48:56','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60629,54723,0,10,53145,'C_ChargeType_UU',TO_DATE('2011-03-29 10:48:56','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_ChargeType_UU',TO_DATE('2011-03-29 10:48:56','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_ChargeType ADD C_ChargeType_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_ChargeType_UU_idx ON c_chargetype(C_ChargeType_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54724,0,'C_ChargeType_DocType_UU',TO_DATE('2011-03-29 10:48:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_ChargeType_DocType_UU','C_ChargeType_DocType_UU',TO_DATE('2011-03-29 10:48:57','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60630,54724,0,10,53146,'C_ChargeType_DocType_UU',TO_DATE('2011-03-29 10:48:57','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_ChargeType_DocType_UU',TO_DATE('2011-03-29 10:48:57','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_ChargeType_DocType ADD C_ChargeType_DocType_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_ChargeType_DocType_UU_idx ON c_chargetype_doctype(C_ChargeType_DocType_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54725,0,'C_City_UU',TO_DATE('2011-03-29 10:48:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_City_UU','C_City_UU',TO_DATE('2011-03-29 10:48:59','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60631,54725,0,10,186,'C_City_UU',TO_DATE('2011-03-29 10:48:59','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_City_UU',TO_DATE('2011-03-29 10:48:59','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_City ADD C_City_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_City_UU_idx ON c_city(C_City_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54726,0,'C_Commission_UU',TO_DATE('2011-03-29 10:49:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Commission_UU','C_Commission_UU',TO_DATE('2011-03-29 10:49:00','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60632,54726,0,10,429,'C_Commission_UU',TO_DATE('2011-03-29 10:49:00','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Commission_UU',TO_DATE('2011-03-29 10:49:00','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Commission ADD C_Commission_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Commission_UU_idx ON c_commission(C_Commission_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54727,0,'C_CommissionAmt_UU',TO_DATE('2011-03-29 10:49:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_CommissionAmt_UU','C_CommissionAmt_UU',TO_DATE('2011-03-29 10:49:02','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60633,54727,0,10,430,'C_CommissionAmt_UU',TO_DATE('2011-03-29 10:49:02','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_CommissionAmt_UU',TO_DATE('2011-03-29 10:49:02','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_CommissionAmt ADD C_CommissionAmt_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_CommissionAmt_UU_idx ON c_commissionamt(C_CommissionAmt_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54728,0,'C_CommissionDetail_UU',TO_DATE('2011-03-29 10:49:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_CommissionDetail_UU','C_CommissionDetail_UU',TO_DATE('2011-03-29 10:49:03','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60634,54728,0,10,437,'C_CommissionDetail_UU',TO_DATE('2011-03-29 10:49:03','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_CommissionDetail_UU',TO_DATE('2011-03-29 10:49:03','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_CommissionDetail ADD C_CommissionDetail_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_CommissionDetail_UU_idx ON c_commissiondetail(C_CommissionDetail_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54729,0,'C_CommissionLine_UU',TO_DATE('2011-03-29 10:49:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_CommissionLine_UU','C_CommissionLine_UU',TO_DATE('2011-03-29 10:49:04','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60635,54729,0,10,431,'C_CommissionLine_UU',TO_DATE('2011-03-29 10:49:04','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_CommissionLine_UU',TO_DATE('2011-03-29 10:49:04','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_CommissionLine ADD C_CommissionLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_CommissionLine_UU_idx ON c_commissionline(C_CommissionLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54730,0,'C_CommissionRun_UU',TO_DATE('2011-03-29 10:49:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_CommissionRun_UU','C_CommissionRun_UU',TO_DATE('2011-03-29 10:49:06','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60636,54730,0,10,436,'C_CommissionRun_UU',TO_DATE('2011-03-29 10:49:06','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_CommissionRun_UU',TO_DATE('2011-03-29 10:49:06','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_CommissionRun ADD C_CommissionRun_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_CommissionRun_UU_idx ON c_commissionrun(C_CommissionRun_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54731,0,'C_Conversion_Rate_UU',TO_DATE('2011-03-29 10:49:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Conversion_Rate_UU','C_Conversion_Rate_UU',TO_DATE('2011-03-29 10:49:07','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60637,54731,0,10,140,'C_Conversion_Rate_UU',TO_DATE('2011-03-29 10:49:07','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Conversion_Rate_UU',TO_DATE('2011-03-29 10:49:07','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Conversion_Rate ADD C_Conversion_Rate_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Conversion_Rate_UU_idx ON c_conversion_rate(C_Conversion_Rate_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54732,0,'C_ConversionType_UU',TO_DATE('2011-03-29 10:49:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_ConversionType_UU','C_ConversionType_UU',TO_DATE('2011-03-29 10:49:09','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60638,54732,0,10,637,'C_ConversionType_UU',TO_DATE('2011-03-29 10:49:09','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_ConversionType_UU',TO_DATE('2011-03-29 10:49:09','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_ConversionType ADD C_ConversionType_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_ConversionType_UU_idx ON c_conversiontype(C_ConversionType_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54733,0,'C_Country_UU',TO_DATE('2011-03-29 10:49:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Country_UU','C_Country_UU',TO_DATE('2011-03-29 10:49:10','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60639,54733,0,10,170,'C_Country_UU',TO_DATE('2011-03-29 10:49:10','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Country_UU',TO_DATE('2011-03-29 10:49:10','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Country ADD C_Country_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Country_UU_idx ON c_country(C_Country_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54734,0,'C_Country_Trl_UU',TO_DATE('2011-03-29 10:49:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Country_Trl_UU','C_Country_Trl_UU',TO_DATE('2011-03-29 10:49:11','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60640,54734,0,10,616,'C_Country_Trl_UU',TO_DATE('2011-03-29 10:49:11','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Country_Trl_UU',TO_DATE('2011-03-29 10:49:11','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Country_Trl ADD C_Country_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Country_Trl_UU_idx ON c_country_trl(C_Country_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54735,0,'C_Currency_UU',TO_DATE('2011-03-29 10:49:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Currency_UU','C_Currency_UU',TO_DATE('2011-03-29 10:49:13','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60641,54735,0,10,141,'C_Currency_UU',TO_DATE('2011-03-29 10:49:13','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Currency_UU',TO_DATE('2011-03-29 10:49:13','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Currency ADD C_Currency_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Currency_UU_idx ON c_currency(C_Currency_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54736,0,'C_Currency_Acct_UU',TO_DATE('2011-03-29 10:49:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Currency_Acct_UU','C_Currency_Acct_UU',TO_DATE('2011-03-29 10:49:15','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60642,54736,0,10,638,'C_Currency_Acct_UU',TO_DATE('2011-03-29 10:49:15','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Currency_Acct_UU',TO_DATE('2011-03-29 10:49:15','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Currency_Acct ADD C_Currency_Acct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Currency_Acct_UU_idx ON c_currency_acct(C_Currency_Acct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54737,0,'C_Currency_Trl_UU',TO_DATE('2011-03-29 10:49:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Currency_Trl_UU','C_Currency_Trl_UU',TO_DATE('2011-03-29 10:49:16','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60643,54737,0,10,617,'C_Currency_Trl_UU',TO_DATE('2011-03-29 10:49:16','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Currency_Trl_UU',TO_DATE('2011-03-29 10:49:16','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Currency_Trl ADD C_Currency_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Currency_Trl_UU_idx ON c_currency_trl(C_Currency_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54738,0,'C_Cycle_UU',TO_DATE('2011-03-29 10:49:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Cycle_UU','C_Cycle_UU',TO_DATE('2011-03-29 10:49:18','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60644,54738,0,10,432,'C_Cycle_UU',TO_DATE('2011-03-29 10:49:18','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Cycle_UU',TO_DATE('2011-03-29 10:49:18','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Cycle ADD C_Cycle_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Cycle_UU_idx ON c_cycle(C_Cycle_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54739,0,'C_CyclePhase_UU',TO_DATE('2011-03-29 10:49:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_CyclePhase_UU','C_CyclePhase_UU',TO_DATE('2011-03-29 10:49:21','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60645,54739,0,10,433,'C_CyclePhase_UU',TO_DATE('2011-03-29 10:49:21','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_CyclePhase_UU',TO_DATE('2011-03-29 10:49:21','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_CyclePhase ADD C_CyclePhase_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_CyclePhase_UU_idx ON c_cyclephase(C_CyclePhase_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54740,0,'C_CycleStep_UU',TO_DATE('2011-03-29 10:49:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_CycleStep_UU','C_CycleStep_UU',TO_DATE('2011-03-29 10:49:23','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60646,54740,0,10,590,'C_CycleStep_UU',TO_DATE('2011-03-29 10:49:23','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_CycleStep_UU',TO_DATE('2011-03-29 10:49:23','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_CycleStep ADD C_CycleStep_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_CycleStep_UU_idx ON c_cyclestep(C_CycleStep_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54741,0,'C_DocType_UU',TO_DATE('2011-03-29 10:49:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_DocType_UU','C_DocType_UU',TO_DATE('2011-03-29 10:49:25','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60647,54741,0,10,217,'C_DocType_UU',TO_DATE('2011-03-29 10:49:25','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_DocType_UU',TO_DATE('2011-03-29 10:49:25','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_DocType ADD C_DocType_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_DocType_UU_idx ON c_doctype(C_DocType_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54742,0,'C_DocTypeCounter_UU',TO_DATE('2011-03-29 10:49:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_DocTypeCounter_UU','C_DocTypeCounter_UU',TO_DATE('2011-03-29 10:49:27','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60648,54742,0,10,718,'C_DocTypeCounter_UU',TO_DATE('2011-03-29 10:49:27','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_DocTypeCounter_UU',TO_DATE('2011-03-29 10:49:27','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_DocTypeCounter ADD C_DocTypeCounter_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_DocTypeCounter_UU_idx ON c_doctypecounter(C_DocTypeCounter_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54743,0,'C_DocType_Trl_UU',TO_DATE('2011-03-29 10:49:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_DocType_Trl_UU','C_DocType_Trl_UU',TO_DATE('2011-03-29 10:49:28','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60649,54743,0,10,300,'C_DocType_Trl_UU',TO_DATE('2011-03-29 10:49:28','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_DocType_Trl_UU',TO_DATE('2011-03-29 10:49:28','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_DocType_Trl ADD C_DocType_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_DocType_Trl_UU_idx ON c_doctype_trl(C_DocType_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54744,0,'C_Dunning_UU',TO_DATE('2011-03-29 10:49:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Dunning_UU','C_Dunning_UU',TO_DATE('2011-03-29 10:49:30','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60650,54744,0,10,301,'C_Dunning_UU',TO_DATE('2011-03-29 10:49:30','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Dunning_UU',TO_DATE('2011-03-29 10:49:30','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Dunning ADD C_Dunning_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Dunning_UU_idx ON c_dunning(C_Dunning_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54745,0,'C_DunningLevel_UU',TO_DATE('2011-03-29 10:49:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_DunningLevel_UU','C_DunningLevel_UU',TO_DATE('2011-03-29 10:49:32','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60651,54745,0,10,331,'C_DunningLevel_UU',TO_DATE('2011-03-29 10:49:32','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_DunningLevel_UU',TO_DATE('2011-03-29 10:49:32','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_DunningLevel ADD C_DunningLevel_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_DunningLevel_UU_idx ON c_dunninglevel(C_DunningLevel_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54746,0,'C_DunningLevel_Trl_UU',TO_DATE('2011-03-29 10:49:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_DunningLevel_Trl_UU','C_DunningLevel_Trl_UU',TO_DATE('2011-03-29 10:49:34','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60652,54746,0,10,332,'C_DunningLevel_Trl_UU',TO_DATE('2011-03-29 10:49:34','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_DunningLevel_Trl_UU',TO_DATE('2011-03-29 10:49:34','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_DunningLevel_Trl ADD C_DunningLevel_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_DunningLevel_Trl_UU_idx ON c_dunninglevel_trl(C_DunningLevel_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54747,0,'C_DunningRun_UU',TO_DATE('2011-03-29 10:49:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_DunningRun_UU','C_DunningRun_UU',TO_DATE('2011-03-29 10:49:35','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60653,54747,0,10,526,'C_DunningRun_UU',TO_DATE('2011-03-29 10:49:35','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_DunningRun_UU',TO_DATE('2011-03-29 10:49:35','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_DunningRun ADD C_DunningRun_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_DunningRun_UU_idx ON c_dunningrun(C_DunningRun_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54748,0,'C_DunningRunEntry_UU',TO_DATE('2011-03-29 10:49:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_DunningRunEntry_UU','C_DunningRunEntry_UU',TO_DATE('2011-03-29 10:49:37','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60654,54748,0,10,527,'C_DunningRunEntry_UU',TO_DATE('2011-03-29 10:49:37','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_DunningRunEntry_UU',TO_DATE('2011-03-29 10:49:37','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_DunningRunEntry ADD C_DunningRunEntry_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_DunningRunEntry_UU_idx ON c_dunningrunentry(C_DunningRunEntry_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54749,0,'C_DunningRunLine_UU',TO_DATE('2011-03-29 10:49:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_DunningRunLine_UU','C_DunningRunLine_UU',TO_DATE('2011-03-29 10:49:38','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60655,54749,0,10,524,'C_DunningRunLine_UU',TO_DATE('2011-03-29 10:49:38','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_DunningRunLine_UU',TO_DATE('2011-03-29 10:49:38','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_DunningRunLine ADD C_DunningRunLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_DunningRunLine_UU_idx ON c_dunningrunline(C_DunningRunLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54750,0,'C_Element_UU',TO_DATE('2011-03-29 10:49:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Element_UU','C_Element_UU',TO_DATE('2011-03-29 10:49:40','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60656,54750,0,10,142,'C_Element_UU',TO_DATE('2011-03-29 10:49:40','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Element_UU',TO_DATE('2011-03-29 10:49:40','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Element ADD C_Element_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Element_UU_idx ON c_element(C_Element_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54751,0,'C_ElementValue_UU',TO_DATE('2011-03-29 10:49:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_ElementValue_UU','C_ElementValue_UU',TO_DATE('2011-03-29 10:49:41','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60657,54751,0,10,188,'C_ElementValue_UU',TO_DATE('2011-03-29 10:49:41','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_ElementValue_UU',TO_DATE('2011-03-29 10:49:41','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_ElementValue ADD C_ElementValue_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_ElementValue_UU_idx ON c_elementvalue(C_ElementValue_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54752,0,'C_ElementValue_Trl_UU',TO_DATE('2011-03-29 10:49:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_ElementValue_Trl_UU','C_ElementValue_Trl_UU',TO_DATE('2011-03-29 10:49:43','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60658,54752,0,10,302,'C_ElementValue_Trl_UU',TO_DATE('2011-03-29 10:49:43','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_ElementValue_Trl_UU',TO_DATE('2011-03-29 10:49:43','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_ElementValue_Trl ADD C_ElementValue_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_ElementValue_Trl_UU_idx ON c_elementvalue_trl(C_ElementValue_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54753,0,'C_Greeting_UU',TO_DATE('2011-03-29 10:49:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Greeting_UU','C_Greeting_UU',TO_DATE('2011-03-29 10:49:44','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60659,54753,0,10,346,'C_Greeting_UU',TO_DATE('2011-03-29 10:49:44','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Greeting_UU',TO_DATE('2011-03-29 10:49:44','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Greeting ADD C_Greeting_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Greeting_UU_idx ON c_greeting(C_Greeting_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54754,0,'C_Greeting_Trl_UU',TO_DATE('2011-03-29 10:49:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Greeting_Trl_UU','C_Greeting_Trl_UU',TO_DATE('2011-03-29 10:49:46','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60660,54754,0,10,347,'C_Greeting_Trl_UU',TO_DATE('2011-03-29 10:49:46','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Greeting_Trl_UU',TO_DATE('2011-03-29 10:49:46','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Greeting_Trl ADD C_Greeting_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Greeting_Trl_UU_idx ON c_greeting_trl(C_Greeting_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54755,0,'C_InterOrg_Acct_UU',TO_DATE('2011-03-29 10:49:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_InterOrg_Acct_UU','C_InterOrg_Acct_UU',TO_DATE('2011-03-29 10:49:47','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60661,54755,0,10,397,'C_InterOrg_Acct_UU',TO_DATE('2011-03-29 10:49:47','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_InterOrg_Acct_UU',TO_DATE('2011-03-29 10:49:47','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_InterOrg_Acct ADD C_InterOrg_Acct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_InterOrg_Acct_UU_idx ON c_interorg_acct(C_InterOrg_Acct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54756,0,'C_Invoice_UU',TO_DATE('2011-03-29 10:49:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Invoice_UU','C_Invoice_UU',TO_DATE('2011-03-29 10:49:49','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60662,54756,0,10,318,'C_Invoice_UU',TO_DATE('2011-03-29 10:49:49','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Invoice_UU',TO_DATE('2011-03-29 10:49:49','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Invoice ADD C_Invoice_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Invoice_UU_idx ON c_invoice(C_Invoice_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54757,0,'C_InvoiceBatch_UU',TO_DATE('2011-03-29 10:49:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_InvoiceBatch_UU','C_InvoiceBatch_UU',TO_DATE('2011-03-29 10:49:51','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60663,54757,0,10,767,'C_InvoiceBatch_UU',TO_DATE('2011-03-29 10:49:51','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_InvoiceBatch_UU',TO_DATE('2011-03-29 10:49:51','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_InvoiceBatch ADD C_InvoiceBatch_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_InvoiceBatch_UU_idx ON c_invoicebatch(C_InvoiceBatch_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54758,0,'C_InvoiceBatchLine_UU',TO_DATE('2011-03-29 10:49:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_InvoiceBatchLine_UU','C_InvoiceBatchLine_UU',TO_DATE('2011-03-29 10:49:52','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60664,54758,0,10,768,'C_InvoiceBatchLine_UU',TO_DATE('2011-03-29 10:49:52','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_InvoiceBatchLine_UU',TO_DATE('2011-03-29 10:49:52','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_InvoiceBatchLine ADD C_InvoiceBatchLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_InvoiceBatchLine_UU_idx ON c_invoicebatchline(C_InvoiceBatchLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54759,0,'C_InvoiceLine_UU',TO_DATE('2011-03-29 10:49:54','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_InvoiceLine_UU','C_InvoiceLine_UU',TO_DATE('2011-03-29 10:49:54','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60665,54759,0,10,333,'C_InvoiceLine_UU',TO_DATE('2011-03-29 10:49:54','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_InvoiceLine_UU',TO_DATE('2011-03-29 10:49:54','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_InvoiceLine ADD C_InvoiceLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_InvoiceLine_UU_idx ON c_invoiceline(C_InvoiceLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54760,0,'C_InvoicePaySchedule_UU',TO_DATE('2011-03-29 10:49:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_InvoicePaySchedule_UU','C_InvoicePaySchedule_UU',TO_DATE('2011-03-29 10:49:55','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60666,54760,0,10,551,'C_InvoicePaySchedule_UU',TO_DATE('2011-03-29 10:49:55','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_InvoicePaySchedule_UU',TO_DATE('2011-03-29 10:49:55','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_InvoicePaySchedule ADD C_InvoicePaySchedule_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_InvoicePaySchedule_UU_idx ON c_invoicepayschedule(C_InvoicePaySchedule_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54761,0,'C_InvoiceSchedule_UU',TO_DATE('2011-03-29 10:49:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_InvoiceSchedule_UU','C_InvoiceSchedule_UU',TO_DATE('2011-03-29 10:49:57','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60667,54761,0,10,257,'C_InvoiceSchedule_UU',TO_DATE('2011-03-29 10:49:57','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_InvoiceSchedule_UU',TO_DATE('2011-03-29 10:49:57','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_InvoiceSchedule ADD C_InvoiceSchedule_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_InvoiceSchedule_UU_idx ON c_invoiceschedule(C_InvoiceSchedule_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54762,0,'C_InvoiceTax_UU',TO_DATE('2011-03-29 10:50:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_InvoiceTax_UU','C_InvoiceTax_UU',TO_DATE('2011-03-29 10:50:00','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60668,54762,0,10,334,'C_InvoiceTax_UU',TO_DATE('2011-03-29 10:50:00','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_InvoiceTax_UU',TO_DATE('2011-03-29 10:50:00','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_InvoiceTax ADD C_InvoiceTax_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_InvoiceTax_UU_idx ON c_invoicetax(C_InvoiceTax_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54763,0,'C_Job_UU',TO_DATE('2011-03-29 10:50:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Job_UU','C_Job_UU',TO_DATE('2011-03-29 10:50:01','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60669,54763,0,10,789,'C_Job_UU',TO_DATE('2011-03-29 10:50:01','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Job_UU',TO_DATE('2011-03-29 10:50:01','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Job ADD C_Job_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Job_UU_idx ON c_job(C_Job_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54764,0,'C_JobAssignment_UU',TO_DATE('2011-03-29 10:50:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_JobAssignment_UU','C_JobAssignment_UU',TO_DATE('2011-03-29 10:50:03','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60670,54764,0,10,791,'C_JobAssignment_UU',TO_DATE('2011-03-29 10:50:03','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_JobAssignment_UU',TO_DATE('2011-03-29 10:50:03','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_JobAssignment ADD C_JobAssignment_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_JobAssignment_UU_idx ON c_jobassignment(C_JobAssignment_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54765,0,'C_JobCategory_UU',TO_DATE('2011-03-29 10:50:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_JobCategory_UU','C_JobCategory_UU',TO_DATE('2011-03-29 10:50:04','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60671,54765,0,10,790,'C_JobCategory_UU',TO_DATE('2011-03-29 10:50:04','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_JobCategory_UU',TO_DATE('2011-03-29 10:50:04','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_JobCategory ADD C_JobCategory_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_JobCategory_UU_idx ON c_jobcategory(C_JobCategory_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54766,0,'C_JobRemuneration_UU',TO_DATE('2011-03-29 10:50:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_JobRemuneration_UU','C_JobRemuneration_UU',TO_DATE('2011-03-29 10:50:06','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60672,54766,0,10,793,'C_JobRemuneration_UU',TO_DATE('2011-03-29 10:50:06','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_JobRemuneration_UU',TO_DATE('2011-03-29 10:50:06','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_JobRemuneration ADD C_JobRemuneration_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_JobRemuneration_UU_idx ON c_jobremuneration(C_JobRemuneration_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54767,0,'C_LandedCost_UU',TO_DATE('2011-03-29 10:50:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_LandedCost_UU','C_LandedCost_UU',TO_DATE('2011-03-29 10:50:07','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60673,54767,0,10,759,'C_LandedCost_UU',TO_DATE('2011-03-29 10:50:07','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_LandedCost_UU',TO_DATE('2011-03-29 10:50:07','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_LandedCost ADD C_LandedCost_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_LandedCost_UU_idx ON c_landedcost(C_LandedCost_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54768,0,'C_LandedCostAllocation_UU',TO_DATE('2011-03-29 10:50:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_LandedCostAllocation_UU','C_LandedCostAllocation_UU',TO_DATE('2011-03-29 10:50:10','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60674,54768,0,10,760,'C_LandedCostAllocation_UU',TO_DATE('2011-03-29 10:50:10','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_LandedCostAllocation_UU',TO_DATE('2011-03-29 10:50:10','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_LandedCostAllocation ADD C_LandedCostAllocation_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_LandedCostAllocation_UU_idx ON c_landedcostallocation(C_LandedCostAllocation_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54769,0,'C_Location_UU',TO_DATE('2011-03-29 10:50:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Location_UU','C_Location_UU',TO_DATE('2011-03-29 10:50:14','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60675,54769,0,10,162,'C_Location_UU',TO_DATE('2011-03-29 10:50:14','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Location_UU',TO_DATE('2011-03-29 10:50:14','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Location ADD C_Location_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Location_UU_idx ON c_location(C_Location_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54770,0,'CM_AccessContainer_UU',TO_DATE('2011-03-29 10:50:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_AccessContainer_UU','CM_AccessContainer_UU',TO_DATE('2011-03-29 10:50:15','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60676,54770,0,10,888,'CM_AccessContainer_UU',TO_DATE('2011-03-29 10:50:15','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_AccessContainer_UU',TO_DATE('2011-03-29 10:50:15','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_AccessContainer ADD CM_AccessContainer_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_AccessContainer_UU_idx ON cm_accesscontainer(CM_AccessContainer_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54771,0,'CM_AccessListBPGroup_UU',TO_DATE('2011-03-29 10:50:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_AccessListBPGroup_UU','CM_AccessListBPGroup_UU',TO_DATE('2011-03-29 10:50:17','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60677,54771,0,10,886,'CM_AccessListBPGroup_UU',TO_DATE('2011-03-29 10:50:17','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_AccessListBPGroup_UU',TO_DATE('2011-03-29 10:50:17','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_AccessListBPGroup ADD CM_AccessListBPGroup_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_AccessListBPGroup_UU_idx ON cm_accesslistbpgroup(CM_AccessListBPGroup_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54772,0,'CM_AccessListRole_UU',TO_DATE('2011-03-29 10:50:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_AccessListRole_UU','CM_AccessListRole_UU',TO_DATE('2011-03-29 10:50:19','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60678,54772,0,10,887,'CM_AccessListRole_UU',TO_DATE('2011-03-29 10:50:19','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_AccessListRole_UU',TO_DATE('2011-03-29 10:50:19','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_AccessListRole ADD CM_AccessListRole_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_AccessListRole_UU_idx ON cm_accesslistrole(CM_AccessListRole_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54773,0,'CM_AccessMedia_UU',TO_DATE('2011-03-29 10:50:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_AccessMedia_UU','CM_AccessMedia_UU',TO_DATE('2011-03-29 10:50:21','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60679,54773,0,10,890,'CM_AccessMedia_UU',TO_DATE('2011-03-29 10:50:21','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_AccessMedia_UU',TO_DATE('2011-03-29 10:50:21','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_AccessMedia ADD CM_AccessMedia_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_AccessMedia_UU_idx ON cm_accessmedia(CM_AccessMedia_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54774,0,'CM_AccessNewsChannel_UU',TO_DATE('2011-03-29 10:50:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_AccessNewsChannel_UU','CM_AccessNewsChannel_UU',TO_DATE('2011-03-29 10:50:24','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60680,54774,0,10,891,'CM_AccessNewsChannel_UU',TO_DATE('2011-03-29 10:50:24','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_AccessNewsChannel_UU',TO_DATE('2011-03-29 10:50:24','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_AccessNewsChannel ADD CM_AccessNewsChannel_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_AccessNewsChannel_UU_idx ON cm_accessnewschannel(CM_AccessNewsChannel_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54775,0,'CM_AccessProfile_UU',TO_DATE('2011-03-29 10:50:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_AccessProfile_UU','CM_AccessProfile_UU',TO_DATE('2011-03-29 10:50:25','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60681,54775,0,10,885,'CM_AccessProfile_UU',TO_DATE('2011-03-29 10:50:25','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_AccessProfile_UU',TO_DATE('2011-03-29 10:50:25','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_AccessProfile ADD CM_AccessProfile_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_AccessProfile_UU_idx ON cm_accessprofile(CM_AccessProfile_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54776,0,'CM_AccessStage_UU',TO_DATE('2011-03-29 10:50:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_AccessStage_UU','CM_AccessStage_UU',TO_DATE('2011-03-29 10:50:26','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60682,54776,0,10,889,'CM_AccessStage_UU',TO_DATE('2011-03-29 10:50:26','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_AccessStage_UU',TO_DATE('2011-03-29 10:50:26','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_AccessStage ADD CM_AccessStage_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_AccessStage_UU_idx ON cm_accessstage(CM_AccessStage_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54777,0,'CM_Ad_UU',TO_DATE('2011-03-29 10:50:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_Ad_UU','CM_Ad_UU',TO_DATE('2011-03-29 10:50:28','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60683,54777,0,10,858,'CM_Ad_UU',TO_DATE('2011-03-29 10:50:28','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_Ad_UU',TO_DATE('2011-03-29 10:50:28','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_Ad ADD CM_Ad_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_Ad_UU_idx ON cm_ad(CM_Ad_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54778,0,'CM_Ad_Cat_UU',TO_DATE('2011-03-29 10:50:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_Ad_Cat_UU','CM_Ad_Cat_UU',TO_DATE('2011-03-29 10:50:29','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60684,54778,0,10,856,'CM_Ad_Cat_UU',TO_DATE('2011-03-29 10:50:29','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_Ad_Cat_UU',TO_DATE('2011-03-29 10:50:29','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_Ad_Cat ADD CM_Ad_Cat_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_Ad_Cat_UU_idx ON cm_ad_cat(CM_Ad_Cat_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54779,0,'CM_BroadcastServer_UU',TO_DATE('2011-03-29 10:50:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_BroadcastServer_UU','CM_BroadcastServer_UU',TO_DATE('2011-03-29 10:50:31','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60685,54779,0,10,893,'CM_BroadcastServer_UU',TO_DATE('2011-03-29 10:50:31','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_BroadcastServer_UU',TO_DATE('2011-03-29 10:50:31','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_BroadcastServer ADD CM_BroadcastServer_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_BroadcastServer_UU_idx ON cm_broadcastserver(CM_BroadcastServer_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54780,0,'CM_Chat_UU',TO_DATE('2011-03-29 10:50:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_Chat_UU','CM_Chat_UU',TO_DATE('2011-03-29 10:50:33','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60686,54780,0,10,876,'CM_Chat_UU',TO_DATE('2011-03-29 10:50:33','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_Chat_UU',TO_DATE('2011-03-29 10:50:33','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_Chat ADD CM_Chat_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_Chat_UU_idx ON cm_chat(CM_Chat_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54781,0,'CM_ChatEntry_UU',TO_DATE('2011-03-29 10:50:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_ChatEntry_UU','CM_ChatEntry_UU',TO_DATE('2011-03-29 10:50:35','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60687,54781,0,10,877,'CM_ChatEntry_UU',TO_DATE('2011-03-29 10:50:35','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_ChatEntry_UU',TO_DATE('2011-03-29 10:50:35','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_ChatEntry ADD CM_ChatEntry_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_ChatEntry_UU_idx ON cm_chatentry(CM_ChatEntry_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54782,0,'CM_ChatType_UU',TO_DATE('2011-03-29 10:50:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_ChatType_UU','CM_ChatType_UU',TO_DATE('2011-03-29 10:50:36','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60688,54782,0,10,874,'CM_ChatType_UU',TO_DATE('2011-03-29 10:50:36','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_ChatType_UU',TO_DATE('2011-03-29 10:50:36','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_ChatType ADD CM_ChatType_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_ChatType_UU_idx ON cm_chattype(CM_ChatType_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54783,0,'CM_ChatTypeUpdate_UU',TO_DATE('2011-03-29 10:50:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_ChatTypeUpdate_UU','CM_ChatTypeUpdate_UU',TO_DATE('2011-03-29 10:50:38','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60689,54783,0,10,875,'CM_ChatTypeUpdate_UU',TO_DATE('2011-03-29 10:50:38','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_ChatTypeUpdate_UU',TO_DATE('2011-03-29 10:50:38','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_ChatTypeUpdate ADD CM_ChatTypeUpdate_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_ChatTypeUpdate_UU_idx ON cm_chattypeupdate(CM_ChatTypeUpdate_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54784,0,'CM_ChatUpdate_UU',TO_DATE('2011-03-29 10:50:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_ChatUpdate_UU','CM_ChatUpdate_UU',TO_DATE('2011-03-29 10:50:39','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60690,54784,0,10,878,'CM_ChatUpdate_UU',TO_DATE('2011-03-29 10:50:39','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_ChatUpdate_UU',TO_DATE('2011-03-29 10:50:39','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_ChatUpdate ADD CM_ChatUpdate_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_ChatUpdate_UU_idx ON cm_chatupdate(CM_ChatUpdate_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54785,0,'CM_Container_UU',TO_DATE('2011-03-29 10:50:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_Container_UU','CM_Container_UU',TO_DATE('2011-03-29 10:50:41','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60691,54785,0,10,855,'CM_Container_UU',TO_DATE('2011-03-29 10:50:41','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_Container_UU',TO_DATE('2011-03-29 10:50:41','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_Container ADD CM_Container_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_Container_UU_idx ON cm_container(CM_Container_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54786,0,'CM_Container_Element_UU',TO_DATE('2011-03-29 10:50:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_Container_Element_UU','CM_Container_Element_UU',TO_DATE('2011-03-29 10:50:42','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60692,54786,0,10,860,'CM_Container_Element_UU',TO_DATE('2011-03-29 10:50:42','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_Container_Element_UU',TO_DATE('2011-03-29 10:50:42','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_Container_Element ADD CM_Container_Element_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_Container_Element_UU_idx ON cm_container_element(CM_Container_Element_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54787,0,'CM_Container_Element_Trl_UU',TO_DATE('2011-03-29 10:50:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_Container_Element_Trl_UU','CM_Container_Element_Trl_UU',TO_DATE('2011-03-29 10:50:44','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60693,54787,0,10,861,'CM_Container_Element_Trl_UU',TO_DATE('2011-03-29 10:50:44','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_Container_Element_Trl_UU',TO_DATE('2011-03-29 10:50:44','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_Container_Element_Trl ADD CM_Container_Element_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_Container_Element_Tr_UU_idx ON cm_container_element_trl(CM_Container_Element_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54788,0,'CM_Container_Trl_UU',TO_DATE('2011-03-29 10:50:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_Container_Trl_UU','CM_Container_Trl_UU',TO_DATE('2011-03-29 10:50:45','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60694,54788,0,10,864,'CM_Container_Trl_UU',TO_DATE('2011-03-29 10:50:45','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_Container_Trl_UU',TO_DATE('2011-03-29 10:50:45','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_Container_Trl ADD CM_Container_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_Container_Trl_UU_idx ON cm_container_trl(CM_Container_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54789,0,'CM_ContainerTTable_UU',TO_DATE('2011-03-29 10:50:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_ContainerTTable_UU','CM_ContainerTTable_UU',TO_DATE('2011-03-29 10:50:47','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60695,54789,0,10,880,'CM_ContainerTTable_UU',TO_DATE('2011-03-29 10:50:47','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_ContainerTTable_UU',TO_DATE('2011-03-29 10:50:47','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_ContainerTTable ADD CM_ContainerTTable_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_ContainerTTable_UU_idx ON cm_containerttable(CM_ContainerTTable_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54790,0,'CM_Container_URL_UU',TO_DATE('2011-03-29 10:50:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_Container_URL_UU','CM_Container_URL_UU',TO_DATE('2011-03-29 10:50:48','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60696,54790,0,10,865,'CM_Container_URL_UU',TO_DATE('2011-03-29 10:50:48','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_Container_URL_UU',TO_DATE('2011-03-29 10:50:48','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_Container_URL ADD CM_Container_URL_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_Container_URL_UU_idx ON cm_container_url(CM_Container_URL_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54791,0,'CM_CStage_UU',TO_DATE('2011-03-29 10:50:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_CStage_UU','CM_CStage_UU',TO_DATE('2011-03-29 10:50:50','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60697,54791,0,10,866,'CM_CStage_UU',TO_DATE('2011-03-29 10:50:50','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_CStage_UU',TO_DATE('2011-03-29 10:50:50','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_CStage ADD CM_CStage_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_CStage_UU_idx ON cm_cstage(CM_CStage_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54792,0,'CM_CStage_Element_UU',TO_DATE('2011-03-29 10:50:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_CStage_Element_UU','CM_CStage_Element_UU',TO_DATE('2011-03-29 10:50:52','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60698,54792,0,10,867,'CM_CStage_Element_UU',TO_DATE('2011-03-29 10:50:52','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_CStage_Element_UU',TO_DATE('2011-03-29 10:50:52','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_CStage_Element ADD CM_CStage_Element_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_CStage_Element_UU_idx ON cm_cstage_element(CM_CStage_Element_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54793,0,'CM_CStage_Element_Trl_UU',TO_DATE('2011-03-29 10:50:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_CStage_Element_Trl_UU','CM_CStage_Element_Trl_UU',TO_DATE('2011-03-29 10:50:53','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60699,54793,0,10,868,'CM_CStage_Element_Trl_UU',TO_DATE('2011-03-29 10:50:53','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_CStage_Element_Trl_UU',TO_DATE('2011-03-29 10:50:53','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_CStage_Element_Trl ADD CM_CStage_Element_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_CStage_Element_Trl_UU_idx ON cm_cstage_element_trl(CM_CStage_Element_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54794,0,'CM_CStage_Trl_UU',TO_DATE('2011-03-29 10:50:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_CStage_Trl_UU','CM_CStage_Trl_UU',TO_DATE('2011-03-29 10:50:55','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60700,54794,0,10,869,'CM_CStage_Trl_UU',TO_DATE('2011-03-29 10:50:55','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_CStage_Trl_UU',TO_DATE('2011-03-29 10:50:55','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_CStage_Trl ADD CM_CStage_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_CStage_Trl_UU_idx ON cm_cstage_trl(CM_CStage_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54795,0,'CM_CStageTTable_UU',TO_DATE('2011-03-29 10:50:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_CStageTTable_UU','CM_CStageTTable_UU',TO_DATE('2011-03-29 10:50:56','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60701,54795,0,10,881,'CM_CStageTTable_UU',TO_DATE('2011-03-29 10:50:56','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_CStageTTable_UU',TO_DATE('2011-03-29 10:50:56','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_CStageTTable ADD CM_CStageTTable_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_CStageTTable_UU_idx ON cm_cstagettable(CM_CStageTTable_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54796,0,'CM_Media_UU',TO_DATE('2011-03-29 10:50:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_Media_UU','CM_Media_UU',TO_DATE('2011-03-29 10:50:57','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60702,54796,0,10,857,'CM_Media_UU',TO_DATE('2011-03-29 10:50:57','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_Media_UU',TO_DATE('2011-03-29 10:50:57','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_Media ADD CM_Media_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_Media_UU_idx ON cm_media(CM_Media_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54797,0,'CM_MediaDeploy_UU',TO_DATE('2011-03-29 10:50:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_MediaDeploy_UU','CM_MediaDeploy_UU',TO_DATE('2011-03-29 10:50:59','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60703,54797,0,10,892,'CM_MediaDeploy_UU',TO_DATE('2011-03-29 10:50:59','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_MediaDeploy_UU',TO_DATE('2011-03-29 10:50:59','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_MediaDeploy ADD CM_MediaDeploy_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_MediaDeploy_UU_idx ON cm_mediadeploy(CM_MediaDeploy_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54798,0,'CM_Media_Server_UU',TO_DATE('2011-03-29 10:51:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_Media_Server_UU','CM_Media_Server_UU',TO_DATE('2011-03-29 10:51:00','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60704,54798,0,10,859,'CM_Media_Server_UU',TO_DATE('2011-03-29 10:51:00','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_Media_Server_UU',TO_DATE('2011-03-29 10:51:00','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_Media_Server ADD CM_Media_Server_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_Media_Server_UU_idx ON cm_media_server(CM_Media_Server_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54799,0,'CM_NewsChannel_UU',TO_DATE('2011-03-29 10:51:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_NewsChannel_UU','CM_NewsChannel_UU',TO_DATE('2011-03-29 10:51:02','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60705,54799,0,10,870,'CM_NewsChannel_UU',TO_DATE('2011-03-29 10:51:02','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_NewsChannel_UU',TO_DATE('2011-03-29 10:51:02','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_NewsChannel ADD CM_NewsChannel_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_NewsChannel_UU_idx ON cm_newschannel(CM_NewsChannel_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54800,0,'CM_NewsItem_UU',TO_DATE('2011-03-29 10:51:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_NewsItem_UU','CM_NewsItem_UU',TO_DATE('2011-03-29 10:51:03','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60706,54800,0,10,871,'CM_NewsItem_UU',TO_DATE('2011-03-29 10:51:03','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_NewsItem_UU',TO_DATE('2011-03-29 10:51:03','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_NewsItem ADD CM_NewsItem_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_NewsItem_UU_idx ON cm_newsitem(CM_NewsItem_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54801,0,'CM_Template_UU',TO_DATE('2011-03-29 10:51:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_Template_UU','CM_Template_UU',TO_DATE('2011-03-29 10:51:05','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60707,54801,0,10,854,'CM_Template_UU',TO_DATE('2011-03-29 10:51:05','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_Template_UU',TO_DATE('2011-03-29 10:51:05','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_Template ADD CM_Template_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_Template_UU_idx ON cm_template(CM_Template_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54802,0,'CM_Template_Ad_Cat_UU',TO_DATE('2011-03-29 10:51:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_Template_Ad_Cat_UU','CM_Template_Ad_Cat_UU',TO_DATE('2011-03-29 10:51:06','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60708,54802,0,10,872,'CM_Template_Ad_Cat_UU',TO_DATE('2011-03-29 10:51:06','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_Template_Ad_Cat_UU',TO_DATE('2011-03-29 10:51:06','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_Template_Ad_Cat ADD CM_Template_Ad_Cat_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_Template_Ad_Cat_UU_idx ON cm_template_ad_cat(CM_Template_Ad_Cat_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54803,0,'CM_TemplateTable_UU',TO_DATE('2011-03-29 10:51:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_TemplateTable_UU','CM_TemplateTable_UU',TO_DATE('2011-03-29 10:51:08','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60709,54803,0,10,879,'CM_TemplateTable_UU',TO_DATE('2011-03-29 10:51:08','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_TemplateTable_UU',TO_DATE('2011-03-29 10:51:08','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_TemplateTable ADD CM_TemplateTable_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_TemplateTable_UU_idx ON cm_templatetable(CM_TemplateTable_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54804,0,'CM_WebAccessLog_UU',TO_DATE('2011-03-29 10:51:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_WebAccessLog_UU','CM_WebAccessLog_UU',TO_DATE('2011-03-29 10:51:09','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60710,54804,0,10,894,'CM_WebAccessLog_UU',TO_DATE('2011-03-29 10:51:09','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_WebAccessLog_UU',TO_DATE('2011-03-29 10:51:09','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_WebAccessLog ADD CM_WebAccessLog_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_WebAccessLog_UU_idx ON cm_webaccesslog(CM_WebAccessLog_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54805,0,'CM_WebProject_UU',TO_DATE('2011-03-29 10:51:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_WebProject_UU','CM_WebProject_UU',TO_DATE('2011-03-29 10:51:11','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60711,54805,0,10,853,'CM_WebProject_UU',TO_DATE('2011-03-29 10:51:11','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_WebProject_UU',TO_DATE('2011-03-29 10:51:11','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_WebProject ADD CM_WebProject_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_WebProject_UU_idx ON cm_webproject(CM_WebProject_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54806,0,'CM_WebProject_Domain_UU',TO_DATE('2011-03-29 10:51:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_WebProject_Domain_UU','CM_WebProject_Domain_UU',TO_DATE('2011-03-29 10:51:12','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60712,54806,0,10,873,'CM_WebProject_Domain_UU',TO_DATE('2011-03-29 10:51:12','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_WebProject_Domain_UU',TO_DATE('2011-03-29 10:51:12','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_WebProject_Domain ADD CM_WebProject_Domain_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_WebProject_Domain_UU_idx ON cm_webproject_domain(CM_WebProject_Domain_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54807,0,'CM_WikiToken_UU',TO_DATE('2011-03-29 10:51:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','CM_WikiToken_UU','CM_WikiToken_UU',TO_DATE('2011-03-29 10:51:14','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60713,54807,0,10,905,'CM_WikiToken_UU',TO_DATE('2011-03-29 10:51:13','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','CM_WikiToken_UU',TO_DATE('2011-03-29 10:51:13','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE CM_WikiToken ADD CM_WikiToken_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX CM_WikiToken_UU_idx ON cm_wikitoken(CM_WikiToken_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54808,0,'C_NonBusinessDay_UU',TO_DATE('2011-03-29 10:51:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_NonBusinessDay_UU','C_NonBusinessDay_UU',TO_DATE('2011-03-29 10:51:15','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60714,54808,0,10,163,'C_NonBusinessDay_UU',TO_DATE('2011-03-29 10:51:15','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_NonBusinessDay_UU',TO_DATE('2011-03-29 10:51:15','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_NonBusinessDay ADD C_NonBusinessDay_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_NonBusinessDay_UU_idx ON c_nonbusinessday(C_NonBusinessDay_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54809,0,'C_Order_UU',TO_DATE('2011-03-29 10:51:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Order_UU','C_Order_UU',TO_DATE('2011-03-29 10:51:17','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60715,54809,0,10,259,'C_Order_UU',TO_DATE('2011-03-29 10:51:17','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Order_UU',TO_DATE('2011-03-29 10:51:17','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Order ADD C_Order_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Order_UU_idx ON c_order(C_Order_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54810,0,'C_OrderLine_UU',TO_DATE('2011-03-29 10:51:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_OrderLine_UU','C_OrderLine_UU',TO_DATE('2011-03-29 10:51:19','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60716,54810,0,10,260,'C_OrderLine_UU',TO_DATE('2011-03-29 10:51:19','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_OrderLine_UU',TO_DATE('2011-03-29 10:51:19','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_OrderLine ADD C_OrderLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_OrderLine_UU_idx ON c_orderline(C_OrderLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54811,0,'C_OrderPaySchedule_UU',TO_DATE('2011-03-29 10:51:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_OrderPaySchedule_UU','C_OrderPaySchedule_UU',TO_DATE('2011-03-29 10:51:20','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60717,54811,0,10,53296,'C_OrderPaySchedule_UU',TO_DATE('2011-03-29 10:51:20','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_OrderPaySchedule_UU',TO_DATE('2011-03-29 10:51:20','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_OrderPaySchedule ADD C_OrderPaySchedule_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_OrderPaySchedule_UU_idx ON c_orderpayschedule(C_OrderPaySchedule_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54812,0,'C_OrderSource_UU',TO_DATE('2011-03-29 10:51:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_OrderSource_UU','C_OrderSource_UU',TO_DATE('2011-03-29 10:51:22','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60718,54812,0,10,53244,'C_OrderSource_UU',TO_DATE('2011-03-29 10:51:22','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_OrderSource_UU',TO_DATE('2011-03-29 10:51:22','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_OrderSource ADD C_OrderSource_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_OrderSource_UU_idx ON c_ordersource(C_OrderSource_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54813,0,'C_OrderTax_UU',TO_DATE('2011-03-29 10:51:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_OrderTax_UU','C_OrderTax_UU',TO_DATE('2011-03-29 10:51:23','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60719,54813,0,10,314,'C_OrderTax_UU',TO_DATE('2011-03-29 10:51:23','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_OrderTax_UU',TO_DATE('2011-03-29 10:51:23','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_OrderTax ADD C_OrderTax_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_OrderTax_UU_idx ON c_ordertax(C_OrderTax_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54814,0,'C_OrgAssignment_UU',TO_DATE('2011-03-29 10:51:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_OrgAssignment_UU','C_OrgAssignment_UU',TO_DATE('2011-03-29 10:51:25','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60720,54814,0,10,585,'C_OrgAssignment_UU',TO_DATE('2011-03-29 10:51:25','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_OrgAssignment_UU',TO_DATE('2011-03-29 10:51:25','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_OrgAssignment ADD C_OrgAssignment_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_OrgAssignment_UU_idx ON c_orgassignment(C_OrgAssignment_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54815,0,'C_Payment_UU',TO_DATE('2011-03-29 10:51:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Payment_UU','C_Payment_UU',TO_DATE('2011-03-29 10:51:26','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60721,54815,0,10,335,'C_Payment_UU',TO_DATE('2011-03-29 10:51:26','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Payment_UU',TO_DATE('2011-03-29 10:51:26','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Payment ADD C_Payment_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Payment_UU_idx ON c_payment(C_Payment_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54816,0,'C_PaymentAllocate_UU',TO_DATE('2011-03-29 10:51:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_PaymentAllocate_UU','C_PaymentAllocate_UU',TO_DATE('2011-03-29 10:51:28','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60722,54816,0,10,812,'C_PaymentAllocate_UU',TO_DATE('2011-03-29 10:51:28','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_PaymentAllocate_UU',TO_DATE('2011-03-29 10:51:28','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_PaymentAllocate ADD C_PaymentAllocate_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_PaymentAllocate_UU_idx ON c_paymentallocate(C_PaymentAllocate_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54817,0,'C_PaymentBatch_UU',TO_DATE('2011-03-29 10:51:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_PaymentBatch_UU','C_PaymentBatch_UU',TO_DATE('2011-03-29 10:51:30','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60723,54817,0,10,411,'C_PaymentBatch_UU',TO_DATE('2011-03-29 10:51:30','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_PaymentBatch_UU',TO_DATE('2011-03-29 10:51:30','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_PaymentBatch ADD C_PaymentBatch_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_PaymentBatch_UU_idx ON c_paymentbatch(C_PaymentBatch_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54818,0,'C_PaymentProcessor_UU',TO_DATE('2011-03-29 10:51:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_PaymentProcessor_UU','C_PaymentProcessor_UU',TO_DATE('2011-03-29 10:51:32','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60724,54818,0,10,398,'C_PaymentProcessor_UU',TO_DATE('2011-03-29 10:51:32','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_PaymentProcessor_UU',TO_DATE('2011-03-29 10:51:32','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_PaymentProcessor ADD C_PaymentProcessor_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_PaymentProcessor_UU_idx ON c_paymentprocessor(C_PaymentProcessor_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54819,0,'C_PaymentTerm_UU',TO_DATE('2011-03-29 10:51:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_PaymentTerm_UU','C_PaymentTerm_UU',TO_DATE('2011-03-29 10:51:34','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60725,54819,0,10,113,'C_PaymentTerm_UU',TO_DATE('2011-03-29 10:51:34','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_PaymentTerm_UU',TO_DATE('2011-03-29 10:51:34','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_PaymentTerm ADD C_PaymentTerm_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_PaymentTerm_UU_idx ON c_paymentterm(C_PaymentTerm_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54820,0,'C_PaymentTerm_Trl_UU',TO_DATE('2011-03-29 10:51:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_PaymentTerm_Trl_UU','C_PaymentTerm_Trl_UU',TO_DATE('2011-03-29 10:51:35','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60726,54820,0,10,303,'C_PaymentTerm_Trl_UU',TO_DATE('2011-03-29 10:51:35','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_PaymentTerm_Trl_UU',TO_DATE('2011-03-29 10:51:35','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_PaymentTerm_Trl ADD C_PaymentTerm_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_PaymentTerm_Trl_UU_idx ON c_paymentterm_trl(C_PaymentTerm_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54821,0,'C_PaySchedule_UU',TO_DATE('2011-03-29 10:51:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_PaySchedule_UU','C_PaySchedule_UU',TO_DATE('2011-03-29 10:51:37','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60727,54821,0,10,548,'C_PaySchedule_UU',TO_DATE('2011-03-29 10:51:37','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_PaySchedule_UU',TO_DATE('2011-03-29 10:51:37','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_PaySchedule ADD C_PaySchedule_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_PaySchedule_UU_idx ON c_payschedule(C_PaySchedule_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54822,0,'C_PaySelection_UU',TO_DATE('2011-03-29 10:51:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_PaySelection_UU','C_PaySelection_UU',TO_DATE('2011-03-29 10:51:39','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60728,54822,0,10,426,'C_PaySelection_UU',TO_DATE('2011-03-29 10:51:39','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_PaySelection_UU',TO_DATE('2011-03-29 10:51:39','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_PaySelection ADD C_PaySelection_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_PaySelection_UU_idx ON c_payselection(C_PaySelection_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54823,0,'C_PaySelectionCheck_UU',TO_DATE('2011-03-29 10:51:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_PaySelectionCheck_UU','C_PaySelectionCheck_UU',TO_DATE('2011-03-29 10:51:40','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60729,54823,0,10,525,'C_PaySelectionCheck_UU',TO_DATE('2011-03-29 10:51:40','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_PaySelectionCheck_UU',TO_DATE('2011-03-29 10:51:40','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_PaySelectionCheck ADD C_PaySelectionCheck_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_PaySelectionCheck_UU_idx ON c_payselectioncheck(C_PaySelectionCheck_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54824,0,'C_PaySelectionLine_UU',TO_DATE('2011-03-29 10:51:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_PaySelectionLine_UU','C_PaySelectionLine_UU',TO_DATE('2011-03-29 10:51:41','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60730,54824,0,10,427,'C_PaySelectionLine_UU',TO_DATE('2011-03-29 10:51:41','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_PaySelectionLine_UU',TO_DATE('2011-03-29 10:51:41','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_PaySelectionLine ADD C_PaySelectionLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_PaySelectionLine_UU_idx ON c_payselectionline(C_PaySelectionLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54825,0,'C_Period_UU',TO_DATE('2011-03-29 10:51:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Period_UU','C_Period_UU',TO_DATE('2011-03-29 10:51:43','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60731,54825,0,10,145,'C_Period_UU',TO_DATE('2011-03-29 10:51:43','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Period_UU',TO_DATE('2011-03-29 10:51:43','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Period ADD C_Period_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Period_UU_idx ON c_period(C_Period_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54826,0,'C_PeriodControl_UU',TO_DATE('2011-03-29 10:51:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_PeriodControl_UU','C_PeriodControl_UU',TO_DATE('2011-03-29 10:51:45','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60732,54826,0,10,229,'C_PeriodControl_UU',TO_DATE('2011-03-29 10:51:45','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_PeriodControl_UU',TO_DATE('2011-03-29 10:51:45','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_PeriodControl ADD C_PeriodControl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_PeriodControl_UU_idx ON c_periodcontrol(C_PeriodControl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54827,0,'C_Phase_UU',TO_DATE('2011-03-29 10:51:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Phase_UU','C_Phase_UU',TO_DATE('2011-03-29 10:51:47','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60733,54827,0,10,577,'C_Phase_UU',TO_DATE('2011-03-29 10:51:47','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Phase_UU',TO_DATE('2011-03-29 10:51:47','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Phase ADD C_Phase_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Phase_UU_idx ON c_phase(C_Phase_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54828,0,'C_POS_UU',TO_DATE('2011-03-29 10:51:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_POS_UU','C_POS_UU',TO_DATE('2011-03-29 10:51:49','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60734,54828,0,10,748,'C_POS_UU',TO_DATE('2011-03-29 10:51:49','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_POS_UU',TO_DATE('2011-03-29 10:51:49','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_POS ADD C_POS_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_POS_UU_idx ON c_pos(C_POS_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54829,0,'C_POSKey_UU',TO_DATE('2011-03-29 10:51:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_POSKey_UU','C_POSKey_UU',TO_DATE('2011-03-29 10:51:50','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60735,54829,0,10,750,'C_POSKey_UU',TO_DATE('2011-03-29 10:51:50','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_POSKey_UU',TO_DATE('2011-03-29 10:51:50','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_POSKey ADD C_POSKey_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_POSKey_UU_idx ON c_poskey(C_POSKey_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54830,0,'C_POSKeyLayout_UU',TO_DATE('2011-03-29 10:51:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_POSKeyLayout_UU','C_POSKeyLayout_UU',TO_DATE('2011-03-29 10:51:52','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60736,54830,0,10,749,'C_POSKeyLayout_UU',TO_DATE('2011-03-29 10:51:52','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_POSKeyLayout_UU',TO_DATE('2011-03-29 10:51:52','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_POSKeyLayout ADD C_POSKeyLayout_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_POSKeyLayout_UU_idx ON c_poskeylayout(C_POSKeyLayout_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54831,0,'C_Project_UU',TO_DATE('2011-03-29 10:51:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Project_UU','C_Project_UU',TO_DATE('2011-03-29 10:51:55','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60737,54831,0,10,203,'C_Project_UU',TO_DATE('2011-03-29 10:51:55','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Project_UU',TO_DATE('2011-03-29 10:51:55','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Project ADD C_Project_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Project_UU_idx ON c_project(C_Project_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54832,0,'C_Project_Acct_UU',TO_DATE('2011-03-29 10:51:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Project_Acct_UU','C_Project_Acct_UU',TO_DATE('2011-03-29 10:51:57','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60738,54832,0,10,204,'C_Project_Acct_UU',TO_DATE('2011-03-29 10:51:57','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Project_Acct_UU',TO_DATE('2011-03-29 10:51:57','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Project_Acct ADD C_Project_Acct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Project_Acct_UU_idx ON c_project_acct(C_Project_Acct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54833,0,'C_ProjectIssue_UU',TO_DATE('2011-03-29 10:51:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_ProjectIssue_UU','C_ProjectIssue_UU',TO_DATE('2011-03-29 10:51:59','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60739,54833,0,10,623,'C_ProjectIssue_UU',TO_DATE('2011-03-29 10:51:59','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_ProjectIssue_UU',TO_DATE('2011-03-29 10:51:59','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_ProjectIssue ADD C_ProjectIssue_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_ProjectIssue_UU_idx ON c_projectissue(C_ProjectIssue_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54834,0,'C_ProjectIssueMA_UU',TO_DATE('2011-03-29 10:52:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_ProjectIssueMA_UU','C_ProjectIssueMA_UU',TO_DATE('2011-03-29 10:52:00','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60740,54834,0,10,761,'C_ProjectIssueMA_UU',TO_DATE('2011-03-29 10:52:00','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_ProjectIssueMA_UU',TO_DATE('2011-03-29 10:52:00','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_ProjectIssueMA ADD C_ProjectIssueMA_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_ProjectIssueMA_UU_idx ON c_projectissuema(C_ProjectIssueMA_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54835,0,'C_ProjectLine_UU',TO_DATE('2011-03-29 10:52:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_ProjectLine_UU','C_ProjectLine_UU',TO_DATE('2011-03-29 10:52:01','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60741,54835,0,10,434,'C_ProjectLine_UU',TO_DATE('2011-03-29 10:52:01','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_ProjectLine_UU',TO_DATE('2011-03-29 10:52:01','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_ProjectLine ADD C_ProjectLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_ProjectLine_UU_idx ON c_projectline(C_ProjectLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54836,0,'C_ProjectPhase_UU',TO_DATE('2011-03-29 10:52:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_ProjectPhase_UU','C_ProjectPhase_UU',TO_DATE('2011-03-29 10:52:03','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60742,54836,0,10,576,'C_ProjectPhase_UU',TO_DATE('2011-03-29 10:52:03','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_ProjectPhase_UU',TO_DATE('2011-03-29 10:52:03','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_ProjectPhase ADD C_ProjectPhase_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_ProjectPhase_UU_idx ON c_projectphase(C_ProjectPhase_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54837,0,'C_ProjectTask_UU',TO_DATE('2011-03-29 10:52:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_ProjectTask_UU','C_ProjectTask_UU',TO_DATE('2011-03-29 10:52:04','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60743,54837,0,10,584,'C_ProjectTask_UU',TO_DATE('2011-03-29 10:52:04','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_ProjectTask_UU',TO_DATE('2011-03-29 10:52:04','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_ProjectTask ADD C_ProjectTask_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_ProjectTask_UU_idx ON c_projecttask(C_ProjectTask_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54838,0,'C_ProjectType_UU',TO_DATE('2011-03-29 10:52:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_ProjectType_UU','C_ProjectType_UU',TO_DATE('2011-03-29 10:52:05','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60744,54838,0,10,575,'C_ProjectType_UU',TO_DATE('2011-03-29 10:52:05','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_ProjectType_UU',TO_DATE('2011-03-29 10:52:05','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_ProjectType ADD C_ProjectType_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_ProjectType_UU_idx ON c_projecttype(C_ProjectType_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54839,0,'C_Recurring_UU',TO_DATE('2011-03-29 10:52:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Recurring_UU','C_Recurring_UU',TO_DATE('2011-03-29 10:52:08','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60745,54839,0,10,574,'C_Recurring_UU',TO_DATE('2011-03-29 10:52:08','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Recurring_UU',TO_DATE('2011-03-29 10:52:08','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Recurring ADD C_Recurring_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Recurring_UU_idx ON c_recurring(C_Recurring_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54840,0,'C_Recurring_Run_UU',TO_DATE('2011-03-29 10:52:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Recurring_Run_UU','C_Recurring_Run_UU',TO_DATE('2011-03-29 10:52:09','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60746,54840,0,10,573,'C_Recurring_Run_UU',TO_DATE('2011-03-29 10:52:09','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Recurring_Run_UU',TO_DATE('2011-03-29 10:52:09','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Recurring_Run ADD C_Recurring_Run_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Recurring_Run_UU_idx ON c_recurring_run(C_Recurring_Run_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54841,0,'C_Region_UU',TO_DATE('2011-03-29 10:52:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Region_UU','C_Region_UU',TO_DATE('2011-03-29 10:52:11','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60747,54841,0,10,164,'C_Region_UU',TO_DATE('2011-03-29 10:52:11','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Region_UU',TO_DATE('2011-03-29 10:52:11','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Region ADD C_Region_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Region_UU_idx ON c_region(C_Region_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54842,0,'C_Remuneration_UU',TO_DATE('2011-03-29 10:52:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Remuneration_UU','C_Remuneration_UU',TO_DATE('2011-03-29 10:52:12','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60748,54842,0,10,792,'C_Remuneration_UU',TO_DATE('2011-03-29 10:52:12','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Remuneration_UU',TO_DATE('2011-03-29 10:52:12','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Remuneration ADD C_Remuneration_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Remuneration_UU_idx ON c_remuneration(C_Remuneration_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54843,0,'C_RevenueRecognition_UU',TO_DATE('2011-03-29 10:52:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_RevenueRecognition_UU','C_RevenueRecognition_UU',TO_DATE('2011-03-29 10:52:13','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60749,54843,0,10,336,'C_RevenueRecognition_UU',TO_DATE('2011-03-29 10:52:13','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_RevenueRecognition_UU',TO_DATE('2011-03-29 10:52:13','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_RevenueRecognition ADD C_RevenueRecognition_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_RevenueRecognition_UU_idx ON c_revenuerecognition(C_RevenueRecognition_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54844,0,'C_RevenueRecognition_Plan_UU',TO_DATE('2011-03-29 10:52:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_RevenueRecognition_Plan_UU','C_RevenueRecognition_Plan_UU',TO_DATE('2011-03-29 10:52:15','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60750,54844,0,10,443,'C_RevenueRecognition_Plan_UU',TO_DATE('2011-03-29 10:52:15','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_RevenueRecognition_Plan_UU',TO_DATE('2011-03-29 10:52:15','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_RevenueRecognition_Plan ADD C_RevenueRecognition_Plan_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_RevenueRecognition_Pl_UU_idx ON c_revenuerecognition_plan(C_RevenueRecognition_Plan_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54845,0,'C_RevenueRecognition_Run_UU',TO_DATE('2011-03-29 10:52:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_RevenueRecognition_Run_UU','C_RevenueRecognition_Run_UU',TO_DATE('2011-03-29 10:52:17','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60751,54845,0,10,444,'C_RevenueRecognition_Run_UU',TO_DATE('2011-03-29 10:52:17','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_RevenueRecognition_Run_UU',TO_DATE('2011-03-29 10:52:17','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_RevenueRecognition_Run ADD C_RevenueRecognition_Run_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_RevenueRecognition_Ru_UU_idx ON c_revenuerecognition_run(C_RevenueRecognition_Run_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54846,0,'C_RfQ_UU',TO_DATE('2011-03-29 10:52:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_RfQ_UU','C_RfQ_UU',TO_DATE('2011-03-29 10:52:18','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60752,54846,0,10,677,'C_RfQ_UU',TO_DATE('2011-03-29 10:52:18','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_RfQ_UU',TO_DATE('2011-03-29 10:52:18','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_RfQ ADD C_RfQ_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_RfQ_UU_idx ON c_rfq(C_RfQ_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54847,0,'C_RfQLine_UU',TO_DATE('2011-03-29 10:52:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_RfQLine_UU','C_RfQLine_UU',TO_DATE('2011-03-29 10:52:20','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60753,54847,0,10,676,'C_RfQLine_UU',TO_DATE('2011-03-29 10:52:20','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_RfQLine_UU',TO_DATE('2011-03-29 10:52:20','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_RfQLine ADD C_RfQLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_RfQLine_UU_idx ON c_rfqline(C_RfQLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54848,0,'C_RfQLineQty_UU',TO_DATE('2011-03-29 10:52:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_RfQLineQty_UU','C_RfQLineQty_UU',TO_DATE('2011-03-29 10:52:21','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60754,54848,0,10,675,'C_RfQLineQty_UU',TO_DATE('2011-03-29 10:52:21','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_RfQLineQty_UU',TO_DATE('2011-03-29 10:52:21','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_RfQLineQty ADD C_RfQLineQty_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_RfQLineQty_UU_idx ON c_rfqlineqty(C_RfQLineQty_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54849,0,'C_RfQResponse_UU',TO_DATE('2011-03-29 10:52:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_RfQResponse_UU','C_RfQResponse_UU',TO_DATE('2011-03-29 10:52:22','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60755,54849,0,10,674,'C_RfQResponse_UU',TO_DATE('2011-03-29 10:52:22','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_RfQResponse_UU',TO_DATE('2011-03-29 10:52:22','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_RfQResponse ADD C_RfQResponse_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_RfQResponse_UU_idx ON c_rfqresponse(C_RfQResponse_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54850,0,'C_RfQResponseLine_UU',TO_DATE('2011-03-29 10:52:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_RfQResponseLine_UU','C_RfQResponseLine_UU',TO_DATE('2011-03-29 10:52:24','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60756,54850,0,10,673,'C_RfQResponseLine_UU',TO_DATE('2011-03-29 10:52:24','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_RfQResponseLine_UU',TO_DATE('2011-03-29 10:52:24','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_RfQResponseLine ADD C_RfQResponseLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_RfQResponseLine_UU_idx ON c_rfqresponseline(C_RfQResponseLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54851,0,'C_RfQResponseLineQty_UU',TO_DATE('2011-03-29 10:52:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_RfQResponseLineQty_UU','C_RfQResponseLineQty_UU',TO_DATE('2011-03-29 10:52:27','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60757,54851,0,10,672,'C_RfQResponseLineQty_UU',TO_DATE('2011-03-29 10:52:27','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_RfQResponseLineQty_UU',TO_DATE('2011-03-29 10:52:27','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_RfQResponseLineQty ADD C_RfQResponseLineQty_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_RfQResponseLineQty_UU_idx ON c_rfqresponselineqty(C_RfQResponseLineQty_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54852,0,'C_RfQ_Topic_UU',TO_DATE('2011-03-29 10:52:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_RfQ_Topic_UU','C_RfQ_Topic_UU',TO_DATE('2011-03-29 10:52:29','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60758,54852,0,10,671,'C_RfQ_Topic_UU',TO_DATE('2011-03-29 10:52:29','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_RfQ_Topic_UU',TO_DATE('2011-03-29 10:52:29','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_RfQ_Topic ADD C_RfQ_Topic_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_RfQ_Topic_UU_idx ON c_rfq_topic(C_RfQ_Topic_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54853,0,'C_RfQ_TopicSubscriber_UU',TO_DATE('2011-03-29 10:52:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_RfQ_TopicSubscriber_UU','C_RfQ_TopicSubscriber_UU',TO_DATE('2011-03-29 10:52:30','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60759,54853,0,10,670,'C_RfQ_TopicSubscriber_UU',TO_DATE('2011-03-29 10:52:30','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_RfQ_TopicSubscriber_UU',TO_DATE('2011-03-29 10:52:30','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_RfQ_TopicSubscriber ADD C_RfQ_TopicSubscriber_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_RfQ_TopicSubscriber_UU_idx ON c_rfq_topicsubscriber(C_RfQ_TopicSubscriber_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54854,0,'C_RfQ_TopicSubscriberOnly_UU',TO_DATE('2011-03-29 10:52:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_RfQ_TopicSubscriberOnly_UU','C_RfQ_TopicSubscriberOnly_UU',TO_DATE('2011-03-29 10:52:32','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60760,54854,0,10,747,'C_RfQ_TopicSubscriberOnly_UU',TO_DATE('2011-03-29 10:52:32','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_RfQ_TopicSubscriberOnly_UU',TO_DATE('2011-03-29 10:52:32','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_RfQ_TopicSubscriberOnly ADD C_RfQ_TopicSubscriberOnly_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_RfQ_TopicSubscriberOn_UU_idx ON c_rfq_topicsubscriberonly(C_RfQ_TopicSubscriberOnly_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54855,0,'C_SalesRegion_UU',TO_DATE('2011-03-29 10:52:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_SalesRegion_UU','C_SalesRegion_UU',TO_DATE('2011-03-29 10:52:33','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60761,54855,0,10,230,'C_SalesRegion_UU',TO_DATE('2011-03-29 10:52:33','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_SalesRegion_UU',TO_DATE('2011-03-29 10:52:33','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_SalesRegion ADD C_SalesRegion_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_SalesRegion_UU_idx ON c_salesregion(C_SalesRegion_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54856,0,'C_ServiceLevel_UU',TO_DATE('2011-03-29 10:52:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_ServiceLevel_UU','C_ServiceLevel_UU',TO_DATE('2011-03-29 10:52:34','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60762,54856,0,10,337,'C_ServiceLevel_UU',TO_DATE('2011-03-29 10:52:34','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_ServiceLevel_UU',TO_DATE('2011-03-29 10:52:34','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_ServiceLevel ADD C_ServiceLevel_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_ServiceLevel_UU_idx ON c_servicelevel(C_ServiceLevel_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54857,0,'C_ServiceLevelLine_UU',TO_DATE('2011-03-29 10:52:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_ServiceLevelLine_UU','C_ServiceLevelLine_UU',TO_DATE('2011-03-29 10:52:36','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60763,54857,0,10,338,'C_ServiceLevelLine_UU',TO_DATE('2011-03-29 10:52:36','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_ServiceLevelLine_UU',TO_DATE('2011-03-29 10:52:36','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_ServiceLevelLine ADD C_ServiceLevelLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_ServiceLevelLine_UU_idx ON c_servicelevelline(C_ServiceLevelLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54858,0,'C_SubAcct_UU',TO_DATE('2011-03-29 10:52:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_SubAcct_UU','C_SubAcct_UU',TO_DATE('2011-03-29 10:52:37','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60764,54858,0,10,825,'C_SubAcct_UU',TO_DATE('2011-03-29 10:52:37','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_SubAcct_UU',TO_DATE('2011-03-29 10:52:37','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_SubAcct ADD C_SubAcct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_SubAcct_UU_idx ON c_subacct(C_SubAcct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54859,0,'C_Subscription_UU',TO_DATE('2011-03-29 10:52:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Subscription_UU','C_Subscription_UU',TO_DATE('2011-03-29 10:52:39','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60765,54859,0,10,669,'C_Subscription_UU',TO_DATE('2011-03-29 10:52:39','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Subscription_UU',TO_DATE('2011-03-29 10:52:39','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Subscription ADD C_Subscription_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Subscription_UU_idx ON c_subscription(C_Subscription_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54860,0,'C_Subscription_Delivery_UU',TO_DATE('2011-03-29 10:52:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Subscription_Delivery_UU','C_Subscription_Delivery_UU',TO_DATE('2011-03-29 10:52:40','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60766,54860,0,10,667,'C_Subscription_Delivery_UU',TO_DATE('2011-03-29 10:52:40','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Subscription_Delivery_UU',TO_DATE('2011-03-29 10:52:40','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Subscription_Delivery ADD C_Subscription_Delivery_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Subscription_Delivery_UU_idx ON c_subscription_delivery(C_Subscription_Delivery_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54861,0,'C_SubscriptionType_UU',TO_DATE('2011-03-29 10:52:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_SubscriptionType_UU','C_SubscriptionType_UU',TO_DATE('2011-03-29 10:52:41','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60767,54861,0,10,668,'C_SubscriptionType_UU',TO_DATE('2011-03-29 10:52:41','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_SubscriptionType_UU',TO_DATE('2011-03-29 10:52:41','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_SubscriptionType ADD C_SubscriptionType_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_SubscriptionType_UU_idx ON c_subscriptiontype(C_SubscriptionType_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54862,0,'C_Task_UU',TO_DATE('2011-03-29 10:52:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Task_UU','C_Task_UU',TO_DATE('2011-03-29 10:52:43','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60768,54862,0,10,583,'C_Task_UU',TO_DATE('2011-03-29 10:52:43','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Task_UU',TO_DATE('2011-03-29 10:52:43','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Task ADD C_Task_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Task_UU_idx ON c_task(C_Task_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54863,0,'C_Tax_UU',TO_DATE('2011-03-29 10:52:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Tax_UU','C_Tax_UU',TO_DATE('2011-03-29 10:52:44','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60769,54863,0,10,261,'C_Tax_UU',TO_DATE('2011-03-29 10:52:44','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Tax_UU',TO_DATE('2011-03-29 10:52:44','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Tax ADD C_Tax_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Tax_UU_idx ON c_tax(C_Tax_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54864,0,'C_Tax_Acct_UU',TO_DATE('2011-03-29 10:52:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Tax_Acct_UU','C_Tax_Acct_UU',TO_DATE('2011-03-29 10:52:46','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60770,54864,0,10,399,'C_Tax_Acct_UU',TO_DATE('2011-03-29 10:52:46','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Tax_Acct_UU',TO_DATE('2011-03-29 10:52:46','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Tax_Acct ADD C_Tax_Acct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Tax_Acct_UU_idx ON c_tax_acct(C_Tax_Acct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54865,0,'C_TaxBase_UU',TO_DATE('2011-03-29 10:52:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_TaxBase_UU','C_TaxBase_UU',TO_DATE('2011-03-29 10:52:47','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60771,54865,0,10,53069,'C_TaxBase_UU',TO_DATE('2011-03-29 10:52:47','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_TaxBase_UU',TO_DATE('2011-03-29 10:52:47','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_TaxBase ADD C_TaxBase_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_TaxBase_UU_idx ON c_taxbase(C_TaxBase_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54866,0,'C_TaxCategory_UU',TO_DATE('2011-03-29 10:52:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_TaxCategory_UU','C_TaxCategory_UU',TO_DATE('2011-03-29 10:52:49','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60772,54866,0,10,252,'C_TaxCategory_UU',TO_DATE('2011-03-29 10:52:49','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_TaxCategory_UU',TO_DATE('2011-03-29 10:52:49','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_TaxCategory ADD C_TaxCategory_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_TaxCategory_UU_idx ON c_taxcategory(C_TaxCategory_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54867,0,'C_TaxCategory_Trl_UU',TO_DATE('2011-03-29 10:52:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_TaxCategory_Trl_UU','C_TaxCategory_Trl_UU',TO_DATE('2011-03-29 10:52:50','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60773,54867,0,10,348,'C_TaxCategory_Trl_UU',TO_DATE('2011-03-29 10:52:50','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_TaxCategory_Trl_UU',TO_DATE('2011-03-29 10:52:50','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_TaxCategory_Trl ADD C_TaxCategory_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_TaxCategory_Trl_UU_idx ON c_taxcategory_trl(C_TaxCategory_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54868,0,'C_TaxDeclaration_UU',TO_DATE('2011-03-29 10:52:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_TaxDeclaration_UU','C_TaxDeclaration_UU',TO_DATE('2011-03-29 10:52:52','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60774,54868,0,10,818,'C_TaxDeclaration_UU',TO_DATE('2011-03-29 10:52:52','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_TaxDeclaration_UU',TO_DATE('2011-03-29 10:52:52','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_TaxDeclaration ADD C_TaxDeclaration_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_TaxDeclaration_UU_idx ON c_taxdeclaration(C_TaxDeclaration_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54869,0,'C_TaxDeclarationAcct_UU',TO_DATE('2011-03-29 10:52:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_TaxDeclarationAcct_UU','C_TaxDeclarationAcct_UU',TO_DATE('2011-03-29 10:52:53','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60775,54869,0,10,820,'C_TaxDeclarationAcct_UU',TO_DATE('2011-03-29 10:52:53','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_TaxDeclarationAcct_UU',TO_DATE('2011-03-29 10:52:53','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_TaxDeclarationAcct ADD C_TaxDeclarationAcct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_TaxDeclarationAcct_UU_idx ON c_taxdeclarationacct(C_TaxDeclarationAcct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54870,0,'C_TaxDeclarationLine_UU',TO_DATE('2011-03-29 10:52:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_TaxDeclarationLine_UU','C_TaxDeclarationLine_UU',TO_DATE('2011-03-29 10:52:55','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60776,54870,0,10,819,'C_TaxDeclarationLine_UU',TO_DATE('2011-03-29 10:52:55','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_TaxDeclarationLine_UU',TO_DATE('2011-03-29 10:52:55','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_TaxDeclarationLine ADD C_TaxDeclarationLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_TaxDeclarationLine_UU_idx ON c_taxdeclarationline(C_TaxDeclarationLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54871,0,'C_TaxDefinition_UU',TO_DATE('2011-03-29 10:52:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_TaxDefinition_UU','C_TaxDefinition_UU',TO_DATE('2011-03-29 10:52:57','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60777,54871,0,10,53067,'C_TaxDefinition_UU',TO_DATE('2011-03-29 10:52:57','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_TaxDefinition_UU',TO_DATE('2011-03-29 10:52:57','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_TaxDefinition ADD C_TaxDefinition_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_TaxDefinition_UU_idx ON c_taxdefinition(C_TaxDefinition_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54872,0,'C_TaxGroup_UU',TO_DATE('2011-03-29 10:53:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_TaxGroup_UU','C_TaxGroup_UU',TO_DATE('2011-03-29 10:53:00','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60778,54872,0,10,53066,'C_TaxGroup_UU',TO_DATE('2011-03-29 10:53:00','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_TaxGroup_UU',TO_DATE('2011-03-29 10:53:00','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_TaxGroup ADD C_TaxGroup_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_TaxGroup_UU_idx ON c_taxgroup(C_TaxGroup_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54873,0,'C_TaxPostal_UU',TO_DATE('2011-03-29 10:53:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_TaxPostal_UU','C_TaxPostal_UU',TO_DATE('2011-03-29 10:53:01','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60779,54873,0,10,701,'C_TaxPostal_UU',TO_DATE('2011-03-29 10:53:01','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_TaxPostal_UU',TO_DATE('2011-03-29 10:53:01','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_TaxPostal ADD C_TaxPostal_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_TaxPostal_UU_idx ON c_taxpostal(C_TaxPostal_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54874,0,'C_Tax_Trl_UU',TO_DATE('2011-03-29 10:53:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Tax_Trl_UU','C_Tax_Trl_UU',TO_DATE('2011-03-29 10:53:03','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60780,54874,0,10,546,'C_Tax_Trl_UU',TO_DATE('2011-03-29 10:53:03','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Tax_Trl_UU',TO_DATE('2011-03-29 10:53:03','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Tax_Trl ADD C_Tax_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Tax_Trl_UU_idx ON c_tax_trl(C_Tax_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54875,0,'C_TaxType_UU',TO_DATE('2011-03-29 10:53:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_TaxType_UU','C_TaxType_UU',TO_DATE('2011-03-29 10:53:05','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60781,54875,0,10,53068,'C_TaxType_UU',TO_DATE('2011-03-29 10:53:05','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_TaxType_UU',TO_DATE('2011-03-29 10:53:05','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_TaxType ADD C_TaxType_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_TaxType_UU_idx ON c_taxtype(C_TaxType_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54876,0,'C_UOM_UU',TO_DATE('2011-03-29 10:53:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_UOM_UU','C_UOM_UU',TO_DATE('2011-03-29 10:53:06','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60782,54876,0,10,146,'C_UOM_UU',TO_DATE('2011-03-29 10:53:06','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_UOM_UU',TO_DATE('2011-03-29 10:53:06','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_UOM ADD C_UOM_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_UOM_UU_idx ON c_uom(C_UOM_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54877,0,'C_UOM_Conversion_UU',TO_DATE('2011-03-29 10:53:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_UOM_Conversion_UU','C_UOM_Conversion_UU',TO_DATE('2011-03-29 10:53:07','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60783,54877,0,10,175,'C_UOM_Conversion_UU',TO_DATE('2011-03-29 10:53:07','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_UOM_Conversion_UU',TO_DATE('2011-03-29 10:53:07','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_UOM_Conversion ADD C_UOM_Conversion_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_UOM_Conversion_UU_idx ON c_uom_conversion(C_UOM_Conversion_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54878,0,'C_UOM_Trl_UU',TO_DATE('2011-03-29 10:53:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_UOM_Trl_UU','C_UOM_Trl_UU',TO_DATE('2011-03-29 10:53:09','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60784,54878,0,10,339,'C_UOM_Trl_UU',TO_DATE('2011-03-29 10:53:09','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_UOM_Trl_UU',TO_DATE('2011-03-29 10:53:09','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_UOM_Trl ADD C_UOM_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_UOM_Trl_UU_idx ON c_uom_trl(C_UOM_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54879,0,'C_UserRemuneration_UU',TO_DATE('2011-03-29 10:53:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_UserRemuneration_UU','C_UserRemuneration_UU',TO_DATE('2011-03-29 10:53:10','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60785,54879,0,10,794,'C_UserRemuneration_UU',TO_DATE('2011-03-29 10:53:10','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_UserRemuneration_UU',TO_DATE('2011-03-29 10:53:10','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_UserRemuneration ADD C_UserRemuneration_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_UserRemuneration_UU_idx ON c_userremuneration(C_UserRemuneration_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54880,0,'C_ValidCombination_UU',TO_DATE('2011-03-29 10:53:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_ValidCombination_UU','C_ValidCombination_UU',TO_DATE('2011-03-29 10:53:12','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60786,54880,0,10,176,'C_ValidCombination_UU',TO_DATE('2011-03-29 10:53:12','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_ValidCombination_UU',TO_DATE('2011-03-29 10:53:12','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_ValidCombination ADD C_ValidCombination_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_ValidCombination_UU_idx ON c_validcombination(C_ValidCombination_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54881,0,'C_Withholding_UU',TO_DATE('2011-03-29 10:53:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Withholding_UU','C_Withholding_UU',TO_DATE('2011-03-29 10:53:13','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60787,54881,0,10,304,'C_Withholding_UU',TO_DATE('2011-03-29 10:53:13','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Withholding_UU',TO_DATE('2011-03-29 10:53:13','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Withholding ADD C_Withholding_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Withholding_UU_idx ON c_withholding(C_Withholding_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54882,0,'C_Withholding_Acct_UU',TO_DATE('2011-03-29 10:53:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Withholding_Acct_UU','C_Withholding_Acct_UU',TO_DATE('2011-03-29 10:53:14','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60788,54882,0,10,400,'C_Withholding_Acct_UU',TO_DATE('2011-03-29 10:53:14','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Withholding_Acct_UU',TO_DATE('2011-03-29 10:53:14','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Withholding_Acct ADD C_Withholding_Acct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Withholding_Acct_UU_idx ON c_withholding_acct(C_Withholding_Acct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54883,0,'C_Year_UU',TO_DATE('2011-03-29 10:53:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Year_UU','C_Year_UU',TO_DATE('2011-03-29 10:53:16','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60789,54883,0,10,177,'C_Year_UU',TO_DATE('2011-03-29 10:53:16','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','C_Year_UU',TO_DATE('2011-03-29 10:53:16','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE C_Year ADD C_Year_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX C_Year_UU_idx ON c_year(C_Year_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54884,0,'DD_NetworkDistribution_UU',TO_DATE('2011-03-29 10:53:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','DD_NetworkDistribution_UU','DD_NetworkDistribution_UU',TO_DATE('2011-03-29 10:53:18','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60790,54884,0,10,53060,'DD_NetworkDistribution_UU',TO_DATE('2011-03-29 10:53:18','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','DD_NetworkDistribution_UU',TO_DATE('2011-03-29 10:53:18','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE DD_NetworkDistribution ADD DD_NetworkDistribution_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX DD_NetworkDistribution_UU_idx ON dd_networkdistribution(DD_NetworkDistribution_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54885,0,'DD_NetworkDistributionLine_UU',TO_DATE('2011-03-29 10:53:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','DD_NetworkDistributionLine_UU','DD_NetworkDistributionLine_UU',TO_DATE('2011-03-29 10:53:20','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60791,54885,0,10,53061,'DD_NetworkDistributionLine_UU',TO_DATE('2011-03-29 10:53:20','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','DD_NetworkDistributionLine_UU',TO_DATE('2011-03-29 10:53:20','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE DD_NetworkDistributionLine ADD DD_NetworkDistributionLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX DD_NetworkDistributionL_UU_idx ON dd_networkdistributionline(DD_NetworkDistributionLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54886,0,'DD_Order_UU',TO_DATE('2011-03-29 10:53:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','DD_Order_UU','DD_Order_UU',TO_DATE('2011-03-29 10:53:23','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60792,54886,0,10,53037,'DD_Order_UU',TO_DATE('2011-03-29 10:53:23','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','DD_Order_UU',TO_DATE('2011-03-29 10:53:23','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE DD_Order ADD DD_Order_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX DD_Order_UU_idx ON dd_order(DD_Order_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54887,0,'DD_OrderLine_UU',TO_DATE('2011-03-29 10:53:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','DD_OrderLine_UU','DD_OrderLine_UU',TO_DATE('2011-03-29 10:53:25','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60793,54887,0,10,53038,'DD_OrderLine_UU',TO_DATE('2011-03-29 10:53:25','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','DD_OrderLine_UU',TO_DATE('2011-03-29 10:53:25','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE DD_OrderLine ADD DD_OrderLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX DD_OrderLine_UU_idx ON dd_orderline(DD_OrderLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54888,0,'EXP_Format_UU',TO_DATE('2011-03-29 10:53:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','EXP_Format_UU','EXP_Format_UU',TO_DATE('2011-03-29 10:53:26','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60794,54888,0,10,53072,'EXP_Format_UU',TO_DATE('2011-03-29 10:53:26','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','EXP_Format_UU',TO_DATE('2011-03-29 10:53:26','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE EXP_Format ADD EXP_Format_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX EXP_Format_UU_idx ON exp_format(EXP_Format_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54889,0,'EXP_FormatLine_UU',TO_DATE('2011-03-29 10:53:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','EXP_FormatLine_UU','EXP_FormatLine_UU',TO_DATE('2011-03-29 10:53:28','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60795,54889,0,10,53073,'EXP_FormatLine_UU',TO_DATE('2011-03-29 10:53:28','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','EXP_FormatLine_UU',TO_DATE('2011-03-29 10:53:28','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE EXP_FormatLine ADD EXP_FormatLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX EXP_FormatLine_UU_idx ON exp_formatline(EXP_FormatLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54890,0,'EXP_Processor_UU',TO_DATE('2011-03-29 10:53:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','EXP_Processor_UU','EXP_Processor_UU',TO_DATE('2011-03-29 10:53:30','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60796,54890,0,10,53074,'EXP_Processor_UU',TO_DATE('2011-03-29 10:53:30','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','EXP_Processor_UU',TO_DATE('2011-03-29 10:53:30','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE EXP_Processor ADD EXP_Processor_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX EXP_Processor_UU_idx ON exp_processor(EXP_Processor_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54891,0,'EXP_ProcessorParameter_UU',TO_DATE('2011-03-29 10:53:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','EXP_ProcessorParameter_UU','EXP_ProcessorParameter_UU',TO_DATE('2011-03-29 10:53:31','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60797,54891,0,10,53075,'EXP_ProcessorParameter_UU',TO_DATE('2011-03-29 10:53:31','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','EXP_ProcessorParameter_UU',TO_DATE('2011-03-29 10:53:31','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE EXP_ProcessorParameter ADD EXP_ProcessorParameter_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX EXP_ProcessorParameter_UU_idx ON exp_processorparameter(EXP_ProcessorParameter_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54892,0,'EXP_Processor_Type_UU',TO_DATE('2011-03-29 10:53:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','EXP_Processor_Type_UU','EXP_Processor_Type_UU',TO_DATE('2011-03-29 10:53:33','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60798,54892,0,10,53076,'EXP_Processor_Type_UU',TO_DATE('2011-03-29 10:53:33','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','EXP_Processor_Type_UU',TO_DATE('2011-03-29 10:53:33','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE EXP_Processor_Type ADD EXP_Processor_Type_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX EXP_Processor_Type_UU_idx ON exp_processor_type(EXP_Processor_Type_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54893,0,'Fact_Acct_UU',TO_DATE('2011-03-29 10:53:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Fact_Acct_UU','Fact_Acct_UU',TO_DATE('2011-03-29 10:53:34','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60799,54893,0,10,270,'Fact_Acct_UU',TO_DATE('2011-03-29 10:53:34','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','Fact_Acct_UU',TO_DATE('2011-03-29 10:53:34','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE Fact_Acct ADD Fact_Acct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX Fact_Acct_UU_idx ON fact_acct(Fact_Acct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54894,0,'Fact_Acct_Summary_UU',TO_DATE('2011-03-29 10:53:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Fact_Acct_Summary_UU','Fact_Acct_Summary_UU',TO_DATE('2011-03-29 10:53:36','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60800,54894,0,10,53203,'Fact_Acct_Summary_UU',TO_DATE('2011-03-29 10:53:36','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','Fact_Acct_Summary_UU',TO_DATE('2011-03-29 10:53:36','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE Fact_Acct_Summary ADD Fact_Acct_Summary_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX Fact_Acct_Summary_UU_idx ON fact_acct_summary(Fact_Acct_Summary_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54895,0,'GL_Budget_UU',TO_DATE('2011-03-29 10:53:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','GL_Budget_UU','GL_Budget_UU',TO_DATE('2011-03-29 10:53:41','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60801,54895,0,10,271,'GL_Budget_UU',TO_DATE('2011-03-29 10:53:41','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','GL_Budget_UU',TO_DATE('2011-03-29 10:53:41','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE GL_Budget ADD GL_Budget_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX GL_Budget_UU_idx ON gl_budget(GL_Budget_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54896,0,'GL_BudgetControl_UU',TO_DATE('2011-03-29 10:53:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','GL_BudgetControl_UU','GL_BudgetControl_UU',TO_DATE('2011-03-29 10:53:45','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60802,54896,0,10,822,'GL_BudgetControl_UU',TO_DATE('2011-03-29 10:53:45','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','GL_BudgetControl_UU',TO_DATE('2011-03-29 10:53:45','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE GL_BudgetControl ADD GL_BudgetControl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX GL_BudgetControl_UU_idx ON gl_budgetcontrol(GL_BudgetControl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54897,0,'GL_Category_UU',TO_DATE('2011-03-29 10:53:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','GL_Category_UU','GL_Category_UU',TO_DATE('2011-03-29 10:53:46','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60803,54897,0,10,218,'GL_Category_UU',TO_DATE('2011-03-29 10:53:46','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','GL_Category_UU',TO_DATE('2011-03-29 10:53:46','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE GL_Category ADD GL_Category_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX GL_Category_UU_idx ON gl_category(GL_Category_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54898,0,'GL_Distribution_UU',TO_DATE('2011-03-29 10:53:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','GL_Distribution_UU','GL_Distribution_UU',TO_DATE('2011-03-29 10:53:48','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60804,54898,0,10,708,'GL_Distribution_UU',TO_DATE('2011-03-29 10:53:48','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','GL_Distribution_UU',TO_DATE('2011-03-29 10:53:48','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE GL_Distribution ADD GL_Distribution_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX GL_Distribution_UU_idx ON gl_distribution(GL_Distribution_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54899,0,'GL_DistributionLine_UU',TO_DATE('2011-03-29 10:53:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','GL_DistributionLine_UU','GL_DistributionLine_UU',TO_DATE('2011-03-29 10:53:49','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60805,54899,0,10,707,'GL_DistributionLine_UU',TO_DATE('2011-03-29 10:53:49','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','GL_DistributionLine_UU',TO_DATE('2011-03-29 10:53:49','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE GL_DistributionLine ADD GL_DistributionLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX GL_DistributionLine_UU_idx ON gl_distributionline(GL_DistributionLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54900,0,'GL_Fund_UU',TO_DATE('2011-03-29 10:53:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','GL_Fund_UU','GL_Fund_UU',TO_DATE('2011-03-29 10:53:51','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60806,54900,0,10,823,'GL_Fund_UU',TO_DATE('2011-03-29 10:53:51','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','GL_Fund_UU',TO_DATE('2011-03-29 10:53:51','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE GL_Fund ADD GL_Fund_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX GL_Fund_UU_idx ON gl_fund(GL_Fund_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54901,0,'GL_FundRestriction_UU',TO_DATE('2011-03-29 10:53:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','GL_FundRestriction_UU','GL_FundRestriction_UU',TO_DATE('2011-03-29 10:53:52','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60807,54901,0,10,824,'GL_FundRestriction_UU',TO_DATE('2011-03-29 10:53:52','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','GL_FundRestriction_UU',TO_DATE('2011-03-29 10:53:52','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE GL_FundRestriction ADD GL_FundRestriction_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX GL_FundRestriction_UU_idx ON gl_fundrestriction(GL_FundRestriction_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54902,0,'GL_Journal_UU',TO_DATE('2011-03-29 10:53:54','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','GL_Journal_UU','GL_Journal_UU',TO_DATE('2011-03-29 10:53:54','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60808,54902,0,10,224,'GL_Journal_UU',TO_DATE('2011-03-29 10:53:54','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','GL_Journal_UU',TO_DATE('2011-03-29 10:53:54','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE GL_Journal ADD GL_Journal_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX GL_Journal_UU_idx ON gl_journal(GL_Journal_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54903,0,'GL_JournalBatch_UU',TO_DATE('2011-03-29 10:53:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','GL_JournalBatch_UU','GL_JournalBatch_UU',TO_DATE('2011-03-29 10:53:55','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60809,54903,0,10,225,'GL_JournalBatch_UU',TO_DATE('2011-03-29 10:53:55','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','GL_JournalBatch_UU',TO_DATE('2011-03-29 10:53:55','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE GL_JournalBatch ADD GL_JournalBatch_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX GL_JournalBatch_UU_idx ON gl_journalbatch(GL_JournalBatch_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54904,0,'GL_JournalLine_UU',TO_DATE('2011-03-29 10:53:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','GL_JournalLine_UU','GL_JournalLine_UU',TO_DATE('2011-03-29 10:53:57','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60810,54904,0,10,226,'GL_JournalLine_UU',TO_DATE('2011-03-29 10:53:57','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','GL_JournalLine_UU',TO_DATE('2011-03-29 10:53:57','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE GL_JournalLine ADD GL_JournalLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX GL_JournalLine_UU_idx ON gl_journalline(GL_JournalLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54905,0,'HR_Attribute_UU',TO_DATE('2011-03-29 10:53:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','HR_Attribute_UU','HR_Attribute_UU',TO_DATE('2011-03-29 10:53:58','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60811,54905,0,10,53087,'HR_Attribute_UU',TO_DATE('2011-03-29 10:53:58','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','HR_Attribute_UU',TO_DATE('2011-03-29 10:53:58','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE HR_Attribute ADD HR_Attribute_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX HR_Attribute_UU_idx ON hr_attribute(HR_Attribute_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54906,0,'HR_Concept_UU',TO_DATE('2011-03-29 10:54:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','HR_Concept_UU','HR_Concept_UU',TO_DATE('2011-03-29 10:54:00','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60812,54906,0,10,53090,'HR_Concept_UU',TO_DATE('2011-03-29 10:54:00','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','HR_Concept_UU',TO_DATE('2011-03-29 10:54:00','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE HR_Concept ADD HR_Concept_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX HR_Concept_UU_idx ON hr_concept(HR_Concept_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54907,0,'HR_Concept_Acct_UU',TO_DATE('2011-03-29 10:54:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','HR_Concept_Acct_UU','HR_Concept_Acct_UU',TO_DATE('2011-03-29 10:54:02','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60813,54907,0,10,53091,'HR_Concept_Acct_UU',TO_DATE('2011-03-29 10:54:02','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','HR_Concept_Acct_UU',TO_DATE('2011-03-29 10:54:02','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE HR_Concept_Acct ADD HR_Concept_Acct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX HR_Concept_Acct_UU_idx ON hr_concept_acct(HR_Concept_Acct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54908,0,'HR_Concept_Category_UU',TO_DATE('2011-03-29 10:54:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','HR_Concept_Category_UU','HR_Concept_Category_UU',TO_DATE('2011-03-29 10:54:03','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60814,54908,0,10,53097,'HR_Concept_Category_UU',TO_DATE('2011-03-29 10:54:03','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','HR_Concept_Category_UU',TO_DATE('2011-03-29 10:54:03','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE HR_Concept_Category ADD HR_Concept_Category_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX HR_Concept_Category_UU_idx ON hr_concept_category(HR_Concept_Category_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54909,0,'HR_Contract_UU',TO_DATE('2011-03-29 10:54:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','HR_Contract_UU','HR_Contract_UU',TO_DATE('2011-03-29 10:54:05','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60815,54909,0,10,53085,'HR_Contract_UU',TO_DATE('2011-03-29 10:54:05','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','HR_Contract_UU',TO_DATE('2011-03-29 10:54:05','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE HR_Contract ADD HR_Contract_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX HR_Contract_UU_idx ON hr_contract(HR_Contract_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54910,0,'HR_Department_UU',TO_DATE('2011-03-29 10:54:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','HR_Department_UU','HR_Department_UU',TO_DATE('2011-03-29 10:54:07','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60816,54910,0,10,53088,'HR_Department_UU',TO_DATE('2011-03-29 10:54:07','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','HR_Department_UU',TO_DATE('2011-03-29 10:54:07','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE HR_Department ADD HR_Department_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX HR_Department_UU_idx ON hr_department(HR_Department_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54911,0,'HR_Employee_UU',TO_DATE('2011-03-29 10:54:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','HR_Employee_UU','HR_Employee_UU',TO_DATE('2011-03-29 10:54:10','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60817,54911,0,10,53086,'HR_Employee_UU',TO_DATE('2011-03-29 10:54:10','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','HR_Employee_UU',TO_DATE('2011-03-29 10:54:10','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE HR_Employee ADD HR_Employee_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX HR_Employee_UU_idx ON hr_employee(HR_Employee_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54912,0,'HR_Job_UU',TO_DATE('2011-03-29 10:54:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','HR_Job_UU','HR_Job_UU',TO_DATE('2011-03-29 10:54:11','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60818,54912,0,10,53089,'HR_Job_UU',TO_DATE('2011-03-29 10:54:11','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','HR_Job_UU',TO_DATE('2011-03-29 10:54:11','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE HR_Job ADD HR_Job_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX HR_Job_UU_idx ON hr_job(HR_Job_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54913,0,'HR_List_UU',TO_DATE('2011-03-29 10:54:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','HR_List_UU','HR_List_UU',TO_DATE('2011-03-29 10:54:12','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60819,54913,0,10,53099,'HR_List_UU',TO_DATE('2011-03-29 10:54:12','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','HR_List_UU',TO_DATE('2011-03-29 10:54:12','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE HR_List ADD HR_List_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX HR_List_UU_idx ON hr_list(HR_List_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54914,0,'HR_ListLine_UU',TO_DATE('2011-03-29 10:54:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','HR_ListLine_UU','HR_ListLine_UU',TO_DATE('2011-03-29 10:54:15','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60820,54914,0,10,53101,'HR_ListLine_UU',TO_DATE('2011-03-29 10:54:15','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','HR_ListLine_UU',TO_DATE('2011-03-29 10:54:15','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE HR_ListLine ADD HR_ListLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX HR_ListLine_UU_idx ON hr_listline(HR_ListLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54915,0,'HR_ListType_UU',TO_DATE('2011-03-29 10:54:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','HR_ListType_UU','HR_ListType_UU',TO_DATE('2011-03-29 10:54:17','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60821,54915,0,10,53098,'HR_ListType_UU',TO_DATE('2011-03-29 10:54:17','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','HR_ListType_UU',TO_DATE('2011-03-29 10:54:17','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE HR_ListType ADD HR_ListType_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX HR_ListType_UU_idx ON hr_listtype(HR_ListType_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54916,0,'HR_ListVersion_UU',TO_DATE('2011-03-29 10:54:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','HR_ListVersion_UU','HR_ListVersion_UU',TO_DATE('2011-03-29 10:54:20','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60822,54916,0,10,53100,'HR_ListVersion_UU',TO_DATE('2011-03-29 10:54:20','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','HR_ListVersion_UU',TO_DATE('2011-03-29 10:54:20','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE HR_ListVersion ADD HR_ListVersion_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX HR_ListVersion_UU_idx ON hr_listversion(HR_ListVersion_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54917,0,'HR_Movement_UU',TO_DATE('2011-03-29 10:54:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','HR_Movement_UU','HR_Movement_UU',TO_DATE('2011-03-29 10:54:24','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60823,54917,0,10,53102,'HR_Movement_UU',TO_DATE('2011-03-29 10:54:24','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','HR_Movement_UU',TO_DATE('2011-03-29 10:54:24','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE HR_Movement ADD HR_Movement_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX HR_Movement_UU_idx ON hr_movement(HR_Movement_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54918,0,'HR_Payroll_UU',TO_DATE('2011-03-29 10:54:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','HR_Payroll_UU','HR_Payroll_UU',TO_DATE('2011-03-29 10:54:25','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60824,54918,0,10,53093,'HR_Payroll_UU',TO_DATE('2011-03-29 10:54:25','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','HR_Payroll_UU',TO_DATE('2011-03-29 10:54:25','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE HR_Payroll ADD HR_Payroll_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX HR_Payroll_UU_idx ON hr_payroll(HR_Payroll_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54919,0,'HR_PayrollConcept_UU',TO_DATE('2011-03-29 10:54:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','HR_PayrollConcept_UU','HR_PayrollConcept_UU',TO_DATE('2011-03-29 10:54:27','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60825,54919,0,10,53096,'HR_PayrollConcept_UU',TO_DATE('2011-03-29 10:54:27','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','HR_PayrollConcept_UU',TO_DATE('2011-03-29 10:54:27','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE HR_PayrollConcept ADD HR_PayrollConcept_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX HR_PayrollConcept_UU_idx ON hr_payrollconcept(HR_PayrollConcept_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54920,0,'HR_Period_UU',TO_DATE('2011-03-29 10:54:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','HR_Period_UU','HR_Period_UU',TO_DATE('2011-03-29 10:54:28','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60826,54920,0,10,53094,'HR_Period_UU',TO_DATE('2011-03-29 10:54:28','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','HR_Period_UU',TO_DATE('2011-03-29 10:54:28','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE HR_Period ADD HR_Period_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX HR_Period_UU_idx ON hr_period(HR_Period_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54921,0,'HR_Process_UU',TO_DATE('2011-03-29 10:54:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','HR_Process_UU','HR_Process_UU',TO_DATE('2011-03-29 10:54:29','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60827,54921,0,10,53092,'HR_Process_UU',TO_DATE('2011-03-29 10:54:29','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','HR_Process_UU',TO_DATE('2011-03-29 10:54:29','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE HR_Process ADD HR_Process_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX HR_Process_UU_idx ON hr_process(HR_Process_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54922,0,'HR_Year_UU',TO_DATE('2011-03-29 10:54:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','HR_Year_UU','HR_Year_UU',TO_DATE('2011-03-29 10:54:31','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60828,54922,0,10,53095,'HR_Year_UU',TO_DATE('2011-03-29 10:54:31','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','HR_Year_UU',TO_DATE('2011-03-29 10:54:31','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE HR_Year ADD HR_Year_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX HR_Year_UU_idx ON hr_year(HR_Year_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54923,0,'I_Asset_UU',TO_DATE('2011-03-29 10:54:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','I_Asset_UU','I_Asset_UU',TO_DATE('2011-03-29 10:54:32','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60829,54923,0,10,53139,'I_Asset_UU',TO_DATE('2011-03-29 10:54:32','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','I_Asset_UU',TO_DATE('2011-03-29 10:54:32','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE I_Asset ADD I_Asset_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX I_Asset_UU_idx ON i_asset(I_Asset_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54924,0,'I_BankStatement_UU',TO_DATE('2011-03-29 10:54:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','I_BankStatement_UU','I_BankStatement_UU',TO_DATE('2011-03-29 10:54:33','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60830,54924,0,10,600,'I_BankStatement_UU',TO_DATE('2011-03-29 10:54:33','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','I_BankStatement_UU',TO_DATE('2011-03-29 10:54:33','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE I_BankStatement ADD I_BankStatement_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX I_BankStatement_UU_idx ON i_bankstatement(I_BankStatement_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54925,0,'I_BPartner_UU',TO_DATE('2011-03-29 10:54:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','I_BPartner_UU','I_BPartner_UU',TO_DATE('2011-03-29 10:54:35','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60831,54925,0,10,533,'I_BPartner_UU',TO_DATE('2011-03-29 10:54:35','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','I_BPartner_UU',TO_DATE('2011-03-29 10:54:35','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE I_BPartner ADD I_BPartner_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX I_BPartner_UU_idx ON i_bpartner(I_BPartner_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54926,0,'I_Conversion_Rate_UU',TO_DATE('2011-03-29 10:54:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','I_Conversion_Rate_UU','I_Conversion_Rate_UU',TO_DATE('2011-03-29 10:54:37','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60832,54926,0,10,641,'I_Conversion_Rate_UU',TO_DATE('2011-03-29 10:54:37','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','I_Conversion_Rate_UU',TO_DATE('2011-03-29 10:54:37','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE I_Conversion_Rate ADD I_Conversion_Rate_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX I_Conversion_Rate_UU_idx ON i_conversion_rate(I_Conversion_Rate_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54927,0,'I_ElementValue_UU',TO_DATE('2011-03-29 10:54:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','I_ElementValue_UU','I_ElementValue_UU',TO_DATE('2011-03-29 10:54:39','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60833,54927,0,10,534,'I_ElementValue_UU',TO_DATE('2011-03-29 10:54:39','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','I_ElementValue_UU',TO_DATE('2011-03-29 10:54:39','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE I_ElementValue ADD I_ElementValue_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX I_ElementValue_UU_idx ON i_elementvalue(I_ElementValue_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54928,0,'I_FAJournal_UU',TO_DATE('2011-03-29 10:54:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','I_FAJournal_UU','I_FAJournal_UU',TO_DATE('2011-03-29 10:54:40','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60834,54928,0,10,53117,'I_FAJournal_UU',TO_DATE('2011-03-29 10:54:40','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','I_FAJournal_UU',TO_DATE('2011-03-29 10:54:40','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE I_FAJournal ADD I_FAJournal_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX I_FAJournal_UU_idx ON i_fajournal(I_FAJournal_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54929,0,'I_GLJournal_UU',TO_DATE('2011-03-29 10:54:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','I_GLJournal_UU','I_GLJournal_UU',TO_DATE('2011-03-29 10:54:42','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60835,54929,0,10,599,'I_GLJournal_UU',TO_DATE('2011-03-29 10:54:42','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','I_GLJournal_UU',TO_DATE('2011-03-29 10:54:42','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE I_GLJournal ADD I_GLJournal_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX I_GLJournal_UU_idx ON i_gljournal(I_GLJournal_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54930,0,'I_HR_Movement_UU',TO_DATE('2011-03-29 10:54:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','I_HR_Movement_UU','I_HR_Movement_UU',TO_DATE('2011-03-29 10:54:44','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60836,54930,0,10,53259,'I_HR_Movement_UU',TO_DATE('2011-03-29 10:54:44','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','I_HR_Movement_UU',TO_DATE('2011-03-29 10:54:44','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE I_HR_Movement ADD I_HR_Movement_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX I_HR_Movement_UU_idx ON i_hr_movement(I_HR_Movement_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54931,0,'I_InOutLineConfirm_UU',TO_DATE('2011-03-29 10:54:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','I_InOutLineConfirm_UU','I_InOutLineConfirm_UU',TO_DATE('2011-03-29 10:54:45','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60837,54931,0,10,740,'I_InOutLineConfirm_UU',TO_DATE('2011-03-29 10:54:45','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','I_InOutLineConfirm_UU',TO_DATE('2011-03-29 10:54:45','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE I_InOutLineConfirm ADD I_InOutLineConfirm_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX I_InOutLineConfirm_UU_idx ON i_inoutlineconfirm(I_InOutLineConfirm_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54932,0,'I_Inventory_UU',TO_DATE('2011-03-29 10:54:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','I_Inventory_UU','I_Inventory_UU',TO_DATE('2011-03-29 10:54:49','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60838,54932,0,10,572,'I_Inventory_UU',TO_DATE('2011-03-29 10:54:49','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','I_Inventory_UU',TO_DATE('2011-03-29 10:54:49','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE I_Inventory ADD I_Inventory_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX I_Inventory_UU_idx ON i_inventory(I_Inventory_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54933,0,'I_Invoice_UU',TO_DATE('2011-03-29 10:54:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','I_Invoice_UU','I_Invoice_UU',TO_DATE('2011-03-29 10:54:50','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60839,54933,0,10,598,'I_Invoice_UU',TO_DATE('2011-03-29 10:54:50','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','I_Invoice_UU',TO_DATE('2011-03-29 10:54:50','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE I_Invoice ADD I_Invoice_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX I_Invoice_UU_idx ON i_invoice(I_Invoice_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54934,0,'I_Movement_UU',TO_DATE('2011-03-29 10:54:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','I_Movement_UU','I_Movement_UU',TO_DATE('2011-03-29 10:54:52','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60840,54934,0,10,53278,'I_Movement_UU',TO_DATE('2011-03-29 10:54:52','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','I_Movement_UU',TO_DATE('2011-03-29 10:54:52','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE I_Movement ADD I_Movement_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX I_Movement_UU_idx ON i_movement(I_Movement_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54935,0,'IMP_Processor_UU',TO_DATE('2011-03-29 10:54:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','IMP_Processor_UU','IMP_Processor_UU',TO_DATE('2011-03-29 10:54:53','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60841,54935,0,10,53077,'IMP_Processor_UU',TO_DATE('2011-03-29 10:54:53','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','IMP_Processor_UU',TO_DATE('2011-03-29 10:54:53','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE IMP_Processor ADD IMP_Processor_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX IMP_Processor_UU_idx ON imp_processor(IMP_Processor_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54936,0,'IMP_ProcessorLog_UU',TO_DATE('2011-03-29 10:54:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','IMP_ProcessorLog_UU','IMP_ProcessorLog_UU',TO_DATE('2011-03-29 10:54:55','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60842,54936,0,10,53079,'IMP_ProcessorLog_UU',TO_DATE('2011-03-29 10:54:55','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','IMP_ProcessorLog_UU',TO_DATE('2011-03-29 10:54:55','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE IMP_ProcessorLog ADD IMP_ProcessorLog_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX IMP_ProcessorLog_UU_idx ON imp_processorlog(IMP_ProcessorLog_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54937,0,'IMP_ProcessorParameter_UU',TO_DATE('2011-03-29 10:54:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','IMP_ProcessorParameter_UU','IMP_ProcessorParameter_UU',TO_DATE('2011-03-29 10:54:56','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60843,54937,0,10,53078,'IMP_ProcessorParameter_UU',TO_DATE('2011-03-29 10:54:56','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','IMP_ProcessorParameter_UU',TO_DATE('2011-03-29 10:54:56','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE IMP_ProcessorParameter ADD IMP_ProcessorParameter_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX IMP_ProcessorParameter_UU_idx ON imp_processorparameter(IMP_ProcessorParameter_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54938,0,'IMP_Processor_Type_UU',TO_DATE('2011-03-29 10:54:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','IMP_Processor_Type_UU','IMP_Processor_Type_UU',TO_DATE('2011-03-29 10:54:57','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60844,54938,0,10,53080,'IMP_Processor_Type_UU',TO_DATE('2011-03-29 10:54:57','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','IMP_Processor_Type_UU',TO_DATE('2011-03-29 10:54:57','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE IMP_Processor_Type ADD IMP_Processor_Type_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX IMP_Processor_Type_UU_idx ON imp_processor_type(IMP_Processor_Type_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54939,0,'I_Order_UU',TO_DATE('2011-03-29 10:54:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','I_Order_UU','I_Order_UU',TO_DATE('2011-03-29 10:54:59','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60845,54939,0,10,591,'I_Order_UU',TO_DATE('2011-03-29 10:54:59','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','I_Order_UU',TO_DATE('2011-03-29 10:54:59','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE I_Order ADD I_Order_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX I_Order_UU_idx ON i_order(I_Order_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54940,0,'I_Payment_UU',TO_DATE('2011-03-29 10:55:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','I_Payment_UU','I_Payment_UU',TO_DATE('2011-03-29 10:55:00','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60846,54940,0,10,597,'I_Payment_UU',TO_DATE('2011-03-29 10:55:00','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','I_Payment_UU',TO_DATE('2011-03-29 10:55:00','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE I_Payment ADD I_Payment_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX I_Payment_UU_idx ON i_payment(I_Payment_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54941,0,'I_PriceList_UU',TO_DATE('2011-03-29 10:55:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','I_PriceList_UU','I_PriceList_UU',TO_DATE('2011-03-29 10:55:03','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60847,54941,0,10,53173,'I_PriceList_UU',TO_DATE('2011-03-29 10:55:03','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','I_PriceList_UU',TO_DATE('2011-03-29 10:55:03','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE I_PriceList ADD I_PriceList_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX I_PriceList_UU_idx ON i_pricelist(I_PriceList_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54942,0,'I_Product_UU',TO_DATE('2011-03-29 10:55:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','I_Product_UU','I_Product_UU',TO_DATE('2011-03-29 10:55:05','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60848,54942,0,10,532,'I_Product_UU',TO_DATE('2011-03-29 10:55:05','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','I_Product_UU',TO_DATE('2011-03-29 10:55:05','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE I_Product ADD I_Product_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX I_Product_UU_idx ON i_product(I_Product_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54943,0,'I_ProductPlanning_UU',TO_DATE('2011-03-29 10:55:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','I_ProductPlanning_UU','I_ProductPlanning_UU',TO_DATE('2011-03-29 10:55:07','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60849,54943,0,10,53260,'I_ProductPlanning_UU',TO_DATE('2011-03-29 10:55:07','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','I_ProductPlanning_UU',TO_DATE('2011-03-29 10:55:07','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE I_ProductPlanning ADD I_ProductPlanning_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX I_ProductPlanning_UU_idx ON i_productplanning(I_ProductPlanning_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54944,0,'I_ReportLine_UU',TO_DATE('2011-03-29 10:55:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','I_ReportLine_UU','I_ReportLine_UU',TO_DATE('2011-03-29 10:55:08','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60850,54944,0,10,535,'I_ReportLine_UU',TO_DATE('2011-03-29 10:55:08','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','I_ReportLine_UU',TO_DATE('2011-03-29 10:55:08','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE I_ReportLine ADD I_ReportLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX I_ReportLine_UU_idx ON i_reportline(I_ReportLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54945,0,'K_Category_UU',TO_DATE('2011-03-29 10:55:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','K_Category_UU','K_Category_UU',TO_DATE('2011-03-29 10:55:10','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60851,54945,0,10,615,'K_Category_UU',TO_DATE('2011-03-29 10:55:10','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','K_Category_UU',TO_DATE('2011-03-29 10:55:10','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE K_Category ADD K_Category_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX K_Category_UU_idx ON k_category(K_Category_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54946,0,'K_CategoryValue_UU',TO_DATE('2011-03-29 10:55:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','K_CategoryValue_UU','K_CategoryValue_UU',TO_DATE('2011-03-29 10:55:11','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60852,54946,0,10,614,'K_CategoryValue_UU',TO_DATE('2011-03-29 10:55:11','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','K_CategoryValue_UU',TO_DATE('2011-03-29 10:55:11','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE K_CategoryValue ADD K_CategoryValue_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX K_CategoryValue_UU_idx ON k_categoryvalue(K_CategoryValue_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54947,0,'K_Comment_UU',TO_DATE('2011-03-29 10:55:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','K_Comment_UU','K_Comment_UU',TO_DATE('2011-03-29 10:55:13','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60853,54947,0,10,613,'K_Comment_UU',TO_DATE('2011-03-29 10:55:13','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','K_Comment_UU',TO_DATE('2011-03-29 10:55:13','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE K_Comment ADD K_Comment_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX K_Comment_UU_idx ON k_comment(K_Comment_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54948,0,'K_Entry_UU',TO_DATE('2011-03-29 10:55:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','K_Entry_UU','K_Entry_UU',TO_DATE('2011-03-29 10:55:15','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60854,54948,0,10,612,'K_Entry_UU',TO_DATE('2011-03-29 10:55:15','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','K_Entry_UU',TO_DATE('2011-03-29 10:55:15','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE K_Entry ADD K_Entry_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX K_Entry_UU_idx ON k_entry(K_Entry_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54949,0,'K_EntryCategory_UU',TO_DATE('2011-03-29 10:55:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','K_EntryCategory_UU','K_EntryCategory_UU',TO_DATE('2011-03-29 10:55:17','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60855,54949,0,10,611,'K_EntryCategory_UU',TO_DATE('2011-03-29 10:55:17','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','K_EntryCategory_UU',TO_DATE('2011-03-29 10:55:17','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE K_EntryCategory ADD K_EntryCategory_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX K_EntryCategory_UU_idx ON k_entrycategory(K_EntryCategory_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54950,0,'K_EntryRelated_UU',TO_DATE('2011-03-29 10:55:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','K_EntryRelated_UU','K_EntryRelated_UU',TO_DATE('2011-03-29 10:55:18','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60856,54950,0,10,610,'K_EntryRelated_UU',TO_DATE('2011-03-29 10:55:18','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','K_EntryRelated_UU',TO_DATE('2011-03-29 10:55:18','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE K_EntryRelated ADD K_EntryRelated_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX K_EntryRelated_UU_idx ON k_entryrelated(K_EntryRelated_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54951,0,'K_Index_UU',TO_DATE('2011-03-29 10:55:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','K_Index_UU','K_Index_UU',TO_DATE('2011-03-29 10:55:21','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60857,54951,0,10,900,'K_Index_UU',TO_DATE('2011-03-29 10:55:21','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','K_Index_UU',TO_DATE('2011-03-29 10:55:21','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE K_Index ADD K_Index_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX K_Index_UU_idx ON k_index(K_Index_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54952,0,'K_IndexLog_UU',TO_DATE('2011-03-29 10:55:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','K_IndexLog_UU','K_IndexLog_UU',TO_DATE('2011-03-29 10:55:22','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60858,54952,0,10,899,'K_IndexLog_UU',TO_DATE('2011-03-29 10:55:22','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','K_IndexLog_UU',TO_DATE('2011-03-29 10:55:22','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE K_IndexLog ADD K_IndexLog_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX K_IndexLog_UU_idx ON k_indexlog(K_IndexLog_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54953,0,'K_IndexStop_UU',TO_DATE('2011-03-29 10:55:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','K_IndexStop_UU','K_IndexStop_UU',TO_DATE('2011-03-29 10:55:24','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60859,54953,0,10,901,'K_IndexStop_UU',TO_DATE('2011-03-29 10:55:24','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','K_IndexStop_UU',TO_DATE('2011-03-29 10:55:24','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE K_IndexStop ADD K_IndexStop_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX K_IndexStop_UU_idx ON k_indexstop(K_IndexStop_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54954,0,'K_Source_UU',TO_DATE('2011-03-29 10:55:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','K_Source_UU','K_Source_UU',TO_DATE('2011-03-29 10:55:26','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60860,54954,0,10,609,'K_Source_UU',TO_DATE('2011-03-29 10:55:26','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','K_Source_UU',TO_DATE('2011-03-29 10:55:26','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE K_Source ADD K_Source_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX K_Source_UU_idx ON k_source(K_Source_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54955,0,'K_Synonym_UU',TO_DATE('2011-03-29 10:55:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','K_Synonym_UU','K_Synonym_UU',TO_DATE('2011-03-29 10:55:27','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60861,54955,0,10,608,'K_Synonym_UU',TO_DATE('2011-03-29 10:55:27','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','K_Synonym_UU',TO_DATE('2011-03-29 10:55:27','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE K_Synonym ADD K_Synonym_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX K_Synonym_UU_idx ON k_synonym(K_Synonym_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54956,0,'K_Topic_UU',TO_DATE('2011-03-29 10:55:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','K_Topic_UU','K_Topic_UU',TO_DATE('2011-03-29 10:55:29','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60862,54956,0,10,607,'K_Topic_UU',TO_DATE('2011-03-29 10:55:29','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','K_Topic_UU',TO_DATE('2011-03-29 10:55:29','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE K_Topic ADD K_Topic_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX K_Topic_UU_idx ON k_topic(K_Topic_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54957,0,'K_Type_UU',TO_DATE('2011-03-29 10:55:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','K_Type_UU','K_Type_UU',TO_DATE('2011-03-29 10:55:30','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60863,54957,0,10,606,'K_Type_UU',TO_DATE('2011-03-29 10:55:30','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','K_Type_UU',TO_DATE('2011-03-29 10:55:30','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE K_Type ADD K_Type_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX K_Type_UU_idx ON k_type(K_Type_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54958,0,'M_Attribute_UU',TO_DATE('2011-03-29 10:55:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Attribute_UU','M_Attribute_UU',TO_DATE('2011-03-29 10:55:32','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60864,54958,0,10,562,'M_Attribute_UU',TO_DATE('2011-03-29 10:55:32','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Attribute_UU',TO_DATE('2011-03-29 10:55:32','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Attribute ADD M_Attribute_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Attribute_UU_idx ON m_attribute(M_Attribute_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54959,0,'M_AttributeInstance_UU',TO_DATE('2011-03-29 10:55:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_AttributeInstance_UU','M_AttributeInstance_UU',TO_DATE('2011-03-29 10:55:33','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60865,54959,0,10,561,'M_AttributeInstance_UU',TO_DATE('2011-03-29 10:55:33','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_AttributeInstance_UU',TO_DATE('2011-03-29 10:55:33','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_AttributeInstance ADD M_AttributeInstance_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_AttributeInstance_UU_idx ON m_attributeinstance(M_AttributeInstance_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54960,0,'M_AttributeSearch_UU',TO_DATE('2011-03-29 10:55:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_AttributeSearch_UU','M_AttributeSearch_UU',TO_DATE('2011-03-29 10:55:35','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60866,54960,0,10,564,'M_AttributeSearch_UU',TO_DATE('2011-03-29 10:55:35','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_AttributeSearch_UU',TO_DATE('2011-03-29 10:55:35','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_AttributeSearch ADD M_AttributeSearch_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_AttributeSearch_UU_idx ON m_attributesearch(M_AttributeSearch_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54961,0,'M_AttributeSet_UU',TO_DATE('2011-03-29 10:55:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_AttributeSet_UU','M_AttributeSet_UU',TO_DATE('2011-03-29 10:55:36','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60867,54961,0,10,560,'M_AttributeSet_UU',TO_DATE('2011-03-29 10:55:36','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_AttributeSet_UU',TO_DATE('2011-03-29 10:55:36','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_AttributeSet ADD M_AttributeSet_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_AttributeSet_UU_idx ON m_attributeset(M_AttributeSet_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54962,0,'M_AttributeSetExclude_UU',TO_DATE('2011-03-29 10:55:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_AttributeSetExclude_UU','M_AttributeSetExclude_UU',TO_DATE('2011-03-29 10:55:38','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60868,54962,0,10,809,'M_AttributeSetExclude_UU',TO_DATE('2011-03-29 10:55:38','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_AttributeSetExclude_UU',TO_DATE('2011-03-29 10:55:38','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_AttributeSetExclude ADD M_AttributeSetExclude_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_AttributeSetExclude_UU_idx ON m_attributesetexclude(M_AttributeSetExclude_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54963,0,'M_AttributeSetInstance_UU',TO_DATE('2011-03-29 10:55:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_AttributeSetInstance_UU','M_AttributeSetInstance_UU',TO_DATE('2011-03-29 10:55:40','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60869,54963,0,10,559,'M_AttributeSetInstance_UU',TO_DATE('2011-03-29 10:55:40','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_AttributeSetInstance_UU',TO_DATE('2011-03-29 10:55:40','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_AttributeSetInstance ADD M_AttributeSetInstance_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_AttributeSetInstance_UU_idx ON m_attributesetinstance(M_AttributeSetInstance_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54964,0,'M_AttributeUse_UU',TO_DATE('2011-03-29 10:55:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_AttributeUse_UU','M_AttributeUse_UU',TO_DATE('2011-03-29 10:55:41','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60870,54964,0,10,563,'M_AttributeUse_UU',TO_DATE('2011-03-29 10:55:41','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_AttributeUse_UU',TO_DATE('2011-03-29 10:55:41','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_AttributeUse ADD M_AttributeUse_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_AttributeUse_UU_idx ON m_attributeuse(M_AttributeUse_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54965,0,'M_AttributeValue_UU',TO_DATE('2011-03-29 10:55:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_AttributeValue_UU','M_AttributeValue_UU',TO_DATE('2011-03-29 10:55:42','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60871,54965,0,10,558,'M_AttributeValue_UU',TO_DATE('2011-03-29 10:55:42','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_AttributeValue_UU',TO_DATE('2011-03-29 10:55:42','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_AttributeValue ADD M_AttributeValue_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_AttributeValue_UU_idx ON m_attributevalue(M_AttributeValue_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54966,0,'M_BOM_UU',TO_DATE('2011-03-29 10:55:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_BOM_UU','M_BOM_UU',TO_DATE('2011-03-29 10:55:44','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60872,54966,0,10,798,'M_BOM_UU',TO_DATE('2011-03-29 10:55:44','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_BOM_UU',TO_DATE('2011-03-29 10:55:44','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_BOM ADD M_BOM_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_BOM_UU_idx ON m_bom(M_BOM_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54967,0,'M_BOMAlternative_UU',TO_DATE('2011-03-29 10:55:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_BOMAlternative_UU','M_BOMAlternative_UU',TO_DATE('2011-03-29 10:55:45','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60873,54967,0,10,795,'M_BOMAlternative_UU',TO_DATE('2011-03-29 10:55:45','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_BOMAlternative_UU',TO_DATE('2011-03-29 10:55:45','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_BOMAlternative ADD M_BOMAlternative_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_BOMAlternative_UU_idx ON m_bomalternative(M_BOMAlternative_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54968,0,'M_BOMProduct_UU',TO_DATE('2011-03-29 10:55:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_BOMProduct_UU','M_BOMProduct_UU',TO_DATE('2011-03-29 10:55:46','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60874,54968,0,10,801,'M_BOMProduct_UU',TO_DATE('2011-03-29 10:55:46','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_BOMProduct_UU',TO_DATE('2011-03-29 10:55:46','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_BOMProduct ADD M_BOMProduct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_BOMProduct_UU_idx ON m_bomproduct(M_BOMProduct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54969,0,'M_ChangeNotice_UU',TO_DATE('2011-03-29 10:55:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_ChangeNotice_UU','M_ChangeNotice_UU',TO_DATE('2011-03-29 10:55:48','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60875,54969,0,10,799,'M_ChangeNotice_UU',TO_DATE('2011-03-29 10:55:48','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_ChangeNotice_UU',TO_DATE('2011-03-29 10:55:48','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_ChangeNotice ADD M_ChangeNotice_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_ChangeNotice_UU_idx ON m_changenotice(M_ChangeNotice_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54970,0,'M_ChangeRequest_UU',TO_DATE('2011-03-29 10:55:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_ChangeRequest_UU','M_ChangeRequest_UU',TO_DATE('2011-03-29 10:55:49','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60876,54970,0,10,800,'M_ChangeRequest_UU',TO_DATE('2011-03-29 10:55:49','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_ChangeRequest_UU',TO_DATE('2011-03-29 10:55:49','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_ChangeRequest ADD M_ChangeRequest_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_ChangeRequest_UU_idx ON m_changerequest(M_ChangeRequest_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54971,0,'M_Cost_UU',TO_DATE('2011-03-29 10:55:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Cost_UU','M_Cost_UU',TO_DATE('2011-03-29 10:55:51','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60877,54971,0,10,771,'M_Cost_UU',TO_DATE('2011-03-29 10:55:51','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Cost_UU',TO_DATE('2011-03-29 10:55:51','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Cost ADD M_Cost_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Cost_UU_idx ON m_cost(M_Cost_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54972,0,'M_CostDetail_UU',TO_DATE('2011-03-29 10:55:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_CostDetail_UU','M_CostDetail_UU',TO_DATE('2011-03-29 10:55:53','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60878,54972,0,10,808,'M_CostDetail_UU',TO_DATE('2011-03-29 10:55:53','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_CostDetail_UU',TO_DATE('2011-03-29 10:55:53','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_CostDetail ADD M_CostDetail_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_CostDetail_UU_idx ON m_costdetail(M_CostDetail_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54973,0,'M_CostElement_UU',TO_DATE('2011-03-29 10:55:54','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_CostElement_UU','M_CostElement_UU',TO_DATE('2011-03-29 10:55:54','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60879,54973,0,10,770,'M_CostElement_UU',TO_DATE('2011-03-29 10:55:54','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_CostElement_UU',TO_DATE('2011-03-29 10:55:54','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_CostElement ADD M_CostElement_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_CostElement_UU_idx ON m_costelement(M_CostElement_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54974,0,'M_CostQueue_UU',TO_DATE('2011-03-29 10:55:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_CostQueue_UU','M_CostQueue_UU',TO_DATE('2011-03-29 10:55:55','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60880,54974,0,10,817,'M_CostQueue_UU',TO_DATE('2011-03-29 10:55:55','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_CostQueue_UU',TO_DATE('2011-03-29 10:55:55','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_CostQueue ADD M_CostQueue_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_CostQueue_UU_idx ON m_costqueue(M_CostQueue_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54975,0,'M_CostType_UU',TO_DATE('2011-03-29 10:55:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_CostType_UU','M_CostType_UU',TO_DATE('2011-03-29 10:55:57','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60881,54975,0,10,586,'M_CostType_UU',TO_DATE('2011-03-29 10:55:57','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_CostType_UU',TO_DATE('2011-03-29 10:55:57','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_CostType ADD M_CostType_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_CostType_UU_idx ON m_costtype(M_CostType_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54976,0,'M_Demand_UU',TO_DATE('2011-03-29 10:55:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Demand_UU','M_Demand_UU',TO_DATE('2011-03-29 10:55:58','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60882,54976,0,10,723,'M_Demand_UU',TO_DATE('2011-03-29 10:55:58','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Demand_UU',TO_DATE('2011-03-29 10:55:58','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Demand ADD M_Demand_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Demand_UU_idx ON m_demand(M_Demand_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54977,0,'M_DemandDetail_UU',TO_DATE('2011-03-29 10:56:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_DemandDetail_UU','M_DemandDetail_UU',TO_DATE('2011-03-29 10:56:00','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60883,54977,0,10,721,'M_DemandDetail_UU',TO_DATE('2011-03-29 10:56:00','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_DemandDetail_UU',TO_DATE('2011-03-29 10:56:00','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_DemandDetail ADD M_DemandDetail_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_DemandDetail_UU_idx ON m_demanddetail(M_DemandDetail_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54978,0,'M_DemandLine_UU',TO_DATE('2011-03-29 10:56:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_DemandLine_UU','M_DemandLine_UU',TO_DATE('2011-03-29 10:56:01','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60884,54978,0,10,719,'M_DemandLine_UU',TO_DATE('2011-03-29 10:56:01','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_DemandLine_UU',TO_DATE('2011-03-29 10:56:01','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_DemandLine ADD M_DemandLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_DemandLine_UU_idx ON m_demandline(M_DemandLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54979,0,'M_DiscountSchema_UU',TO_DATE('2011-03-29 10:56:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_DiscountSchema_UU','M_DiscountSchema_UU',TO_DATE('2011-03-29 10:56:03','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60885,54979,0,10,475,'M_DiscountSchema_UU',TO_DATE('2011-03-29 10:56:03','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_DiscountSchema_UU',TO_DATE('2011-03-29 10:56:03','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_DiscountSchema ADD M_DiscountSchema_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_DiscountSchema_UU_idx ON m_discountschema(M_DiscountSchema_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54980,0,'M_DiscountSchemaBreak_UU',TO_DATE('2011-03-29 10:56:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_DiscountSchemaBreak_UU','M_DiscountSchemaBreak_UU',TO_DATE('2011-03-29 10:56:04','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60886,54980,0,10,476,'M_DiscountSchemaBreak_UU',TO_DATE('2011-03-29 10:56:04','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_DiscountSchemaBreak_UU',TO_DATE('2011-03-29 10:56:04','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_DiscountSchemaBreak ADD M_DiscountSchemaBreak_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_DiscountSchemaBreak_UU_idx ON m_discountschemabreak(M_DiscountSchemaBreak_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54981,0,'M_DiscountSchemaLine_UU',TO_DATE('2011-03-29 10:56:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_DiscountSchemaLine_UU','M_DiscountSchemaLine_UU',TO_DATE('2011-03-29 10:56:06','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60887,54981,0,10,477,'M_DiscountSchemaLine_UU',TO_DATE('2011-03-29 10:56:06','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_DiscountSchemaLine_UU',TO_DATE('2011-03-29 10:56:06','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_DiscountSchemaLine ADD M_DiscountSchemaLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_DiscountSchemaLine_UU_idx ON m_discountschemaline(M_DiscountSchemaLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54982,0,'M_DistributionList_UU',TO_DATE('2011-03-29 10:56:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_DistributionList_UU','M_DistributionList_UU',TO_DATE('2011-03-29 10:56:07','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60888,54982,0,10,666,'M_DistributionList_UU',TO_DATE('2011-03-29 10:56:07','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_DistributionList_UU',TO_DATE('2011-03-29 10:56:07','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_DistributionList ADD M_DistributionList_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_DistributionList_UU_idx ON m_distributionlist(M_DistributionList_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54983,0,'M_DistributionListLine_UU',TO_DATE('2011-03-29 10:56:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_DistributionListLine_UU','M_DistributionListLine_UU',TO_DATE('2011-03-29 10:56:08','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60889,54983,0,10,665,'M_DistributionListLine_UU',TO_DATE('2011-03-29 10:56:08','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_DistributionListLine_UU',TO_DATE('2011-03-29 10:56:08','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_DistributionListLine ADD M_DistributionListLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_DistributionListLine_UU_idx ON m_distributionlistline(M_DistributionListLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54984,0,'M_DistributionRun_UU',TO_DATE('2011-03-29 10:56:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_DistributionRun_UU','M_DistributionRun_UU',TO_DATE('2011-03-29 10:56:10','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60890,54984,0,10,712,'M_DistributionRun_UU',TO_DATE('2011-03-29 10:56:10','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_DistributionRun_UU',TO_DATE('2011-03-29 10:56:10','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_DistributionRun ADD M_DistributionRun_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_DistributionRun_UU_idx ON m_distributionrun(M_DistributionRun_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54985,0,'M_DistributionRunLine_UU',TO_DATE('2011-03-29 10:56:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_DistributionRunLine_UU','M_DistributionRunLine_UU',TO_DATE('2011-03-29 10:56:11','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60891,54985,0,10,713,'M_DistributionRunLine_UU',TO_DATE('2011-03-29 10:56:11','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_DistributionRunLine_UU',TO_DATE('2011-03-29 10:56:11','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_DistributionRunLine ADD M_DistributionRunLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_DistributionRunLine_UU_idx ON m_distributionrunline(M_DistributionRunLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54986,0,'M_Forecast_UU',TO_DATE('2011-03-29 10:56:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Forecast_UU','M_Forecast_UU',TO_DATE('2011-03-29 10:56:13','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60892,54986,0,10,720,'M_Forecast_UU',TO_DATE('2011-03-29 10:56:13','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Forecast_UU',TO_DATE('2011-03-29 10:56:13','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Forecast ADD M_Forecast_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Forecast_UU_idx ON m_forecast(M_Forecast_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54987,0,'M_ForecastLine_UU',TO_DATE('2011-03-29 10:56:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_ForecastLine_UU','M_ForecastLine_UU',TO_DATE('2011-03-29 10:56:21','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60893,54987,0,10,722,'M_ForecastLine_UU',TO_DATE('2011-03-29 10:56:21','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_ForecastLine_UU',TO_DATE('2011-03-29 10:56:21','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_ForecastLine ADD M_ForecastLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_ForecastLine_UU_idx ON m_forecastline(M_ForecastLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54988,0,'M_Freight_UU',TO_DATE('2011-03-29 10:56:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Freight_UU','M_Freight_UU',TO_DATE('2011-03-29 10:56:22','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60894,54988,0,10,596,'M_Freight_UU',TO_DATE('2011-03-29 10:56:22','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Freight_UU',TO_DATE('2011-03-29 10:56:22','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Freight ADD M_Freight_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Freight_UU_idx ON m_freight(M_Freight_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54989,0,'M_FreightCategory_UU',TO_DATE('2011-03-29 10:56:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_FreightCategory_UU','M_FreightCategory_UU',TO_DATE('2011-03-29 10:56:24','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60895,54989,0,10,595,'M_FreightCategory_UU',TO_DATE('2011-03-29 10:56:24','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_FreightCategory_UU',TO_DATE('2011-03-29 10:56:24','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_FreightCategory ADD M_FreightCategory_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_FreightCategory_UU_idx ON m_freightcategory(M_FreightCategory_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54990,0,'M_InOut_UU',TO_DATE('2011-03-29 10:56:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_InOut_UU','M_InOut_UU',TO_DATE('2011-03-29 10:56:26','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60896,54990,0,10,319,'M_InOut_UU',TO_DATE('2011-03-29 10:56:26','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_InOut_UU',TO_DATE('2011-03-29 10:56:26','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_InOut ADD M_InOut_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_InOut_UU_idx ON m_inout(M_InOut_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54991,0,'M_InOutConfirm_UU',TO_DATE('2011-03-29 10:56:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_InOutConfirm_UU','M_InOutConfirm_UU',TO_DATE('2011-03-29 10:56:28','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60897,54991,0,10,727,'M_InOutConfirm_UU',TO_DATE('2011-03-29 10:56:28','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_InOutConfirm_UU',TO_DATE('2011-03-29 10:56:28','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_InOutConfirm ADD M_InOutConfirm_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_InOutConfirm_UU_idx ON m_inoutconfirm(M_InOutConfirm_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54992,0,'M_InOutLine_UU',TO_DATE('2011-03-29 10:56:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_InOutLine_UU','M_InOutLine_UU',TO_DATE('2011-03-29 10:56:30','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60898,54992,0,10,320,'M_InOutLine_UU',TO_DATE('2011-03-29 10:56:30','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_InOutLine_UU',TO_DATE('2011-03-29 10:56:30','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_InOutLine ADD M_InOutLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_InOutLine_UU_idx ON m_inoutline(M_InOutLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54993,0,'M_InOutLineConfirm_UU',TO_DATE('2011-03-29 10:56:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_InOutLineConfirm_UU','M_InOutLineConfirm_UU',TO_DATE('2011-03-29 10:56:31','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60899,54993,0,10,728,'M_InOutLineConfirm_UU',TO_DATE('2011-03-29 10:56:31','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_InOutLineConfirm_UU',TO_DATE('2011-03-29 10:56:31','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_InOutLineConfirm ADD M_InOutLineConfirm_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_InOutLineConfirm_UU_idx ON m_inoutlineconfirm(M_InOutLineConfirm_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54994,0,'M_InOutLineMA_UU',TO_DATE('2011-03-29 10:56:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_InOutLineMA_UU','M_InOutLineMA_UU',TO_DATE('2011-03-29 10:56:34','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60900,54994,0,10,762,'M_InOutLineMA_UU',TO_DATE('2011-03-29 10:56:34','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_InOutLineMA_UU',TO_DATE('2011-03-29 10:56:34','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_InOutLineMA ADD M_InOutLineMA_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_InOutLineMA_UU_idx ON m_inoutlinema(M_InOutLineMA_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54995,0,'M_Inventory_UU',TO_DATE('2011-03-29 10:56:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Inventory_UU','M_Inventory_UU',TO_DATE('2011-03-29 10:56:35','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60901,54995,0,10,321,'M_Inventory_UU',TO_DATE('2011-03-29 10:56:35','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Inventory_UU',TO_DATE('2011-03-29 10:56:35','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Inventory ADD M_Inventory_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Inventory_UU_idx ON m_inventory(M_Inventory_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54996,0,'M_InventoryLine_UU',TO_DATE('2011-03-29 10:56:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_InventoryLine_UU','M_InventoryLine_UU',TO_DATE('2011-03-29 10:56:37','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60902,54996,0,10,322,'M_InventoryLine_UU',TO_DATE('2011-03-29 10:56:37','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_InventoryLine_UU',TO_DATE('2011-03-29 10:56:37','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_InventoryLine ADD M_InventoryLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_InventoryLine_UU_idx ON m_inventoryline(M_InventoryLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54997,0,'M_InventoryLineMA_UU',TO_DATE('2011-03-29 10:56:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_InventoryLineMA_UU','M_InventoryLineMA_UU',TO_DATE('2011-03-29 10:56:38','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60903,54997,0,10,763,'M_InventoryLineMA_UU',TO_DATE('2011-03-29 10:56:38','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_InventoryLineMA_UU',TO_DATE('2011-03-29 10:56:38','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_InventoryLineMA ADD M_InventoryLineMA_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_InventoryLineMA_UU_idx ON m_inventorylinema(M_InventoryLineMA_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54998,0,'M_Locator_UU',TO_DATE('2011-03-29 10:56:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Locator_UU','M_Locator_UU',TO_DATE('2011-03-29 10:56:40','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60904,54998,0,10,207,'M_Locator_UU',TO_DATE('2011-03-29 10:56:40','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Locator_UU',TO_DATE('2011-03-29 10:56:40','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Locator ADD M_Locator_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Locator_UU_idx ON m_locator(M_Locator_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54999,0,'M_Lot_UU',TO_DATE('2011-03-29 10:56:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Lot_UU','M_Lot_UU',TO_DATE('2011-03-29 10:56:41','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60905,54999,0,10,557,'M_Lot_UU',TO_DATE('2011-03-29 10:56:41','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Lot_UU',TO_DATE('2011-03-29 10:56:41','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Lot ADD M_Lot_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Lot_UU_idx ON m_lot(M_Lot_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55000,0,'M_LotCtl_UU',TO_DATE('2011-03-29 10:56:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_LotCtl_UU','M_LotCtl_UU',TO_DATE('2011-03-29 10:56:43','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60906,55000,0,10,556,'M_LotCtl_UU',TO_DATE('2011-03-29 10:56:43','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_LotCtl_UU',TO_DATE('2011-03-29 10:56:43','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_LotCtl ADD M_LotCtl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_LotCtl_UU_idx ON m_lotctl(M_LotCtl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55001,0,'M_LotCtlExclude_UU',TO_DATE('2011-03-29 10:56:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_LotCtlExclude_UU','M_LotCtlExclude_UU',TO_DATE('2011-03-29 10:56:44','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60907,55001,0,10,810,'M_LotCtlExclude_UU',TO_DATE('2011-03-29 10:56:44','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_LotCtlExclude_UU',TO_DATE('2011-03-29 10:56:44','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_LotCtlExclude ADD M_LotCtlExclude_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_LotCtlExclude_UU_idx ON m_lotctlexclude(M_LotCtlExclude_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55002,0,'M_MatchInv_UU',TO_DATE('2011-03-29 10:56:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_MatchInv_UU','M_MatchInv_UU',TO_DATE('2011-03-29 10:56:46','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60908,55002,0,10,472,'M_MatchInv_UU',TO_DATE('2011-03-29 10:56:46','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_MatchInv_UU',TO_DATE('2011-03-29 10:56:46','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_MatchInv ADD M_MatchInv_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_MatchInv_UU_idx ON m_matchinv(M_MatchInv_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55003,0,'M_MatchPO_UU',TO_DATE('2011-03-29 10:56:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_MatchPO_UU','M_MatchPO_UU',TO_DATE('2011-03-29 10:56:48','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60909,55003,0,10,473,'M_MatchPO_UU',TO_DATE('2011-03-29 10:56:48','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_MatchPO_UU',TO_DATE('2011-03-29 10:56:48','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_MatchPO ADD M_MatchPO_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_MatchPO_UU_idx ON m_matchpo(M_MatchPO_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55004,0,'M_Movement_UU',TO_DATE('2011-03-29 10:56:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Movement_UU','M_Movement_UU',TO_DATE('2011-03-29 10:56:50','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60910,55004,0,10,323,'M_Movement_UU',TO_DATE('2011-03-29 10:56:50','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Movement_UU',TO_DATE('2011-03-29 10:56:50','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Movement ADD M_Movement_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Movement_UU_idx ON m_movement(M_Movement_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55005,0,'M_MovementConfirm_UU',TO_DATE('2011-03-29 10:56:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_MovementConfirm_UU','M_MovementConfirm_UU',TO_DATE('2011-03-29 10:56:57','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60911,55005,0,10,738,'M_MovementConfirm_UU',TO_DATE('2011-03-29 10:56:57','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_MovementConfirm_UU',TO_DATE('2011-03-29 10:56:57','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_MovementConfirm ADD M_MovementConfirm_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_MovementConfirm_UU_idx ON m_movementconfirm(M_MovementConfirm_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55006,0,'M_MovementLine_UU',TO_DATE('2011-03-29 10:56:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_MovementLine_UU','M_MovementLine_UU',TO_DATE('2011-03-29 10:56:59','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60912,55006,0,10,324,'M_MovementLine_UU',TO_DATE('2011-03-29 10:56:59','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_MovementLine_UU',TO_DATE('2011-03-29 10:56:59','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_MovementLine ADD M_MovementLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_MovementLine_UU_idx ON m_movementline(M_MovementLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55007,0,'M_MovementLineConfirm_UU',TO_DATE('2011-03-29 10:57:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_MovementLineConfirm_UU','M_MovementLineConfirm_UU',TO_DATE('2011-03-29 10:57:05','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60913,55007,0,10,737,'M_MovementLineConfirm_UU',TO_DATE('2011-03-29 10:57:05','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_MovementLineConfirm_UU',TO_DATE('2011-03-29 10:57:05','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_MovementLineConfirm ADD M_MovementLineConfirm_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_MovementLineConfirm_UU_idx ON m_movementlineconfirm(M_MovementLineConfirm_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55008,0,'M_MovementLineMA_UU',TO_DATE('2011-03-29 10:57:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_MovementLineMA_UU','M_MovementLineMA_UU',TO_DATE('2011-03-29 10:57:06','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60914,55008,0,10,764,'M_MovementLineMA_UU',TO_DATE('2011-03-29 10:57:06','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_MovementLineMA_UU',TO_DATE('2011-03-29 10:57:06','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_MovementLineMA ADD M_MovementLineMA_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_MovementLineMA_UU_idx ON m_movementlinema(M_MovementLineMA_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55009,0,'M_OperationResource_UU',TO_DATE('2011-03-29 10:57:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_OperationResource_UU','M_OperationResource_UU',TO_DATE('2011-03-29 10:57:07','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60915,55009,0,10,797,'M_OperationResource_UU',TO_DATE('2011-03-29 10:57:07','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_OperationResource_UU',TO_DATE('2011-03-29 10:57:07','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_OperationResource ADD M_OperationResource_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_OperationResource_UU_idx ON m_operationresource(M_OperationResource_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55010,0,'M_Package_UU',TO_DATE('2011-03-29 10:57:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Package_UU','M_Package_UU',TO_DATE('2011-03-29 10:57:09','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60916,55010,0,10,664,'M_Package_UU',TO_DATE('2011-03-29 10:57:09','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Package_UU',TO_DATE('2011-03-29 10:57:09','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Package ADD M_Package_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Package_UU_idx ON m_package(M_Package_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55011,0,'M_PackageLine_UU',TO_DATE('2011-03-29 10:57:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_PackageLine_UU','M_PackageLine_UU',TO_DATE('2011-03-29 10:57:10','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60917,55011,0,10,663,'M_PackageLine_UU',TO_DATE('2011-03-29 10:57:10','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_PackageLine_UU',TO_DATE('2011-03-29 10:57:10','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_PackageLine ADD M_PackageLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_PackageLine_UU_idx ON m_packageline(M_PackageLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55012,0,'M_PerpetualInv_UU',TO_DATE('2011-03-29 10:57:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_PerpetualInv_UU','M_PerpetualInv_UU',TO_DATE('2011-03-29 10:57:12','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60918,55012,0,10,342,'M_PerpetualInv_UU',TO_DATE('2011-03-29 10:57:12','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_PerpetualInv_UU',TO_DATE('2011-03-29 10:57:12','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_PerpetualInv ADD M_PerpetualInv_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_PerpetualInv_UU_idx ON m_perpetualinv(M_PerpetualInv_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55013,0,'M_PriceList_UU',TO_DATE('2011-03-29 10:57:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_PriceList_UU','M_PriceList_UU',TO_DATE('2011-03-29 10:57:13','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60919,55013,0,10,255,'M_PriceList_UU',TO_DATE('2011-03-29 10:57:13','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_PriceList_UU',TO_DATE('2011-03-29 10:57:13','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_PriceList ADD M_PriceList_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_PriceList_UU_idx ON m_pricelist(M_PriceList_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55014,0,'M_PriceList_Version_UU',TO_DATE('2011-03-29 10:57:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_PriceList_Version_UU','M_PriceList_Version_UU',TO_DATE('2011-03-29 10:57:15','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60920,55014,0,10,295,'M_PriceList_Version_UU',TO_DATE('2011-03-29 10:57:15','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_PriceList_Version_UU',TO_DATE('2011-03-29 10:57:15','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_PriceList_Version ADD M_PriceList_Version_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_PriceList_Version_UU_idx ON m_pricelist_version(M_PriceList_Version_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55015,0,'M_Product_UU',TO_DATE('2011-03-29 10:57:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Product_UU','M_Product_UU',TO_DATE('2011-03-29 10:57:16','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60921,55015,0,10,208,'M_Product_UU',TO_DATE('2011-03-29 10:57:16','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Product_UU',TO_DATE('2011-03-29 10:57:16','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Product ADD M_Product_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Product_UU_idx ON m_product(M_Product_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55016,0,'M_Product_Acct_UU',TO_DATE('2011-03-29 10:57:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Product_Acct_UU','M_Product_Acct_UU',TO_DATE('2011-03-29 10:57:18','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60922,55016,0,10,273,'M_Product_Acct_UU',TO_DATE('2011-03-29 10:57:18','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Product_Acct_UU',TO_DATE('2011-03-29 10:57:18','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Product_Acct ADD M_Product_Acct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Product_Acct_UU_idx ON m_product_acct(M_Product_Acct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55017,0,'M_Product_BOM_UU',TO_DATE('2011-03-29 10:57:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Product_BOM_UU','M_Product_BOM_UU',TO_DATE('2011-03-29 10:57:20','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60923,55017,0,10,383,'M_Product_BOM_UU',TO_DATE('2011-03-29 10:57:20','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Product_BOM_UU',TO_DATE('2011-03-29 10:57:20','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Product_BOM ADD M_Product_BOM_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Product_BOM_UU_idx ON m_product_bom(M_Product_BOM_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55018,0,'M_Product_Category_UU',TO_DATE('2011-03-29 10:57:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Product_Category_UU','M_Product_Category_UU',TO_DATE('2011-03-29 10:57:21','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60924,55018,0,10,209,'M_Product_Category_UU',TO_DATE('2011-03-29 10:57:21','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Product_Category_UU',TO_DATE('2011-03-29 10:57:21','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Product_Category ADD M_Product_Category_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Product_Category_UU_idx ON m_product_category(M_Product_Category_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55019,0,'M_Product_Category_Acct_UU',TO_DATE('2011-03-29 10:57:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Product_Category_Acct_UU','M_Product_Category_Acct_UU',TO_DATE('2011-03-29 10:57:23','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60925,55019,0,10,401,'M_Product_Category_Acct_UU',TO_DATE('2011-03-29 10:57:23','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Product_Category_Acct_UU',TO_DATE('2011-03-29 10:57:23','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Product_Category_Acct ADD M_Product_Category_Acct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Product_Category_Acct_UU_idx ON m_product_category_acct(M_Product_Category_Acct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55020,0,'M_Product_Costing_UU',TO_DATE('2011-03-29 10:57:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Product_Costing_UU','M_Product_Costing_UU',TO_DATE('2011-03-29 10:57:24','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60926,55020,0,10,327,'M_Product_Costing_UU',TO_DATE('2011-03-29 10:57:24','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Product_Costing_UU',TO_DATE('2011-03-29 10:57:24','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Product_Costing ADD M_Product_Costing_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Product_Costing_UU_idx ON m_product_costing(M_Product_Costing_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55021,0,'M_ProductDownload_UU',TO_DATE('2011-03-29 10:57:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_ProductDownload_UU','M_ProductDownload_UU',TO_DATE('2011-03-29 10:57:25','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60927,55021,0,10,777,'M_ProductDownload_UU',TO_DATE('2011-03-29 10:57:25','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_ProductDownload_UU',TO_DATE('2011-03-29 10:57:25','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_ProductDownload ADD M_ProductDownload_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_ProductDownload_UU_idx ON m_productdownload(M_ProductDownload_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55022,0,'M_Production_UU',TO_DATE('2011-03-29 10:57:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Production_UU','M_Production_UU',TO_DATE('2011-03-29 10:57:27','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60928,55022,0,10,325,'M_Production_UU',TO_DATE('2011-03-29 10:57:27','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Production_UU',TO_DATE('2011-03-29 10:57:27','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Production ADD M_Production_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Production_UU_idx ON m_production(M_Production_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55023,0,'M_ProductionLine_UU',TO_DATE('2011-03-29 10:57:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_ProductionLine_UU','M_ProductionLine_UU',TO_DATE('2011-03-29 10:57:28','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60929,55023,0,10,326,'M_ProductionLine_UU',TO_DATE('2011-03-29 10:57:28','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_ProductionLine_UU',TO_DATE('2011-03-29 10:57:28','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_ProductionLine ADD M_ProductionLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_ProductionLine_UU_idx ON m_productionline(M_ProductionLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55024,0,'M_ProductionLineMA_UU',TO_DATE('2011-03-29 10:57:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_ProductionLineMA_UU','M_ProductionLineMA_UU',TO_DATE('2011-03-29 10:57:30','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60930,55024,0,10,765,'M_ProductionLineMA_UU',TO_DATE('2011-03-29 10:57:30','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_ProductionLineMA_UU',TO_DATE('2011-03-29 10:57:30','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_ProductionLineMA ADD M_ProductionLineMA_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_ProductionLineMA_UU_idx ON m_productionlinema(M_ProductionLineMA_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55025,0,'M_ProductionPlan_UU',TO_DATE('2011-03-29 10:57:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_ProductionPlan_UU','M_ProductionPlan_UU',TO_DATE('2011-03-29 10:57:31','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60931,55025,0,10,385,'M_ProductionPlan_UU',TO_DATE('2011-03-29 10:57:31','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_ProductionPlan_UU',TO_DATE('2011-03-29 10:57:31','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_ProductionPlan ADD M_ProductionPlan_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_ProductionPlan_UU_idx ON m_productionplan(M_ProductionPlan_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55026,0,'M_ProductOperation_UU',TO_DATE('2011-03-29 10:57:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_ProductOperation_UU','M_ProductOperation_UU',TO_DATE('2011-03-29 10:57:33','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60932,55026,0,10,796,'M_ProductOperation_UU',TO_DATE('2011-03-29 10:57:33','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_ProductOperation_UU',TO_DATE('2011-03-29 10:57:33','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_ProductOperation ADD M_ProductOperation_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_ProductOperation_UU_idx ON m_productoperation(M_ProductOperation_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55027,0,'M_Product_PO_UU',TO_DATE('2011-03-29 10:57:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Product_PO_UU','M_Product_PO_UU',TO_DATE('2011-03-29 10:57:34','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60933,55027,0,10,210,'M_Product_PO_UU',TO_DATE('2011-03-29 10:57:34','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Product_PO_UU',TO_DATE('2011-03-29 10:57:34','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Product_PO ADD M_Product_PO_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Product_PO_UU_idx ON m_product_po(M_Product_PO_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55028,0,'M_ProductPrice_UU',TO_DATE('2011-03-29 10:57:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_ProductPrice_UU','M_ProductPrice_UU',TO_DATE('2011-03-29 10:57:36','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60934,55028,0,10,251,'M_ProductPrice_UU',TO_DATE('2011-03-29 10:57:36','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_ProductPrice_UU',TO_DATE('2011-03-29 10:57:36','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_ProductPrice ADD M_ProductPrice_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_ProductPrice_UU_idx ON m_productprice(M_ProductPrice_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55029,0,'M_ProductPriceVendorBreak_UU',TO_DATE('2011-03-29 10:57:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_ProductPriceVendorBreak_UU','M_ProductPriceVendorBreak_UU',TO_DATE('2011-03-29 10:57:38','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60935,55029,0,10,53172,'M_ProductPriceVendorBreak_UU',TO_DATE('2011-03-29 10:57:38','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_ProductPriceVendorBreak_UU',TO_DATE('2011-03-29 10:57:38','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_ProductPriceVendorBreak ADD M_ProductPriceVendorBreak_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_ProductPriceVendorBre_UU_idx ON m_productpricevendorbreak(M_ProductPriceVendorBreak_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55030,0,'M_Product_Trl_UU',TO_DATE('2011-03-29 10:57:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Product_Trl_UU','M_Product_Trl_UU',TO_DATE('2011-03-29 10:57:39','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60936,55030,0,10,312,'M_Product_Trl_UU',TO_DATE('2011-03-29 10:57:39','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Product_Trl_UU',TO_DATE('2011-03-29 10:57:39','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Product_Trl ADD M_Product_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Product_Trl_UU_idx ON m_product_trl(M_Product_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55031,0,'M_Promotion_UU',TO_DATE('2011-03-29 10:57:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Promotion_UU','M_Promotion_UU',TO_DATE('2011-03-29 10:57:41','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60937,55031,0,10,53178,'M_Promotion_UU',TO_DATE('2011-03-29 10:57:41','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Promotion_UU',TO_DATE('2011-03-29 10:57:41','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Promotion ADD M_Promotion_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Promotion_UU_idx ON m_promotion(M_Promotion_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55032,0,'M_PromotionDistribution_UU',TO_DATE('2011-03-29 10:57:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_PromotionDistribution_UU','M_PromotionDistribution_UU',TO_DATE('2011-03-29 10:57:42','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60938,55032,0,10,53181,'M_PromotionDistribution_UU',TO_DATE('2011-03-29 10:57:42','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_PromotionDistribution_UU',TO_DATE('2011-03-29 10:57:42','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_PromotionDistribution ADD M_PromotionDistribution_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_PromotionDistribution_UU_idx ON m_promotiondistribution(M_PromotionDistribution_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55033,0,'M_PromotionGroup_UU',TO_DATE('2011-03-29 10:57:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_PromotionGroup_UU','M_PromotionGroup_UU',TO_DATE('2011-03-29 10:57:43','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60939,55033,0,10,53176,'M_PromotionGroup_UU',TO_DATE('2011-03-29 10:57:43','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_PromotionGroup_UU',TO_DATE('2011-03-29 10:57:43','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_PromotionGroup ADD M_PromotionGroup_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_PromotionGroup_UU_idx ON m_promotiongroup(M_PromotionGroup_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55034,0,'M_PromotionGroupLine_UU',TO_DATE('2011-03-29 10:57:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_PromotionGroupLine_UU','M_PromotionGroupLine_UU',TO_DATE('2011-03-29 10:57:45','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60940,55034,0,10,53177,'M_PromotionGroupLine_UU',TO_DATE('2011-03-29 10:57:45','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_PromotionGroupLine_UU',TO_DATE('2011-03-29 10:57:45','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_PromotionGroupLine ADD M_PromotionGroupLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_PromotionGroupLine_UU_idx ON m_promotiongroupline(M_PromotionGroupLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55035,0,'M_PromotionLine_UU',TO_DATE('2011-03-29 10:57:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_PromotionLine_UU','M_PromotionLine_UU',TO_DATE('2011-03-29 10:57:47','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60941,55035,0,10,53179,'M_PromotionLine_UU',TO_DATE('2011-03-29 10:57:47','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_PromotionLine_UU',TO_DATE('2011-03-29 10:57:47','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_PromotionLine ADD M_PromotionLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_PromotionLine_UU_idx ON m_promotionline(M_PromotionLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55036,0,'M_PromotionPreCondition_UU',TO_DATE('2011-03-29 10:57:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_PromotionPreCondition_UU','M_PromotionPreCondition_UU',TO_DATE('2011-03-29 10:57:52','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60942,55036,0,10,53180,'M_PromotionPreCondition_UU',TO_DATE('2011-03-29 10:57:52','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_PromotionPreCondition_UU',TO_DATE('2011-03-29 10:57:52','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_PromotionPreCondition ADD M_PromotionPreCondition_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_PromotionPreCondition_UU_idx ON m_promotionprecondition(M_PromotionPreCondition_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55037,0,'M_PromotionReward_UU',TO_DATE('2011-03-29 10:57:54','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_PromotionReward_UU','M_PromotionReward_UU',TO_DATE('2011-03-29 10:57:54','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60943,55037,0,10,53182,'M_PromotionReward_UU',TO_DATE('2011-03-29 10:57:54','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_PromotionReward_UU',TO_DATE('2011-03-29 10:57:54','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_PromotionReward ADD M_PromotionReward_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_PromotionReward_UU_idx ON m_promotionreward(M_PromotionReward_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55038,0,'M_RelatedProduct_UU',TO_DATE('2011-03-29 10:57:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_RelatedProduct_UU','M_RelatedProduct_UU',TO_DATE('2011-03-29 10:57:55','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60944,55038,0,10,662,'M_RelatedProduct_UU',TO_DATE('2011-03-29 10:57:55','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_RelatedProduct_UU',TO_DATE('2011-03-29 10:57:55','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_RelatedProduct ADD M_RelatedProduct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_RelatedProduct_UU_idx ON m_relatedproduct(M_RelatedProduct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55039,0,'M_Replenish_UU',TO_DATE('2011-03-29 10:57:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Replenish_UU','M_Replenish_UU',TO_DATE('2011-03-29 10:57:57','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60945,55039,0,10,249,'M_Replenish_UU',TO_DATE('2011-03-29 10:57:57','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Replenish_UU',TO_DATE('2011-03-29 10:57:57','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Replenish ADD M_Replenish_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Replenish_UU_idx ON m_replenish(M_Replenish_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55040,0,'M_Requisition_UU',TO_DATE('2011-03-29 10:57:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Requisition_UU','M_Requisition_UU',TO_DATE('2011-03-29 10:57:58','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60946,55040,0,10,702,'M_Requisition_UU',TO_DATE('2011-03-29 10:57:58','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Requisition_UU',TO_DATE('2011-03-29 10:57:58','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Requisition ADD M_Requisition_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Requisition_UU_idx ON m_requisition(M_Requisition_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55041,0,'M_RequisitionLine_UU',TO_DATE('2011-03-29 10:58:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_RequisitionLine_UU','M_RequisitionLine_UU',TO_DATE('2011-03-29 10:58:00','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60947,55041,0,10,703,'M_RequisitionLine_UU',TO_DATE('2011-03-29 10:58:00','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_RequisitionLine_UU',TO_DATE('2011-03-29 10:58:00','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_RequisitionLine ADD M_RequisitionLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_RequisitionLine_UU_idx ON m_requisitionline(M_RequisitionLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55042,0,'M_RMA_UU',TO_DATE('2011-03-29 10:58:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_RMA_UU','M_RMA_UU',TO_DATE('2011-03-29 10:58:01','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60948,55042,0,10,661,'M_RMA_UU',TO_DATE('2011-03-29 10:58:01','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_RMA_UU',TO_DATE('2011-03-29 10:58:01','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_RMA ADD M_RMA_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_RMA_UU_idx ON m_rma(M_RMA_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55043,0,'M_RMALine_UU',TO_DATE('2011-03-29 10:58:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_RMALine_UU','M_RMALine_UU',TO_DATE('2011-03-29 10:58:03','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60949,55043,0,10,660,'M_RMALine_UU',TO_DATE('2011-03-29 10:58:03','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_RMALine_UU',TO_DATE('2011-03-29 10:58:03','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_RMALine ADD M_RMALine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_RMALine_UU_idx ON m_rmaline(M_RMALine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55044,0,'M_RMAType_UU',TO_DATE('2011-03-29 10:58:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_RMAType_UU','M_RMAType_UU',TO_DATE('2011-03-29 10:58:04','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60950,55044,0,10,729,'M_RMAType_UU',TO_DATE('2011-03-29 10:58:04','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_RMAType_UU',TO_DATE('2011-03-29 10:58:04','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_RMAType ADD M_RMAType_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_RMAType_UU_idx ON m_rmatype(M_RMAType_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55045,0,'M_SerNoCtl_UU',TO_DATE('2011-03-29 10:58:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_SerNoCtl_UU','M_SerNoCtl_UU',TO_DATE('2011-03-29 10:58:06','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60951,55045,0,10,555,'M_SerNoCtl_UU',TO_DATE('2011-03-29 10:58:06','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_SerNoCtl_UU',TO_DATE('2011-03-29 10:58:06','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_SerNoCtl ADD M_SerNoCtl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_SerNoCtl_UU_idx ON m_sernoctl(M_SerNoCtl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55046,0,'M_SerNoCtlExclude_UU',TO_DATE('2011-03-29 10:58:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_SerNoCtlExclude_UU','M_SerNoCtlExclude_UU',TO_DATE('2011-03-29 10:58:07','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60952,55046,0,10,811,'M_SerNoCtlExclude_UU',TO_DATE('2011-03-29 10:58:07','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_SerNoCtlExclude_UU',TO_DATE('2011-03-29 10:58:07','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_SerNoCtlExclude ADD M_SerNoCtlExclude_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_SerNoCtlExclude_UU_idx ON m_sernoctlexclude(M_SerNoCtlExclude_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55047,0,'M_Shipper_UU',TO_DATE('2011-03-29 10:58:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Shipper_UU','M_Shipper_UU',TO_DATE('2011-03-29 10:58:09','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60953,55047,0,10,253,'M_Shipper_UU',TO_DATE('2011-03-29 10:58:09','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Shipper_UU',TO_DATE('2011-03-29 10:58:09','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Shipper ADD M_Shipper_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Shipper_UU_idx ON m_shipper(M_Shipper_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55048,0,'M_Storage_UU',TO_DATE('2011-03-29 10:58:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Storage_UU','M_Storage_UU',TO_DATE('2011-03-29 10:58:11','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60954,55048,0,10,250,'M_Storage_UU',TO_DATE('2011-03-29 10:58:11','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Storage_UU',TO_DATE('2011-03-29 10:58:11','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Storage ADD M_Storage_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Storage_UU_idx ON m_storage(M_Storage_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55049,0,'M_Substitute_UU',TO_DATE('2011-03-29 10:58:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Substitute_UU','M_Substitute_UU',TO_DATE('2011-03-29 10:58:12','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60955,55049,0,10,213,'M_Substitute_UU',TO_DATE('2011-03-29 10:58:12','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Substitute_UU',TO_DATE('2011-03-29 10:58:12','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Substitute ADD M_Substitute_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Substitute_UU_idx ON m_substitute(M_Substitute_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55050,0,'M_Transaction_UU',TO_DATE('2011-03-29 10:58:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Transaction_UU','M_Transaction_UU',TO_DATE('2011-03-29 10:58:14','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60956,55050,0,10,329,'M_Transaction_UU',TO_DATE('2011-03-29 10:58:14','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Transaction_UU',TO_DATE('2011-03-29 10:58:14','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Transaction ADD M_Transaction_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Transaction_UU_idx ON m_transaction(M_Transaction_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55051,0,'M_TransactionAllocation_UU',TO_DATE('2011-03-29 10:58:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_TransactionAllocation_UU','M_TransactionAllocation_UU',TO_DATE('2011-03-29 10:58:16','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60957,55051,0,10,636,'M_TransactionAllocation_UU',TO_DATE('2011-03-29 10:58:16','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_TransactionAllocation_UU',TO_DATE('2011-03-29 10:58:16','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_TransactionAllocation ADD M_TransactionAllocation_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_TransactionAllocation_UU_idx ON m_transactionallocation(M_TransactionAllocation_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55052,0,'M_Warehouse_UU',TO_DATE('2011-03-29 10:58:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Warehouse_UU','M_Warehouse_UU',TO_DATE('2011-03-29 10:58:18','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60958,55052,0,10,190,'M_Warehouse_UU',TO_DATE('2011-03-29 10:58:18','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Warehouse_UU',TO_DATE('2011-03-29 10:58:18','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Warehouse ADD M_Warehouse_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Warehouse_UU_idx ON m_warehouse(M_Warehouse_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55053,0,'M_Warehouse_Acct_UU',TO_DATE('2011-03-29 10:58:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Warehouse_Acct_UU','M_Warehouse_Acct_UU',TO_DATE('2011-03-29 10:58:20','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60959,55053,0,10,191,'M_Warehouse_Acct_UU',TO_DATE('2011-03-29 10:58:20','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','M_Warehouse_Acct_UU',TO_DATE('2011-03-29 10:58:20','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE M_Warehouse_Acct ADD M_Warehouse_Acct_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX M_Warehouse_Acct_UU_idx ON m_warehouse_acct(M_Warehouse_Acct_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55054,0,'PA_Achievement_UU',TO_DATE('2011-03-29 10:58:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_Achievement_UU','PA_Achievement_UU',TO_DATE('2011-03-29 10:58:21','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60960,55054,0,10,438,'PA_Achievement_UU',TO_DATE('2011-03-29 10:58:21','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_Achievement_UU',TO_DATE('2011-03-29 10:58:21','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_Achievement ADD PA_Achievement_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_Achievement_UU_idx ON pa_achievement(PA_Achievement_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55055,0,'PA_Benchmark_UU',TO_DATE('2011-03-29 10:58:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_Benchmark_UU','PA_Benchmark_UU',TO_DATE('2011-03-29 10:58:23','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60961,55055,0,10,833,'PA_Benchmark_UU',TO_DATE('2011-03-29 10:58:23','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_Benchmark_UU',TO_DATE('2011-03-29 10:58:23','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_Benchmark ADD PA_Benchmark_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_Benchmark_UU_idx ON pa_benchmark(PA_Benchmark_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55056,0,'PA_BenchmarkData_UU',TO_DATE('2011-03-29 10:58:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_BenchmarkData_UU','PA_BenchmarkData_UU',TO_DATE('2011-03-29 10:58:24','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60962,55056,0,10,834,'PA_BenchmarkData_UU',TO_DATE('2011-03-29 10:58:24','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_BenchmarkData_UU',TO_DATE('2011-03-29 10:58:24','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_BenchmarkData ADD PA_BenchmarkData_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_BenchmarkData_UU_idx ON pa_benchmarkdata(PA_BenchmarkData_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55057,0,'PA_ColorSchema_UU',TO_DATE('2011-03-29 10:58:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_ColorSchema_UU','PA_ColorSchema_UU',TO_DATE('2011-03-29 10:58:26','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60963,55057,0,10,831,'PA_ColorSchema_UU',TO_DATE('2011-03-29 10:58:26','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_ColorSchema_UU',TO_DATE('2011-03-29 10:58:26','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_ColorSchema ADD PA_ColorSchema_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_ColorSchema_UU_idx ON pa_colorschema(PA_ColorSchema_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55058,0,'PA_DashboardContent_UU',TO_DATE('2011-03-29 10:58:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_DashboardContent_UU','PA_DashboardContent_UU',TO_DATE('2011-03-29 10:58:27','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60964,55058,0,10,50010,'PA_DashboardContent_UU',TO_DATE('2011-03-29 10:58:27','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_DashboardContent_UU',TO_DATE('2011-03-29 10:58:27','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_DashboardContent ADD PA_DashboardContent_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_DashboardContent_UU_idx ON pa_dashboardcontent(PA_DashboardContent_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55059,0,'PA_DashboardContent_Trl_UU',TO_DATE('2011-03-29 10:58:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_DashboardContent_Trl_UU','PA_DashboardContent_Trl_UU',TO_DATE('2011-03-29 10:58:29','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60965,55059,0,10,53295,'PA_DashboardContent_Trl_UU',TO_DATE('2011-03-29 10:58:29','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_DashboardContent_Trl_UU',TO_DATE('2011-03-29 10:58:29','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_DashboardContent_Trl ADD PA_DashboardContent_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_DashboardContent_Trl_UU_idx ON pa_dashboardcontent_trl(PA_DashboardContent_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55060,0,'PA_Goal_UU',TO_DATE('2011-03-29 10:58:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_Goal_UU','PA_Goal_UU',TO_DATE('2011-03-29 10:58:30','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60966,55060,0,10,440,'PA_Goal_UU',TO_DATE('2011-03-29 10:58:30','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_Goal_UU',TO_DATE('2011-03-29 10:58:30','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_Goal ADD PA_Goal_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_Goal_UU_idx ON pa_goal(PA_Goal_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55061,0,'PA_GoalRestriction_UU',TO_DATE('2011-03-29 10:58:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_GoalRestriction_UU','PA_GoalRestriction_UU',TO_DATE('2011-03-29 10:58:32','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60967,55061,0,10,832,'PA_GoalRestriction_UU',TO_DATE('2011-03-29 10:58:32','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_GoalRestriction_UU',TO_DATE('2011-03-29 10:58:32','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_GoalRestriction ADD PA_GoalRestriction_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_GoalRestriction_UU_idx ON pa_goalrestriction(PA_GoalRestriction_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55062,0,'PA_Hierarchy_UU',TO_DATE('2011-03-29 10:58:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_Hierarchy_UU','PA_Hierarchy_UU',TO_DATE('2011-03-29 10:58:34','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60968,55062,0,10,821,'PA_Hierarchy_UU',TO_DATE('2011-03-29 10:58:34','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_Hierarchy_UU',TO_DATE('2011-03-29 10:58:34','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_Hierarchy ADD PA_Hierarchy_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_Hierarchy_UU_idx ON pa_hierarchy(PA_Hierarchy_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55063,0,'PA_Measure_UU',TO_DATE('2011-03-29 10:58:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_Measure_UU','PA_Measure_UU',TO_DATE('2011-03-29 10:58:36','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60969,55063,0,10,441,'PA_Measure_UU',TO_DATE('2011-03-29 10:58:36','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_Measure_UU',TO_DATE('2011-03-29 10:58:36','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_Measure ADD PA_Measure_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_Measure_UU_idx ON pa_measure(PA_Measure_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55064,0,'PA_MeasureCalc_UU',TO_DATE('2011-03-29 10:58:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_MeasureCalc_UU','PA_MeasureCalc_UU',TO_DATE('2011-03-29 10:58:37','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60970,55064,0,10,442,'PA_MeasureCalc_UU',TO_DATE('2011-03-29 10:58:37','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_MeasureCalc_UU',TO_DATE('2011-03-29 10:58:37','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_MeasureCalc ADD PA_MeasureCalc_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_MeasureCalc_UU_idx ON pa_measurecalc(PA_MeasureCalc_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55065,0,'PA_Ratio_UU',TO_DATE('2011-03-29 10:58:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_Ratio_UU','PA_Ratio_UU',TO_DATE('2011-03-29 10:58:39','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60971,55065,0,10,835,'PA_Ratio_UU',TO_DATE('2011-03-29 10:58:39','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_Ratio_UU',TO_DATE('2011-03-29 10:58:39','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_Ratio ADD PA_Ratio_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_Ratio_UU_idx ON pa_ratio(PA_Ratio_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55066,0,'PA_RatioElement_UU',TO_DATE('2011-03-29 10:58:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_RatioElement_UU','PA_RatioElement_UU',TO_DATE('2011-03-29 10:58:40','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60972,55066,0,10,836,'PA_RatioElement_UU',TO_DATE('2011-03-29 10:58:40','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_RatioElement_UU',TO_DATE('2011-03-29 10:58:40','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_RatioElement ADD PA_RatioElement_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_RatioElement_UU_idx ON pa_ratioelement(PA_RatioElement_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55067,0,'PA_Report_UU',TO_DATE('2011-03-29 10:58:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_Report_UU','PA_Report_UU',TO_DATE('2011-03-29 10:58:41','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60973,55067,0,10,445,'PA_Report_UU',TO_DATE('2011-03-29 10:58:41','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_Report_UU',TO_DATE('2011-03-29 10:58:41','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_Report ADD PA_Report_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_Report_UU_idx ON pa_report(PA_Report_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55068,0,'PA_ReportColumn_UU',TO_DATE('2011-03-29 10:58:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_ReportColumn_UU','PA_ReportColumn_UU',TO_DATE('2011-03-29 10:58:43','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60974,55068,0,10,446,'PA_ReportColumn_UU',TO_DATE('2011-03-29 10:58:43','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_ReportColumn_UU',TO_DATE('2011-03-29 10:58:43','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_ReportColumn ADD PA_ReportColumn_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_ReportColumn_UU_idx ON pa_reportcolumn(PA_ReportColumn_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55069,0,'PA_ReportColumnSet_UU',TO_DATE('2011-03-29 10:58:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_ReportColumnSet_UU','PA_ReportColumnSet_UU',TO_DATE('2011-03-29 10:58:44','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60975,55069,0,10,447,'PA_ReportColumnSet_UU',TO_DATE('2011-03-29 10:58:44','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_ReportColumnSet_UU',TO_DATE('2011-03-29 10:58:44','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_ReportColumnSet ADD PA_ReportColumnSet_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_ReportColumnSet_UU_idx ON pa_reportcolumnset(PA_ReportColumnSet_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55070,0,'PA_ReportCube_UU',TO_DATE('2011-03-29 10:58:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_ReportCube_UU','PA_ReportCube_UU',TO_DATE('2011-03-29 10:58:46','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60976,55070,0,10,53202,'PA_ReportCube_UU',TO_DATE('2011-03-29 10:58:46','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_ReportCube_UU',TO_DATE('2011-03-29 10:58:46','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_ReportCube ADD PA_ReportCube_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_ReportCube_UU_idx ON pa_reportcube(PA_ReportCube_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55071,0,'PA_ReportLine_UU',TO_DATE('2011-03-29 10:58:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_ReportLine_UU','PA_ReportLine_UU',TO_DATE('2011-03-29 10:58:47','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60977,55071,0,10,448,'PA_ReportLine_UU',TO_DATE('2011-03-29 10:58:47','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_ReportLine_UU',TO_DATE('2011-03-29 10:58:47','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_ReportLine ADD PA_ReportLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_ReportLine_UU_idx ON pa_reportline(PA_ReportLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55072,0,'PA_ReportLineSet_UU',TO_DATE('2011-03-29 10:58:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_ReportLineSet_UU','PA_ReportLineSet_UU',TO_DATE('2011-03-29 10:58:49','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60978,55072,0,10,449,'PA_ReportLineSet_UU',TO_DATE('2011-03-29 10:58:49','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_ReportLineSet_UU',TO_DATE('2011-03-29 10:58:49','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_ReportLineSet ADD PA_ReportLineSet_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_ReportLineSet_UU_idx ON pa_reportlineset(PA_ReportLineSet_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55073,0,'PA_ReportSource_UU',TO_DATE('2011-03-29 10:58:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_ReportSource_UU','PA_ReportSource_UU',TO_DATE('2011-03-29 10:58:51','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60979,55073,0,10,450,'PA_ReportSource_UU',TO_DATE('2011-03-29 10:58:51','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_ReportSource_UU',TO_DATE('2011-03-29 10:58:51','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_ReportSource ADD PA_ReportSource_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_ReportSource_UU_idx ON pa_reportsource(PA_ReportSource_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55074,0,'PA_SLA_Criteria_UU',TO_DATE('2011-03-29 10:58:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_SLA_Criteria_UU','PA_SLA_Criteria_UU',TO_DATE('2011-03-29 10:58:53','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60980,55074,0,10,744,'PA_SLA_Criteria_UU',TO_DATE('2011-03-29 10:58:53','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_SLA_Criteria_UU',TO_DATE('2011-03-29 10:58:53','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_SLA_Criteria ADD PA_SLA_Criteria_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_SLA_Criteria_UU_idx ON pa_sla_criteria(PA_SLA_Criteria_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55075,0,'PA_SLA_Goal_UU',TO_DATE('2011-03-29 10:58:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_SLA_Goal_UU','PA_SLA_Goal_UU',TO_DATE('2011-03-29 10:58:57','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60981,55075,0,10,745,'PA_SLA_Goal_UU',TO_DATE('2011-03-29 10:58:57','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_SLA_Goal_UU',TO_DATE('2011-03-29 10:58:57','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_SLA_Goal ADD PA_SLA_Goal_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_SLA_Goal_UU_idx ON pa_sla_goal(PA_SLA_Goal_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55076,0,'PA_SLA_Measure_UU',TO_DATE('2011-03-29 10:58:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_SLA_Measure_UU','PA_SLA_Measure_UU',TO_DATE('2011-03-29 10:58:58','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60982,55076,0,10,743,'PA_SLA_Measure_UU',TO_DATE('2011-03-29 10:58:58','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PA_SLA_Measure_UU',TO_DATE('2011-03-29 10:58:58','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PA_SLA_Measure ADD PA_SLA_Measure_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PA_SLA_Measure_UU_idx ON pa_sla_measure(PA_SLA_Measure_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55077,0,'PP_Cost_Collector_UU',TO_DATE('2011-03-29 10:59:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_Cost_Collector_UU','PP_Cost_Collector_UU',TO_DATE('2011-03-29 10:59:00','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60983,55077,0,10,53035,'PP_Cost_Collector_UU',TO_DATE('2011-03-29 10:59:00','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_Cost_Collector_UU',TO_DATE('2011-03-29 10:59:00','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_Cost_Collector ADD PP_Cost_Collector_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_Cost_Collector_UU_idx ON pp_cost_collector(PP_Cost_Collector_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55078,0,'PP_Cost_CollectorMA_UU',TO_DATE('2011-03-29 10:59:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_Cost_CollectorMA_UU','PP_Cost_CollectorMA_UU',TO_DATE('2011-03-29 10:59:01','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60984,55078,0,10,53062,'PP_Cost_CollectorMA_UU',TO_DATE('2011-03-29 10:59:01','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_Cost_CollectorMA_UU',TO_DATE('2011-03-29 10:59:01','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_Cost_CollectorMA ADD PP_Cost_CollectorMA_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_Cost_CollectorMA_UU_idx ON pp_cost_collectorma(PP_Cost_CollectorMA_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55079,0,'PP_MRP_UU',TO_DATE('2011-03-29 10:59:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_MRP_UU','PP_MRP_UU',TO_DATE('2011-03-29 10:59:03','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60985,55079,0,10,53043,'PP_MRP_UU',TO_DATE('2011-03-29 10:59:03','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_MRP_UU',TO_DATE('2011-03-29 10:59:03','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_MRP ADD PP_MRP_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_MRP_UU_idx ON pp_mrp(PP_MRP_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55080,0,'PP_Order_UU',TO_DATE('2011-03-29 10:59:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_Order_UU','PP_Order_UU',TO_DATE('2011-03-29 10:59:05','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60986,55080,0,10,53027,'PP_Order_UU',TO_DATE('2011-03-29 10:59:05','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_Order_UU',TO_DATE('2011-03-29 10:59:05','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_Order ADD PP_Order_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_Order_UU_idx ON pp_order(PP_Order_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55081,0,'PP_Order_BOM_UU',TO_DATE('2011-03-29 10:59:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_Order_BOM_UU','PP_Order_BOM_UU',TO_DATE('2011-03-29 10:59:06','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60987,55081,0,10,53026,'PP_Order_BOM_UU',TO_DATE('2011-03-29 10:59:06','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_Order_BOM_UU',TO_DATE('2011-03-29 10:59:06','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_Order_BOM ADD PP_Order_BOM_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_Order_BOM_UU_idx ON pp_order_bom(PP_Order_BOM_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55082,0,'PP_Order_BOMLine_UU',TO_DATE('2011-03-29 10:59:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_Order_BOMLine_UU','PP_Order_BOMLine_UU',TO_DATE('2011-03-29 10:59:08','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60988,55082,0,10,53025,'PP_Order_BOMLine_UU',TO_DATE('2011-03-29 10:59:08','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_Order_BOMLine_UU',TO_DATE('2011-03-29 10:59:08','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_Order_BOMLine ADD PP_Order_BOMLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_Order_BOMLine_UU_idx ON pp_order_bomline(PP_Order_BOMLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55083,0,'PP_Order_BOMLine_Trl_UU',TO_DATE('2011-03-29 10:59:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_Order_BOMLine_Trl_UU','PP_Order_BOMLine_Trl_UU',TO_DATE('2011-03-29 10:59:10','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60989,55083,0,10,53195,'PP_Order_BOMLine_Trl_UU',TO_DATE('2011-03-29 10:59:10','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_Order_BOMLine_Trl_UU',TO_DATE('2011-03-29 10:59:10','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_Order_BOMLine_Trl ADD PP_Order_BOMLine_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_Order_BOMLine_Trl_UU_idx ON pp_order_bomline_trl(PP_Order_BOMLine_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55084,0,'PP_Order_BOM_Trl_UU',TO_DATE('2011-03-29 10:59:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_Order_BOM_Trl_UU','PP_Order_BOM_Trl_UU',TO_DATE('2011-03-29 10:59:12','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60990,55084,0,10,53194,'PP_Order_BOM_Trl_UU',TO_DATE('2011-03-29 10:59:12','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_Order_BOM_Trl_UU',TO_DATE('2011-03-29 10:59:12','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_Order_BOM_Trl ADD PP_Order_BOM_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_Order_BOM_Trl_UU_idx ON pp_order_bom_trl(PP_Order_BOM_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55085,0,'PP_Order_Cost_UU',TO_DATE('2011-03-29 10:59:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_Order_Cost_UU','PP_Order_Cost_UU',TO_DATE('2011-03-29 10:59:13','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60991,55085,0,10,53024,'PP_Order_Cost_UU',TO_DATE('2011-03-29 10:59:13','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_Order_Cost_UU',TO_DATE('2011-03-29 10:59:13','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_Order_Cost ADD PP_Order_Cost_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_Order_Cost_UU_idx ON pp_order_cost(PP_Order_Cost_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55086,0,'PP_Order_Node_UU',TO_DATE('2011-03-29 10:59:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_Order_Node_UU','PP_Order_Node_UU',TO_DATE('2011-03-29 10:59:15','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60992,55086,0,10,53022,'PP_Order_Node_UU',TO_DATE('2011-03-29 10:59:15','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_Order_Node_UU',TO_DATE('2011-03-29 10:59:15','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_Order_Node ADD PP_Order_Node_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_Order_Node_UU_idx ON pp_order_node(PP_Order_Node_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55087,0,'PP_Order_Node_Asset_UU',TO_DATE('2011-03-29 10:59:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_Order_Node_Asset_UU','PP_Order_Node_Asset_UU',TO_DATE('2011-03-29 10:59:16','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60993,55087,0,10,53031,'PP_Order_Node_Asset_UU',TO_DATE('2011-03-29 10:59:16','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_Order_Node_Asset_UU',TO_DATE('2011-03-29 10:59:16','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_Order_Node_Asset ADD PP_Order_Node_Asset_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_Order_Node_Asset_UU_idx ON pp_order_node_asset(PP_Order_Node_Asset_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55088,0,'PP_Order_NodeNext_UU',TO_DATE('2011-03-29 10:59:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_Order_NodeNext_UU','PP_Order_NodeNext_UU',TO_DATE('2011-03-29 10:59:18','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60994,55088,0,10,53023,'PP_Order_NodeNext_UU',TO_DATE('2011-03-29 10:59:18','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_Order_NodeNext_UU',TO_DATE('2011-03-29 10:59:18','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_Order_NodeNext ADD PP_Order_NodeNext_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_Order_NodeNext_UU_idx ON pp_order_nodenext(PP_Order_NodeNext_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55089,0,'PP_Order_Node_Product_UU',TO_DATE('2011-03-29 10:59:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_Order_Node_Product_UU','PP_Order_Node_Product_UU',TO_DATE('2011-03-29 10:59:19','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60995,55089,0,10,53030,'PP_Order_Node_Product_UU',TO_DATE('2011-03-29 10:59:19','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_Order_Node_Product_UU',TO_DATE('2011-03-29 10:59:19','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_Order_Node_Product ADD PP_Order_Node_Product_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_Order_Node_Product_UU_idx ON pp_order_node_product(PP_Order_Node_Product_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55090,0,'PP_Order_Node_Trl_UU',TO_DATE('2011-03-29 10:59:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_Order_Node_Trl_UU','PP_Order_Node_Trl_UU',TO_DATE('2011-03-29 10:59:21','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60996,55090,0,10,53190,'PP_Order_Node_Trl_UU',TO_DATE('2011-03-29 10:59:21','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_Order_Node_Trl_UU',TO_DATE('2011-03-29 10:59:21','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_Order_Node_Trl ADD PP_Order_Node_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_Order_Node_Trl_UU_idx ON pp_order_node_trl(PP_Order_Node_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55091,0,'PP_Order_Workflow_UU',TO_DATE('2011-03-29 10:59:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_Order_Workflow_UU','PP_Order_Workflow_UU',TO_DATE('2011-03-29 10:59:22','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60997,55091,0,10,53029,'PP_Order_Workflow_UU',TO_DATE('2011-03-29 10:59:22','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_Order_Workflow_UU',TO_DATE('2011-03-29 10:59:22','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_Order_Workflow ADD PP_Order_Workflow_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_Order_Workflow_UU_idx ON pp_order_workflow(PP_Order_Workflow_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55092,0,'PP_Order_Workflow_Trl_UU',TO_DATE('2011-03-29 10:59:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_Order_Workflow_Trl_UU','PP_Order_Workflow_Trl_UU',TO_DATE('2011-03-29 10:59:24','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60998,55092,0,10,53189,'PP_Order_Workflow_Trl_UU',TO_DATE('2011-03-29 10:59:24','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_Order_Workflow_Trl_UU',TO_DATE('2011-03-29 10:59:24','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_Order_Workflow_Trl ADD PP_Order_Workflow_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_Order_Workflow_Trl_UU_idx ON pp_order_workflow_trl(PP_Order_Workflow_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55093,0,'PP_Product_BOM_UU',TO_DATE('2011-03-29 10:59:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_Product_BOM_UU','PP_Product_BOM_UU',TO_DATE('2011-03-29 10:59:26','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,60999,55093,0,10,53018,'PP_Product_BOM_UU',TO_DATE('2011-03-29 10:59:26','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_Product_BOM_UU',TO_DATE('2011-03-29 10:59:26','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_Product_BOM ADD PP_Product_BOM_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_Product_BOM_UU_idx ON pp_product_bom(PP_Product_BOM_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55094,0,'PP_Product_BOMLine_UU',TO_DATE('2011-03-29 10:59:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_Product_BOMLine_UU','PP_Product_BOMLine_UU',TO_DATE('2011-03-29 10:59:27','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61000,55094,0,10,53019,'PP_Product_BOMLine_UU',TO_DATE('2011-03-29 10:59:27','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_Product_BOMLine_UU',TO_DATE('2011-03-29 10:59:27','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_Product_BOMLine ADD PP_Product_BOMLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_Product_BOMLine_UU_idx ON pp_product_bomline(PP_Product_BOMLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55095,0,'PP_Product_BOMLine_Trl_UU',TO_DATE('2011-03-29 10:59:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_Product_BOMLine_Trl_UU','PP_Product_BOMLine_Trl_UU',TO_DATE('2011-03-29 10:59:29','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61001,55095,0,10,53193,'PP_Product_BOMLine_Trl_UU',TO_DATE('2011-03-29 10:59:29','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_Product_BOMLine_Trl_UU',TO_DATE('2011-03-29 10:59:29','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_Product_BOMLine_Trl ADD PP_Product_BOMLine_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_Product_BOMLine_Trl_UU_idx ON pp_product_bomline_trl(PP_Product_BOMLine_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55096,0,'PP_Product_BOM_Trl_UU',TO_DATE('2011-03-29 10:59:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_Product_BOM_Trl_UU','PP_Product_BOM_Trl_UU',TO_DATE('2011-03-29 10:59:31','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61002,55096,0,10,53191,'PP_Product_BOM_Trl_UU',TO_DATE('2011-03-29 10:59:31','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_Product_BOM_Trl_UU',TO_DATE('2011-03-29 10:59:31','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_Product_BOM_Trl ADD PP_Product_BOM_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_Product_BOM_Trl_UU_idx ON pp_product_bom_trl(PP_Product_BOM_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55097,0,'PP_Product_Planning_UU',TO_DATE('2011-03-29 10:59:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_Product_Planning_UU','PP_Product_Planning_UU',TO_DATE('2011-03-29 10:59:32','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61003,55097,0,10,53020,'PP_Product_Planning_UU',TO_DATE('2011-03-29 10:59:32','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_Product_Planning_UU',TO_DATE('2011-03-29 10:59:32','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_Product_Planning ADD PP_Product_Planning_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_Product_Planning_UU_idx ON pp_product_planning(PP_Product_Planning_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55098,0,'PP_WF_Node_Asset_UU',TO_DATE('2011-03-29 10:59:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_WF_Node_Asset_UU','PP_WF_Node_Asset_UU',TO_DATE('2011-03-29 10:59:34','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61004,55098,0,10,53017,'PP_WF_Node_Asset_UU',TO_DATE('2011-03-29 10:59:34','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_WF_Node_Asset_UU',TO_DATE('2011-03-29 10:59:34','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_WF_Node_Asset ADD PP_WF_Node_Asset_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_WF_Node_Asset_UU_idx ON pp_wf_node_asset(PP_WF_Node_Asset_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55099,0,'PP_WF_Node_Product_UU',TO_DATE('2011-03-29 10:59:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PP_WF_Node_Product_UU','PP_WF_Node_Product_UU',TO_DATE('2011-03-29 10:59:36','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61005,55099,0,10,53016,'PP_WF_Node_Product_UU',TO_DATE('2011-03-29 10:59:36','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','PP_WF_Node_Product_UU',TO_DATE('2011-03-29 10:59:36','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE PP_WF_Node_Product ADD PP_WF_Node_Product_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX PP_WF_Node_Product_UU_idx ON pp_wf_node_product(PP_WF_Node_Product_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55100,0,'QM_Specification_UU',TO_DATE('2011-03-29 10:59:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','QM_Specification_UU','QM_Specification_UU',TO_DATE('2011-03-29 10:59:37','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61006,55100,0,10,53040,'QM_Specification_UU',TO_DATE('2011-03-29 10:59:37','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','QM_Specification_UU',TO_DATE('2011-03-29 10:59:37','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE QM_Specification ADD QM_Specification_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX QM_Specification_UU_idx ON qm_specification(QM_Specification_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55101,0,'QM_SpecificationLine_UU',TO_DATE('2011-03-29 10:59:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','QM_SpecificationLine_UU','QM_SpecificationLine_UU',TO_DATE('2011-03-29 10:59:39','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61007,55101,0,10,53041,'QM_SpecificationLine_UU',TO_DATE('2011-03-29 10:59:39','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','QM_SpecificationLine_UU',TO_DATE('2011-03-29 10:59:39','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE QM_SpecificationLine ADD QM_SpecificationLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX QM_SpecificationLine_UU_idx ON qm_specificationline(QM_SpecificationLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55102,0,'R_Category_UU',TO_DATE('2011-03-29 10:59:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_Category_UU','R_Category_UU',TO_DATE('2011-03-29 10:59:40','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61008,55102,0,10,772,'R_Category_UU',TO_DATE('2011-03-29 10:59:40','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_Category_UU',TO_DATE('2011-03-29 10:59:40','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_Category ADD R_Category_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_Category_UU_idx ON r_category(R_Category_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55103,0,'R_CategoryUpdates_UU',TO_DATE('2011-03-29 10:59:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_CategoryUpdates_UU','R_CategoryUpdates_UU',TO_DATE('2011-03-29 10:59:42','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61009,55103,0,10,785,'R_CategoryUpdates_UU',TO_DATE('2011-03-29 10:59:42','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_CategoryUpdates_UU',TO_DATE('2011-03-29 10:59:42','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_CategoryUpdates ADD R_CategoryUpdates_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_CategoryUpdates_UU_idx ON r_categoryupdates(R_CategoryUpdates_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55104,0,'R_ContactInterest_UU',TO_DATE('2011-03-29 10:59:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_ContactInterest_UU','R_ContactInterest_UU',TO_DATE('2011-03-29 10:59:47','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61010,55104,0,10,528,'R_ContactInterest_UU',TO_DATE('2011-03-29 10:59:47','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_ContactInterest_UU',TO_DATE('2011-03-29 10:59:47','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_ContactInterest ADD R_ContactInterest_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_ContactInterest_UU_idx ON r_contactinterest(R_ContactInterest_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55105,0,'R_Group_UU',TO_DATE('2011-03-29 10:59:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_Group_UU','R_Group_UU',TO_DATE('2011-03-29 10:59:49','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61011,55105,0,10,773,'R_Group_UU',TO_DATE('2011-03-29 10:59:49','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_Group_UU',TO_DATE('2011-03-29 10:59:49','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_Group ADD R_Group_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_Group_UU_idx ON r_group(R_Group_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55106,0,'R_GroupUpdates_UU',TO_DATE('2011-03-29 10:59:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_GroupUpdates_UU','R_GroupUpdates_UU',TO_DATE('2011-03-29 10:59:50','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61012,55106,0,10,786,'R_GroupUpdates_UU',TO_DATE('2011-03-29 10:59:50','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_GroupUpdates_UU',TO_DATE('2011-03-29 10:59:50','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_GroupUpdates ADD R_GroupUpdates_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_GroupUpdates_UU_idx ON r_groupupdates(R_GroupUpdates_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55107,0,'R_InterestArea_UU',TO_DATE('2011-03-29 10:59:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_InterestArea_UU','R_InterestArea_UU',TO_DATE('2011-03-29 10:59:52','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61013,55107,0,10,530,'R_InterestArea_UU',TO_DATE('2011-03-29 10:59:52','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_InterestArea_UU',TO_DATE('2011-03-29 10:59:52','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_InterestArea ADD R_InterestArea_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_InterestArea_UU_idx ON r_interestarea(R_InterestArea_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55108,0,'R_IssueKnown_UU',TO_DATE('2011-03-29 10:59:54','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_IssueKnown_UU','R_IssueKnown_UU',TO_DATE('2011-03-29 10:59:54','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61014,55108,0,10,839,'R_IssueKnown_UU',TO_DATE('2011-03-29 10:59:54','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_IssueKnown_UU',TO_DATE('2011-03-29 10:59:54','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_IssueKnown ADD R_IssueKnown_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_IssueKnown_UU_idx ON r_issueknown(R_IssueKnown_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55109,0,'R_IssueProject_UU',TO_DATE('2011-03-29 10:59:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_IssueProject_UU','R_IssueProject_UU',TO_DATE('2011-03-29 10:59:56','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61015,55109,0,10,842,'R_IssueProject_UU',TO_DATE('2011-03-29 10:59:56','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_IssueProject_UU',TO_DATE('2011-03-29 10:59:56','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_IssueProject ADD R_IssueProject_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_IssueProject_UU_idx ON r_issueproject(R_IssueProject_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55110,0,'R_IssueRecommendation_UU',TO_DATE('2011-03-29 11:00:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_IssueRecommendation_UU','R_IssueRecommendation_UU',TO_DATE('2011-03-29 11:00:02','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61016,55110,0,10,837,'R_IssueRecommendation_UU',TO_DATE('2011-03-29 11:00:02','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_IssueRecommendation_UU',TO_DATE('2011-03-29 11:00:02','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_IssueRecommendation ADD R_IssueRecommendation_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_IssueRecommendation_UU_idx ON r_issuerecommendation(R_IssueRecommendation_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55111,0,'R_IssueStatus_UU',TO_DATE('2011-03-29 11:00:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_IssueStatus_UU','R_IssueStatus_UU',TO_DATE('2011-03-29 11:00:04','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61017,55111,0,10,838,'R_IssueStatus_UU',TO_DATE('2011-03-29 11:00:04','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_IssueStatus_UU',TO_DATE('2011-03-29 11:00:04','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_IssueStatus ADD R_IssueStatus_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_IssueStatus_UU_idx ON r_issuestatus(R_IssueStatus_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55112,0,'R_IssueSystem_UU',TO_DATE('2011-03-29 11:00:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_IssueSystem_UU','R_IssueSystem_UU',TO_DATE('2011-03-29 11:00:06','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61018,55112,0,10,843,'R_IssueSystem_UU',TO_DATE('2011-03-29 11:00:06','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_IssueSystem_UU',TO_DATE('2011-03-29 11:00:06','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_IssueSystem ADD R_IssueSystem_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_IssueSystem_UU_idx ON r_issuesystem(R_IssueSystem_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55113,0,'R_IssueUser_UU',TO_DATE('2011-03-29 11:00:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_IssueUser_UU','R_IssueUser_UU',TO_DATE('2011-03-29 11:00:08','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61019,55113,0,10,841,'R_IssueUser_UU',TO_DATE('2011-03-29 11:00:08','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_IssueUser_UU',TO_DATE('2011-03-29 11:00:08','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_IssueUser ADD R_IssueUser_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_IssueUser_UU_idx ON r_issueuser(R_IssueUser_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55114,0,'R_MailText_UU',TO_DATE('2011-03-29 11:00:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_MailText_UU','R_MailText_UU',TO_DATE('2011-03-29 11:00:10','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61020,55114,0,10,416,'R_MailText_UU',TO_DATE('2011-03-29 11:00:10','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_MailText_UU',TO_DATE('2011-03-29 11:00:10','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_MailText ADD R_MailText_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_MailText_UU_idx ON r_mailtext(R_MailText_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55115,0,'R_MailText_Trl_UU',TO_DATE('2011-03-29 11:00:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_MailText_Trl_UU','R_MailText_Trl_UU',TO_DATE('2011-03-29 11:00:11','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61021,55115,0,10,826,'R_MailText_Trl_UU',TO_DATE('2011-03-29 11:00:11','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_MailText_Trl_UU',TO_DATE('2011-03-29 11:00:11','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_MailText_Trl ADD R_MailText_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_MailText_Trl_UU_idx ON r_mailtext_trl(R_MailText_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55116,0,'R_Request_UU',TO_DATE('2011-03-29 11:00:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_Request_UU','R_Request_UU',TO_DATE('2011-03-29 11:00:16','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61022,55116,0,10,417,'R_Request_UU',TO_DATE('2011-03-29 11:00:16','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_Request_UU',TO_DATE('2011-03-29 11:00:16','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_Request ADD R_Request_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_Request_UU_idx ON r_request(R_Request_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55117,0,'R_RequestAction_UU',TO_DATE('2011-03-29 11:00:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_RequestAction_UU','R_RequestAction_UU',TO_DATE('2011-03-29 11:00:18','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61023,55117,0,10,418,'R_RequestAction_UU',TO_DATE('2011-03-29 11:00:18','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_RequestAction_UU',TO_DATE('2011-03-29 11:00:18','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_RequestAction ADD R_RequestAction_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_RequestAction_UU_idx ON r_requestaction(R_RequestAction_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55118,0,'R_RequestProcessor_UU',TO_DATE('2011-03-29 11:00:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_RequestProcessor_UU','R_RequestProcessor_UU',TO_DATE('2011-03-29 11:00:19','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61024,55118,0,10,420,'R_RequestProcessor_UU',TO_DATE('2011-03-29 11:00:19','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_RequestProcessor_UU',TO_DATE('2011-03-29 11:00:19','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_RequestProcessor ADD R_RequestProcessor_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_RequestProcessor_UU_idx ON r_requestprocessor(R_RequestProcessor_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55119,0,'R_RequestProcessorLog_UU',TO_DATE('2011-03-29 11:00:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_RequestProcessorLog_UU','R_RequestProcessorLog_UU',TO_DATE('2011-03-29 11:00:21','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61025,55119,0,10,659,'R_RequestProcessorLog_UU',TO_DATE('2011-03-29 11:00:21','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_RequestProcessorLog_UU',TO_DATE('2011-03-29 11:00:21','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_RequestProcessorLog ADD R_RequestProcessorLog_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_RequestProcessorLog_UU_idx ON r_requestprocessorlog(R_RequestProcessorLog_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55120,0,'R_RequestProcessor_Route_UU',TO_DATE('2011-03-29 11:00:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_RequestProcessor_Route_UU','R_RequestProcessor_Route_UU',TO_DATE('2011-03-29 11:00:22','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61026,55120,0,10,474,'R_RequestProcessor_Route_UU',TO_DATE('2011-03-29 11:00:22','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_RequestProcessor_Route_UU',TO_DATE('2011-03-29 11:00:22','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_RequestProcessor_Route ADD R_RequestProcessor_Route_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_RequestProcessor_Rout_UU_idx ON r_requestprocessor_route(R_RequestProcessor_Route_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55121,0,'R_RequestType_UU',TO_DATE('2011-03-29 11:00:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_RequestType_UU','R_RequestType_UU',TO_DATE('2011-03-29 11:00:24','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61027,55121,0,10,529,'R_RequestType_UU',TO_DATE('2011-03-29 11:00:24','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_RequestType_UU',TO_DATE('2011-03-29 11:00:24','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_RequestType ADD R_RequestType_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_RequestType_UU_idx ON r_requesttype(R_RequestType_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55122,0,'R_RequestTypeUpdates_UU',TO_DATE('2011-03-29 11:00:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_RequestTypeUpdates_UU','R_RequestTypeUpdates_UU',TO_DATE('2011-03-29 11:00:29','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61028,55122,0,10,784,'R_RequestTypeUpdates_UU',TO_DATE('2011-03-29 11:00:29','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_RequestTypeUpdates_UU',TO_DATE('2011-03-29 11:00:29','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_RequestTypeUpdates ADD R_RequestTypeUpdates_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_RequestTypeUpdates_UU_idx ON r_requesttypeupdates(R_RequestTypeUpdates_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55123,0,'R_RequestUpdate_UU',TO_DATE('2011-03-29 11:00:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_RequestUpdate_UU','R_RequestUpdate_UU',TO_DATE('2011-03-29 11:00:30','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61029,55123,0,10,802,'R_RequestUpdate_UU',TO_DATE('2011-03-29 11:00:30','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_RequestUpdate_UU',TO_DATE('2011-03-29 11:00:30','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_RequestUpdate ADD R_RequestUpdate_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_RequestUpdate_UU_idx ON r_requestupdate(R_RequestUpdate_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55124,0,'R_RequestUpdates_UU',TO_DATE('2011-03-29 11:00:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_RequestUpdates_UU','R_RequestUpdates_UU',TO_DATE('2011-03-29 11:00:32','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61030,55124,0,10,783,'R_RequestUpdates_UU',TO_DATE('2011-03-29 11:00:32','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_RequestUpdates_UU',TO_DATE('2011-03-29 11:00:32','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_RequestUpdates ADD R_RequestUpdates_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_RequestUpdates_UU_idx ON r_requestupdates(R_RequestUpdates_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55125,0,'R_Resolution_UU',TO_DATE('2011-03-29 11:00:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_Resolution_UU','R_Resolution_UU',TO_DATE('2011-03-29 11:00:33','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61031,55125,0,10,774,'R_Resolution_UU',TO_DATE('2011-03-29 11:00:33','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_Resolution_UU',TO_DATE('2011-03-29 11:00:33','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_Resolution ADD R_Resolution_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_Resolution_UU_idx ON r_resolution(R_Resolution_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55126,0,'R_StandardResponse_UU',TO_DATE('2011-03-29 11:00:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_StandardResponse_UU','R_StandardResponse_UU',TO_DATE('2011-03-29 11:00:35','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61032,55126,0,10,775,'R_StandardResponse_UU',TO_DATE('2011-03-29 11:00:35','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_StandardResponse_UU',TO_DATE('2011-03-29 11:00:35','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_StandardResponse ADD R_StandardResponse_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_StandardResponse_UU_idx ON r_standardresponse(R_StandardResponse_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55127,0,'R_Status_UU',TO_DATE('2011-03-29 11:00:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_Status_UU','R_Status_UU',TO_DATE('2011-03-29 11:00:37','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61033,55127,0,10,776,'R_Status_UU',TO_DATE('2011-03-29 11:00:37','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_Status_UU',TO_DATE('2011-03-29 11:00:37','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_Status ADD R_Status_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_Status_UU_idx ON r_status(R_Status_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55128,0,'R_StatusCategory_UU',TO_DATE('2011-03-29 11:00:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','R_StatusCategory_UU','R_StatusCategory_UU',TO_DATE('2011-03-29 11:00:42','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61034,55128,0,10,844,'R_StatusCategory_UU',TO_DATE('2011-03-29 11:00:42','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','R_StatusCategory_UU',TO_DATE('2011-03-29 11:00:42','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE R_StatusCategory ADD R_StatusCategory_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX R_StatusCategory_UU_idx ON r_statuscategory(R_StatusCategory_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55129,0,'S_ExpenseType_UU',TO_DATE('2011-03-29 11:00:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','S_ExpenseType_UU','S_ExpenseType_UU',TO_DATE('2011-03-29 11:00:43','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61035,55129,0,10,481,'S_ExpenseType_UU',TO_DATE('2011-03-29 11:00:43','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','S_ExpenseType_UU',TO_DATE('2011-03-29 11:00:43','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE S_ExpenseType ADD S_ExpenseType_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX S_ExpenseType_UU_idx ON s_expensetype(S_ExpenseType_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55130,0,'S_Resource_UU',TO_DATE('2011-03-29 11:00:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','S_Resource_UU','S_Resource_UU',TO_DATE('2011-03-29 11:00:45','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61036,55130,0,10,487,'S_Resource_UU',TO_DATE('2011-03-29 11:00:45','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','S_Resource_UU',TO_DATE('2011-03-29 11:00:45','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE S_Resource ADD S_Resource_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX S_Resource_UU_idx ON s_resource(S_Resource_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55131,0,'S_ResourceAssignment_UU',TO_DATE('2011-03-29 11:00:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','S_ResourceAssignment_UU','S_ResourceAssignment_UU',TO_DATE('2011-03-29 11:00:48','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61037,55131,0,10,485,'S_ResourceAssignment_UU',TO_DATE('2011-03-29 11:00:48','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','S_ResourceAssignment_UU',TO_DATE('2011-03-29 11:00:48','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE S_ResourceAssignment ADD S_ResourceAssignment_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX S_ResourceAssignment_UU_idx ON s_resourceassignment(S_ResourceAssignment_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55132,0,'S_ResourceType_UU',TO_DATE('2011-03-29 11:00:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','S_ResourceType_UU','S_ResourceType_UU',TO_DATE('2011-03-29 11:00:49','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61038,55132,0,10,480,'S_ResourceType_UU',TO_DATE('2011-03-29 11:00:49','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','S_ResourceType_UU',TO_DATE('2011-03-29 11:00:49','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE S_ResourceType ADD S_ResourceType_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX S_ResourceType_UU_idx ON s_resourcetype(S_ResourceType_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55133,0,'S_ResourceUnAvailable_UU',TO_DATE('2011-03-29 11:00:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','S_ResourceUnAvailable_UU','S_ResourceUnAvailable_UU',TO_DATE('2011-03-29 11:00:50','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61039,55133,0,10,482,'S_ResourceUnAvailable_UU',TO_DATE('2011-03-29 11:00:50','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','S_ResourceUnAvailable_UU',TO_DATE('2011-03-29 11:00:50','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE S_ResourceUnAvailable ADD S_ResourceUnAvailable_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX S_ResourceUnAvailable_UU_idx ON s_resourceunavailable(S_ResourceUnAvailable_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55134,0,'S_TimeExpense_UU',TO_DATE('2011-03-29 11:00:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','S_TimeExpense_UU','S_TimeExpense_UU',TO_DATE('2011-03-29 11:00:52','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61040,55134,0,10,486,'S_TimeExpense_UU',TO_DATE('2011-03-29 11:00:52','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','S_TimeExpense_UU',TO_DATE('2011-03-29 11:00:52','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE S_TimeExpense ADD S_TimeExpense_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX S_TimeExpense_UU_idx ON s_timeexpense(S_TimeExpense_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55135,0,'S_TimeExpenseLine_UU',TO_DATE('2011-03-29 11:00:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','S_TimeExpenseLine_UU','S_TimeExpenseLine_UU',TO_DATE('2011-03-29 11:00:53','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61041,55135,0,10,488,'S_TimeExpenseLine_UU',TO_DATE('2011-03-29 11:00:53','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','S_TimeExpenseLine_UU',TO_DATE('2011-03-29 11:00:53','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE S_TimeExpenseLine ADD S_TimeExpenseLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX S_TimeExpenseLine_UU_idx ON s_timeexpenseline(S_TimeExpenseLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55136,0,'S_TimeType_UU',TO_DATE('2011-03-29 11:00:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','S_TimeType_UU','S_TimeType_UU',TO_DATE('2011-03-29 11:00:55','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61042,55136,0,10,581,'S_TimeType_UU',TO_DATE('2011-03-29 11:00:55','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','S_TimeType_UU',TO_DATE('2011-03-29 11:00:55','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE S_TimeType ADD S_TimeType_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX S_TimeType_UU_idx ON s_timetype(S_TimeType_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55137,0,'S_Training_UU',TO_DATE('2011-03-29 11:00:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','S_Training_UU','S_Training_UU',TO_DATE('2011-03-29 11:00:56','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61043,55137,0,10,538,'S_Training_UU',TO_DATE('2011-03-29 11:00:56','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','S_Training_UU',TO_DATE('2011-03-29 11:00:56','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE S_Training ADD S_Training_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX S_Training_UU_idx ON s_training(S_Training_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55138,0,'S_Training_Class_UU',TO_DATE('2011-03-29 11:00:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','S_Training_Class_UU','S_Training_Class_UU',TO_DATE('2011-03-29 11:00:57','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61044,55138,0,10,537,'S_Training_Class_UU',TO_DATE('2011-03-29 11:00:57','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','S_Training_Class_UU',TO_DATE('2011-03-29 11:00:57','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE S_Training_Class ADD S_Training_Class_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX S_Training_Class_UU_idx ON s_training_class(S_Training_Class_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55139,0,'T_Aging_UU',TO_DATE('2011-03-29 11:00:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','T_Aging_UU','T_Aging_UU',TO_DATE('2011-03-29 11:00:59','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61045,55139,0,10,631,'T_Aging_UU',TO_DATE('2011-03-29 11:00:59','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','T_Aging_UU',TO_DATE('2011-03-29 11:00:59','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE T_Aging ADD T_Aging_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX T_Aging_UU_idx ON t_aging(T_Aging_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55140,0,'T_BOMLine_UU',TO_DATE('2011-03-29 11:01:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','T_BOMLine_UU','T_BOMLine_UU',TO_DATE('2011-03-29 11:01:00','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61046,55140,0,10,53045,'T_BOMLine_UU',TO_DATE('2011-03-29 11:01:00','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','T_BOMLine_UU',TO_DATE('2011-03-29 11:01:00','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE T_BOMLine ADD T_BOMLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX T_BOMLine_UU_idx ON t_bomline(T_BOMLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55141,0,'T_CashFlow_UU',TO_DATE('2011-03-29 11:01:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','T_CashFlow_UU','T_CashFlow_UU',TO_DATE('2011-03-29 11:01:02','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61047,55141,0,10,53299,'T_CashFlow_UU',TO_DATE('2011-03-29 11:01:02','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','T_CashFlow_UU',TO_DATE('2011-03-29 11:01:02','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE T_CashFlow ADD T_CashFlow_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX T_CashFlow_UU_idx ON t_cashflow(T_CashFlow_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55142,0,'T_DistributionRunDetail_UU',TO_DATE('2011-03-29 11:01:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','T_DistributionRunDetail_UU','T_DistributionRunDetail_UU',TO_DATE('2011-03-29 11:01:03','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61048,55142,0,10,714,'T_DistributionRunDetail_UU',TO_DATE('2011-03-29 11:01:03','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','T_DistributionRunDetail_UU',TO_DATE('2011-03-29 11:01:03','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE T_DistributionRunDetail ADD T_DistributionRunDetail_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX T_DistributionRunDetail_UU_idx ON t_distributionrundetail(T_DistributionRunDetail_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55143,0,'Test_UU',TO_DATE('2011-03-29 11:01:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Test_UU','Test_UU',TO_DATE('2011-03-29 11:01:05','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61049,55143,0,10,135,'Test_UU',TO_DATE('2011-03-29 11:01:05','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','Test_UU',TO_DATE('2011-03-29 11:01:05','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE Test ADD Test_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX Test_UU_idx ON test(Test_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55144,0,'T_InventoryValue_UU',TO_DATE('2011-03-29 11:01:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','T_InventoryValue_UU','T_InventoryValue_UU',TO_DATE('2011-03-29 11:01:07','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61050,55144,0,10,478,'T_InventoryValue_UU',TO_DATE('2011-03-29 11:01:07','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','T_InventoryValue_UU',TO_DATE('2011-03-29 11:01:07','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE T_InventoryValue ADD T_InventoryValue_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX T_InventoryValue_UU_idx ON t_inventoryvalue(T_InventoryValue_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55145,0,'T_InvoiceGL_UU',TO_DATE('2011-03-29 11:01:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','T_InvoiceGL_UU','T_InvoiceGL_UU',TO_DATE('2011-03-29 11:01:08','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61051,55145,0,10,803,'T_InvoiceGL_UU',TO_DATE('2011-03-29 11:01:08','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','T_InvoiceGL_UU',TO_DATE('2011-03-29 11:01:08','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE T_InvoiceGL ADD T_InvoiceGL_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX T_InvoiceGL_UU_idx ON t_invoicegl(T_InvoiceGL_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55146,0,'T_MRP_CRP_UU',TO_DATE('2011-03-29 11:01:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','T_MRP_CRP_UU','T_MRP_CRP_UU',TO_DATE('2011-03-29 11:01:11','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61052,55146,0,10,53044,'T_MRP_CRP_UU',TO_DATE('2011-03-29 11:01:11','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','T_MRP_CRP_UU',TO_DATE('2011-03-29 11:01:11','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE T_MRP_CRP ADD T_MRP_CRP_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX T_MRP_CRP_UU_idx ON t_mrp_crp(T_MRP_CRP_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55147,0,'T_Replenish_UU',TO_DATE('2011-03-29 11:01:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','T_Replenish_UU','T_Replenish_UU',TO_DATE('2011-03-29 11:01:12','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61053,55147,0,10,364,'T_Replenish_UU',TO_DATE('2011-03-29 11:01:12','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','T_Replenish_UU',TO_DATE('2011-03-29 11:01:12','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE T_Replenish ADD T_Replenish_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX T_Replenish_UU_idx ON t_replenish(T_Replenish_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55148,0,'T_Report_UU',TO_DATE('2011-03-29 11:01:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','T_Report_UU','T_Report_UU',TO_DATE('2011-03-29 11:01:14','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61054,55148,0,10,544,'T_Report_UU',TO_DATE('2011-03-29 11:01:14','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','T_Report_UU',TO_DATE('2011-03-29 11:01:14','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE T_Report ADD T_Report_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX T_Report_UU_idx ON t_report(T_Report_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55149,0,'T_ReportStatement_UU',TO_DATE('2011-03-29 11:01:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','T_ReportStatement_UU','T_ReportStatement_UU',TO_DATE('2011-03-29 11:01:16','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61055,55149,0,10,545,'T_ReportStatement_UU',TO_DATE('2011-03-29 11:01:16','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','T_ReportStatement_UU',TO_DATE('2011-03-29 11:01:16','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE T_ReportStatement ADD T_ReportStatement_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX T_ReportStatement_UU_idx ON t_reportstatement(T_ReportStatement_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55150,0,'T_Transaction_UU',TO_DATE('2011-03-29 11:01:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','T_Transaction_UU','T_Transaction_UU',TO_DATE('2011-03-29 11:01:18','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61056,55150,0,10,758,'T_Transaction_UU',TO_DATE('2011-03-29 11:01:18','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','T_Transaction_UU',TO_DATE('2011-03-29 11:01:18','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE T_Transaction ADD T_Transaction_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX T_Transaction_UU_idx ON t_transaction(T_Transaction_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55151,0,'U_BlackListCheque_UU',TO_DATE('2011-03-29 11:01:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','U_BlackListCheque_UU','U_BlackListCheque_UU',TO_DATE('2011-03-29 11:01:20','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61057,55151,0,10,52000,'U_BlackListCheque_UU',TO_DATE('2011-03-29 11:01:20','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','U_BlackListCheque_UU',TO_DATE('2011-03-29 11:01:20','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE U_BlackListCheque ADD U_BlackListCheque_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX U_BlackListCheque_UU_idx ON u_blacklistcheque(U_BlackListCheque_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55152,0,'U_POSTerminal_UU',TO_DATE('2011-03-29 11:01:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','U_POSTerminal_UU','U_POSTerminal_UU',TO_DATE('2011-03-29 11:01:21','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61058,55152,0,10,52004,'U_POSTerminal_UU',TO_DATE('2011-03-29 11:01:21','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','U_POSTerminal_UU',TO_DATE('2011-03-29 11:01:21','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE U_POSTerminal ADD U_POSTerminal_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX U_POSTerminal_UU_idx ON u_posterminal(U_POSTerminal_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55153,0,'U_RoleMenu_UU',TO_DATE('2011-03-29 11:01:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','U_RoleMenu_UU','U_RoleMenu_UU',TO_DATE('2011-03-29 11:01:23','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61059,55153,0,10,52002,'U_RoleMenu_UU',TO_DATE('2011-03-29 11:01:23','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','U_RoleMenu_UU',TO_DATE('2011-03-29 11:01:23','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE U_RoleMenu ADD U_RoleMenu_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX U_RoleMenu_UU_idx ON u_rolemenu(U_RoleMenu_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55154,0,'U_WebMenu_UU',TO_DATE('2011-03-29 11:01:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','U_WebMenu_UU','U_WebMenu_UU',TO_DATE('2011-03-29 11:01:25','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61060,55154,0,10,52003,'U_WebMenu_UU',TO_DATE('2011-03-29 11:01:25','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','U_WebMenu_UU',TO_DATE('2011-03-29 11:01:25','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE U_WebMenu ADD U_WebMenu_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX U_WebMenu_UU_idx ON u_webmenu(U_WebMenu_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55155,0,'U_Web_Properties_UU',TO_DATE('2011-03-29 11:01:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','U_Web_Properties_UU','U_Web_Properties_UU',TO_DATE('2011-03-29 11:01:28','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61061,55155,0,10,52001,'U_Web_Properties_UU',TO_DATE('2011-03-29 11:01:28','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','U_Web_Properties_UU',TO_DATE('2011-03-29 11:01:28','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE U_Web_Properties ADD U_Web_Properties_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX U_Web_Properties_UU_idx ON u_web_properties(U_Web_Properties_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55156,0,'W_Advertisement_UU',TO_DATE('2011-03-29 11:01:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','W_Advertisement_UU','W_Advertisement_UU',TO_DATE('2011-03-29 11:01:29','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61062,55156,0,10,579,'W_Advertisement_UU',TO_DATE('2011-03-29 11:01:29','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','W_Advertisement_UU',TO_DATE('2011-03-29 11:01:29','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE W_Advertisement ADD W_Advertisement_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX W_Advertisement_UU_idx ON w_advertisement(W_Advertisement_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55157,0,'W_Basket_UU',TO_DATE('2011-03-29 11:01:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','W_Basket_UU','W_Basket_UU',TO_DATE('2011-03-29 11:01:32','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61063,55157,0,10,402,'W_Basket_UU',TO_DATE('2011-03-29 11:01:32','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','W_Basket_UU',TO_DATE('2011-03-29 11:01:32','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE W_Basket ADD W_Basket_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX W_Basket_UU_idx ON w_basket(W_Basket_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55158,0,'W_BasketLine_UU',TO_DATE('2011-03-29 11:01:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','W_BasketLine_UU','W_BasketLine_UU',TO_DATE('2011-03-29 11:01:34','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61064,55158,0,10,549,'W_BasketLine_UU',TO_DATE('2011-03-29 11:01:34','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','W_BasketLine_UU',TO_DATE('2011-03-29 11:01:34','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE W_BasketLine ADD W_BasketLine_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX W_BasketLine_UU_idx ON w_basketline(W_BasketLine_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55159,0,'W_Click_UU',TO_DATE('2011-03-29 11:01:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','W_Click_UU','W_Click_UU',TO_DATE('2011-03-29 11:01:38','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61065,55159,0,10,550,'W_Click_UU',TO_DATE('2011-03-29 11:01:38','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','W_Click_UU',TO_DATE('2011-03-29 11:01:38','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE W_Click ADD W_Click_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX W_Click_UU_idx ON w_click(W_Click_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55160,0,'W_ClickCount_UU',TO_DATE('2011-03-29 11:01:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','W_ClickCount_UU','W_ClickCount_UU',TO_DATE('2011-03-29 11:01:40','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61066,55160,0,10,553,'W_ClickCount_UU',TO_DATE('2011-03-29 11:01:40','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','W_ClickCount_UU',TO_DATE('2011-03-29 11:01:40','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE W_ClickCount ADD W_ClickCount_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX W_ClickCount_UU_idx ON w_clickcount(W_ClickCount_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55161,0,'W_Counter_UU',TO_DATE('2011-03-29 11:01:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','W_Counter_UU','W_Counter_UU',TO_DATE('2011-03-29 11:01:41','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61067,55161,0,10,403,'W_Counter_UU',TO_DATE('2011-03-29 11:01:41','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','W_Counter_UU',TO_DATE('2011-03-29 11:01:41','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE W_Counter ADD W_Counter_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX W_Counter_UU_idx ON w_counter(W_Counter_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55162,0,'W_CounterCount_UU',TO_DATE('2011-03-29 11:01:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','W_CounterCount_UU','W_CounterCount_UU',TO_DATE('2011-03-29 11:01:43','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61068,55162,0,10,552,'W_CounterCount_UU',TO_DATE('2011-03-29 11:01:43','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','W_CounterCount_UU',TO_DATE('2011-03-29 11:01:43','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE W_CounterCount ADD W_CounterCount_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX W_CounterCount_UU_idx ON w_countercount(W_CounterCount_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55163,0,'W_MailMsg_UU',TO_DATE('2011-03-29 11:01:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','W_MailMsg_UU','W_MailMsg_UU',TO_DATE('2011-03-29 11:01:45','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61069,55163,0,10,780,'W_MailMsg_UU',TO_DATE('2011-03-29 11:01:45','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','W_MailMsg_UU',TO_DATE('2011-03-29 11:01:45','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE W_MailMsg ADD W_MailMsg_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX W_MailMsg_UU_idx ON w_mailmsg(W_MailMsg_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55164,0,'W_MailMsg_Trl_UU',TO_DATE('2011-03-29 11:01:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','W_MailMsg_Trl_UU','W_MailMsg_Trl_UU',TO_DATE('2011-03-29 11:01:47','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61070,55164,0,10,781,'W_MailMsg_Trl_UU',TO_DATE('2011-03-29 11:01:47','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','W_MailMsg_Trl_UU',TO_DATE('2011-03-29 11:01:47','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE W_MailMsg_Trl ADD W_MailMsg_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX W_MailMsg_Trl_UU_idx ON w_mailmsg_trl(W_MailMsg_Trl_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55165,0,'W_Store_UU',TO_DATE('2011-03-29 11:01:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','W_Store_UU','W_Store_UU',TO_DATE('2011-03-29 11:01:48','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61071,55165,0,10,778,'W_Store_UU',TO_DATE('2011-03-29 11:01:48','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','W_Store_UU',TO_DATE('2011-03-29 11:01:48','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE W_Store ADD W_Store_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX W_Store_UU_idx ON w_store(W_Store_UU)
;

INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55166,0,'W_Store_Trl_UU',TO_DATE('2011-03-29 11:01:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','W_Store_Trl_UU','W_Store_Trl_UU',TO_DATE('2011-03-29 11:01:50','YYYY-MM-DD HH24:MI:SS'),100)
;

INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsTranslated,IsUpdateable,Name,Updated,UpdatedBy,Version) VALUES (0,61072,55166,0,10,779,'W_Store_Trl_UU',TO_DATE('2011-03-29 11:01:50','YYYY-MM-DD HH24:MI:SS'),100,'D',36,'Y','N','N','N','N','N','N','N','N','Y','W_Store_Trl_UU',TO_DATE('2011-03-29 11:01:50','YYYY-MM-DD HH24:MI:SS'),100,1.00)
;

ALTER TABLE W_Store_Trl ADD W_Store_Trl_UU NVARCHAR2(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX W_Store_Trl_UU_idx ON w_store_trl(W_Store_Trl_UU)
;

INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

