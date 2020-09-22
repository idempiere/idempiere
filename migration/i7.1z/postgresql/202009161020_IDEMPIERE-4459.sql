-- IDEMPIERE-4459
-- Sep 16, 2020, 10:06:00 AM CEST
CREATE TABLE ad_userdef_info
(
   ad_userdef_info_id  numeric(10)     NOT NULL,
   ad_client_id       numeric(10)     NOT NULL,
   ad_org_id          numeric(10)     NOT NULL,
   isactive           char(1)         DEFAULT 'Y'::bpchar NOT NULL,
   created            timestamp       DEFAULT now() NOT NULL,
   createdby          numeric(10)     NOT NULL,
   updated            timestamp       DEFAULT now() NOT NULL,
   updatedby          numeric(10)     NOT NULL,
   ad_role_id         numeric(10),
   ad_user_id         numeric(10),
   ad_infowindow_id       numeric(10)     NOT NULL,
   name               varchar(60),
   description        varchar(255),
   help               varchar(2000),
   ad_language        varchar(6),
   isdefault          char(1)         DEFAULT 'N'::bpchar NOT NULL,
   isreadonly         char(1)         DEFAULT 'N'::bpchar NOT NULL,
   isuserupdateable   char(1)         DEFAULT 'Y'::bpchar NOT NULL,
   ad_userdef_info_uu  varchar(36)     DEFAULT NULL::character varying,
   CONSTRAINT ad_userdef_info_isactive_check CHECK (isactive = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])),
   CONSTRAINT ad_userdef_info_isdefault_check CHECK (isdefault = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])),
   CONSTRAINT ad_userdef_info_isreadonly_check CHECK (isreadonly = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])),
   CONSTRAINT ad_userdef_info_isuserupdateable_check CHECK (isuserupdateable = ANY (ARRAY['Y'::bpchar, 'N'::bpchar]))
);

ALTER TABLE ad_userdef_info
   ADD CONSTRAINT ad_userdef_info_pkey
   PRIMARY KEY (ad_userdef_info_id);

ALTER TABLE ad_userdef_info
  ADD CONSTRAINT adlangu_aduserdefinfo FOREIGN KEY (ad_language)
  REFERENCES ad_language (ad_language)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
  DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ad_userdef_info
  ADD CONSTRAINT adrole_aduserdefinfo FOREIGN KEY (ad_role_id)
  REFERENCES ad_role (ad_role_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
  DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ad_userdef_info
  ADD CONSTRAINT aduser_aduserdefinfo FOREIGN KEY (ad_user_id)
  REFERENCES ad_user (ad_user_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
  DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ad_userdef_info
  ADD CONSTRAINT adwindow_aduserdefinfo FOREIGN KEY (ad_infowindow_id)
  REFERENCES ad_infowindow (ad_infowindow_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
  DEFERRABLE INITIALLY DEFERRED;

CREATE UNIQUE INDEX ad_userdef_info_uu_idx ON adempiere.ad_userdef_info USING btree (ad_userdef_info_uu);

GRANT REFERENCES, TRUNCATE, UPDATE, TRIGGER, INSERT, SELECT, DELETE ON ad_userdef_info TO adempiere;

-- Sep 16, 2020, 10:08:00 AM CEST
CREATE TABLE ad_userdef_info_column
(
   ad_userdef_info_column_id     numeric(10)     NOT NULL,
   ad_client_id            numeric(10)     NOT NULL,
   ad_org_id               numeric(10)     NOT NULL,
   isactive                char(1)         DEFAULT 'Y'::bpchar NOT NULL,
   created                 timestamp       DEFAULT now() NOT NULL,
   createdby               numeric(10)     NOT NULL,
   updated                 timestamp       DEFAULT now() NOT NULL,
   updatedby               numeric(10)     NOT NULL,
   ad_infocolumn_id             numeric(10)     NOT NULL,
   name                    varchar(60),
   description             varchar(255),
   help                    varchar(2000),
   ad_userdef_info_column_uu     varchar(36)     DEFAULT NULL::character varying,  
   entitytype             varchar(40)     DEFAULT 'D'::character varying NOT NULL,
   selectclause           varchar(2000)   NOT NULL,
   seqno                  numeric(10)     DEFAULT 0 NOT NULL,
   isdisplayed            char(1)         DEFAULT 'Y'::bpchar NOT NULL,
   isquerycriteria        char(1)         DEFAULT 'N'::bpchar NOT NULL,
   ad_element_id          numeric(10),
   ad_reference_id        numeric(10)     NOT NULL,
   ad_infocolumn_uu       varchar(36)     DEFAULT NULL::character varying,
   ad_reference_value_id  numeric(10)     DEFAULT NULL::numeric,
   ad_val_rule_id         numeric(10)     DEFAULT NULL::numeric,
   iscentrallymaintained  char(1)         DEFAULT 'Y'::bpchar NOT NULL,
   displaylogic           varchar(2000)   DEFAULT NULL::character varying,
   columnname             varchar(30)     NOT NULL,
   queryoperator          varchar(10)     DEFAULT NULL::character varying,
   queryfunction          varchar(2000),
   isidentifier           char(1)         DEFAULT 'N'::bpchar NOT NULL,
   seqnoselection         numeric(10)     DEFAULT (0)::numeric,
   fieldlength            numeric(10)     DEFAULT NULL::numeric,
   vformat                varchar(60)     DEFAULT NULL::character varying,
   valuemin               varchar(20)     DEFAULT NULL::character varying,
   valuemax               varchar(20)     DEFAULT NULL::character varying,
   defaultvalue           varchar(2000)   DEFAULT NULL::character varying,
   issameline             char(1)         DEFAULT NULL::bpchar,
   ismandatory            char(1)         DEFAULT 'N'::bpchar NOT NULL,
   iskey                  char(1)         DEFAULT NULL::bpchar,
   isreadonly             char(1)         DEFAULT 'Y'::bpchar NOT NULL,
   placeholder            varchar(255)    DEFAULT NULL::character varying,
   inputfieldvalidation   varchar(2000)   DEFAULT NULL::character varying,
   ad_fieldstyle_id       numeric(10)     DEFAULT NULL::numeric,
   isautocomplete         char(1)         DEFAULT 'N'::bpchar NOT NULL,

   CONSTRAINT ad_userdef_info_column_isactive_check CHECK (isactive = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])),
   CONSTRAINT ad_userdef_info_column_isdisplayed_check CHECK (isdisplayed = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])),
   CONSTRAINT ad_userdef_info_column_isreadonly_check CHECK (isreadonly = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])),
   CONSTRAINT ad_userdef_info_column_issameline_check CHECK (issameline = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])),
   CONSTRAINT ad_userdef_info_column_isautocomplete_check CHECK (isautocomplete = ANY (ARRAY['Y'::bpchar, 'N'::bpchar]))
);

ALTER TABLE ad_userdef_info_column
   ADD CONSTRAINT ad_userdef_info_column_pkey
   PRIMARY KEY (ad_userdef_info_column_id);

ALTER TABLE ad_userdef_info_column
  ADD CONSTRAINT adfield_aduserdefcolumn FOREIGN KEY (ad_infocolumn_id)
  REFERENCES AD_InfoColumn (ad_infocolumn_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
  DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ad_userdef_info_column
  ADD CONSTRAINT adreference_aduserdefcolumn FOREIGN KEY (ad_reference_id)
  REFERENCES ad_reference (ad_reference_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
  DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ad_userdef_info_column
  ADD CONSTRAINT adreferencevalue_aduserdeffiel FOREIGN KEY (ad_reference_value_id)
  REFERENCES ad_reference (ad_reference_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
  DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ad_userdef_info_column
  ADD CONSTRAINT adfieldstyle_aduserdefcolumn FOREIGN KEY (ad_fieldstyle_id)
  REFERENCES ad_style (ad_style_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
  DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ad_userdef_info_column
  ADD CONSTRAINT advalrule_aduserdefcolumn FOREIGN KEY (ad_val_rule_id)
  REFERENCES ad_val_rule (ad_val_rule_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
  DEFERRABLE INITIALLY DEFERRED;

CREATE UNIQUE INDEX ad_userdef_info_column_uu_idx ON adempiere.ad_userdef_info_column USING btree (ad_userdef_info_column_uu);

GRANT REFERENCES, TRUNCATE, UPDATE, TRIGGER, INSERT, SELECT, DELETE ON ad_userdef_info_column TO adempiere;

-- Sep 16, 2020, 10:12:00 AM CEST
CREATE TABLE ad_userdef_info_related
(
   ad_userdef_info_related_id  numeric(10)     NOT NULL,
   ad_client_id       numeric(10)     NOT NULL,
   ad_org_id          numeric(10)     NOT NULL,
   isactive           char(1)         DEFAULT 'Y'::bpchar NOT NULL,
   created            timestamp       DEFAULT now() NOT NULL,
   createdby          numeric(10)     NOT NULL,
   updated            timestamp       DEFAULT now() NOT NULL,
   updatedby          numeric(10)     NOT NULL,
   ad_userdef_info_id  numeric(10)     NOT NULL,
   ad_inforelated_id          numeric(10)     NOT NULL,
   name               varchar(60),
   description        varchar(255),
   help               varchar(2000),
   isreadonly         char(1)         DEFAULT 'N'::bpchar NOT NULL,
   issinglerow        char(1)         DEFAULT 'N'::bpchar NOT NULL,
   ad_userdef_info_related_uu  varchar(36)     DEFAULT NULL::character varying,
   readonlylogic      varchar(2000)   DEFAULT NULL::character varying,
   ad_ctxhelp_id      numeric(10)     DEFAULT NULL::numeric,
   isdisplayed             char(1),
   displaylength           numeric(10)     DEFAULT 0 NOT NULL,   
   displaylogic            varchar(2000),
   RelatedInfo_ID      numeric(10)     DEFAULT NULL::numeric,
   RelatedColumn_ID      numeric(10)     DEFAULT NULL::numeric,
   ParentRelatedColumn_ID      numeric(10)     DEFAULT NULL::numeric,     
   seqno                   numeric(10)     DEFAULT (0)::numeric NOT NULL,

   CONSTRAINT ad_userdef_info_related_isactive_check CHECK (isactive = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])),
   CONSTRAINT ad_userdef_info_related_isreadonly_check CHECK (isreadonly = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])),
   CONSTRAINT ad_userdef_info_related_issinglerow_check CHECK (issinglerow = ANY (ARRAY['Y'::bpchar, 'N'::bpchar]))
);

ALTER TABLE ad_userdef_info_related
   ADD CONSTRAINT ad_userdef_info_related_pkey
   PRIMARY KEY (ad_userdef_info_related_id);

ALTER TABLE ad_userdef_info_related
  ADD CONSTRAINT adctxhelp_aduserdefrel FOREIGN KEY (ad_ctxhelp_id)
  REFERENCES ad_ctxhelp (ad_ctxhelp_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
  DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ad_userdef_info_related
  ADD CONSTRAINT aduserdefinfo_aduserdefrel FOREIGN KEY (ad_userdef_info_id)
  REFERENCES ad_userdef_info (ad_userdef_info_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
  DEFERRABLE INITIALLY DEFERRED;

CREATE UNIQUE INDEX ad_userdef_info_related_uu_idx ON adempiere.ad_userdef_info_related USING btree (ad_userdef_info_related_uu);

GRANT REFERENCES, TRUNCATE, UPDATE, TRIGGER, INSERT, SELECT, DELETE ON ad_userdef_info_related TO adempiere;

-- Sep 16, 2020, 10:20:16 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203433,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:20:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:20:15','YYYY-MM-DD HH24:MI:SS'),100,'AD_UserDef_Info','User defined Info Window','User Info Win','D','f59f4c84-4613-48a8-b297-9f2b65aabf7c')
;

-- Sep 16, 2020, 10:23:49 AM CEST
UPDATE AD_Element SET ColumnName='AD_UserDef_Info_ID',Updated=TO_TIMESTAMP('2020-09-16 10:23:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203433
;

-- Sep 16, 2020, 10:23:49 AM CEST
UPDATE AD_Column SET ColumnName='AD_UserDef_Info_ID', Name='User defined Info Window', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203433
;

-- Sep 16, 2020, 10:23:49 AM CEST
UPDATE AD_Process_Para SET ColumnName='AD_UserDef_Info_ID', Name='User defined Info Window', Description=NULL, Help=NULL, AD_Element_ID=203433 WHERE UPPER(ColumnName)='AD_USERDEF_INFO_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Sep 16, 2020, 10:23:49 AM CEST
UPDATE AD_Process_Para SET ColumnName='AD_UserDef_Info_ID', Name='User defined Info Window', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203433 AND IsCentrallyMaintained='Y'
;

-- Sep 16, 2020, 10:23:49 AM CEST
UPDATE AD_InfoColumn SET ColumnName='AD_UserDef_Info_ID', Name='User defined Info Window', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203433 AND IsCentrallyMaintained='Y'
;

-- Sep 16, 2020, 10:25:15 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203434,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:25:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:25:15','YYYY-MM-DD HH24:MI:SS'),100,'AD_UserDef_Info_Column_ID','User defined Info Column','User Info Column','D','c6764b46-7e2f-47f7-93dc-fd2485211131')
;

-- Sep 16, 2020, 10:25:45 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203435,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:25:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:25:45','YYYY-MM-DD HH24:MI:SS'),100,'AD_UserDef_Info_Related_ID','User defined Info Related','User Info Related','D','60154684-1e81-4868-8295-99c3f8d22fbc')
;

-- Sep 16, 2020, 10:28:28 AM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,IsCentrallyMaintained,AD_Table_UU,Processing) VALUES (200266,'User defined Info Window',229,'AD_UserDef_Info',135,'6',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:28:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:28:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','Y','L','Y','bf0ce772-b06d-4c8a-87f2-42adfa5b31a2','N')
;

-- Sep 16, 2020, 10:28:28 AM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_UserDef_Info',1000000,'N','N','Table AD_UserDef_Info','Y','Y',0,0,TO_TIMESTAMP('2020-09-16 10:28:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:28:28','YYYY-MM-DD HH24:MI:SS'),100,200332,'Y',1000000,1,200000,'88550411-95c8-4acf-aae8-ba28bd85f5cf')
;

-- Sep 16, 2020, 10:28:39 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214227,0.0,'User defined Info Window',200266,'AD_UserDef_Info_ID',10,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:28:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:28:39','YYYY-MM-DD HH24:MI:SS'),100,203433,'N','N','D','N','b148f025-8d82-46ae-8126-27afd1a0269f','N')
;

-- Sep 16, 2020, 10:28:40 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214228,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200266,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:28:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:28:39','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','49081b54-d21c-4626-a519-0f6b9587b87c','N','D')
;

-- Sep 16, 2020, 10:28:40 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214229,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200266,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:28:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:28:40','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','88359471-f67b-4c75-854c-f9a842db05ca','N','D')
;

-- Sep 16, 2020, 10:28:40 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214230,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200266,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:28:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:28:40','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','ac4ed706-e659-42e4-8c9a-30f91674b6b3','N')
;

-- Sep 16, 2020, 10:28:41 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214231,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200266,'Created','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:28:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:28:40','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','02ba72c6-ebb4-484c-9562-f5ffca19afa5','N')
;

-- Sep 16, 2020, 10:28:41 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214232,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200266,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:28:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:28:41','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','6e420cdc-23ee-4373-99e8-8b31f9a05e43','N','D')
;

-- Sep 16, 2020, 10:28:41 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214233,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200266,'Updated','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:28:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:28:41','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','53704635-02ba-4cb1-b166-08b6b27070a6','N')
;

-- Sep 16, 2020, 10:28:42 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214234,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200266,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:28:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:28:41','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','0f9a1dc0-55c3-4396-8bf8-5547ec3d6314','N','D')
;

-- Sep 16, 2020, 10:28:42 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214235,0.0,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200266,'AD_Role_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:28:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:28:42','YYYY-MM-DD HH24:MI:SS'),100,123,'N','N','D','N','fe8cb3f5-3a35-4226-aa43-66a6015b0785','N','C')
;

-- Sep 16, 2020, 10:28:42 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214236,0.0,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200266,'AD_User_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:28:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:28:42','YYYY-MM-DD HH24:MI:SS'),100,138,'N','N','D','N','79532b19-8765-4cd9-af0a-fb3a7a063202','N')
;

-- Sep 16, 2020, 10:28:42 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214237,0.0,'Info Window','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.',200266,'AD_InfoWindow_ID',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:28:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:28:42','YYYY-MM-DD HH24:MI:SS'),100,3068,'N','N','D','N','355c6b3b-a540-4bf5-983d-3a5ac0a6dc78','N','C')
;

-- Sep 16, 2020, 10:28:43 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (214238,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200266,'Name',60,'N','N','N','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:28:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:28:42','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','cf743c89-f7dd-4679-aa63-9dc34b4b5cc5',10,'N')
;

-- Sep 16, 2020, 10:28:43 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (214239,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200266,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:28:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:28:43','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','N','d787f330-ec55-4874-87c5-4f3ee56cec7b',20,'N')
;

-- Sep 16, 2020, 10:28:43 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214240,0.0,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200266,'Help',2000,'N','N','N','N','N','N',14,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:28:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:28:43','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','N','701db25f-33b4-4e8b-afde-38cc917f594e','N')
;

-- Sep 16, 2020, 10:28:44 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214241,0.0,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200266,'AD_Language',6,'N','N','N','N','N','N',18,106,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:28:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:28:43','YYYY-MM-DD HH24:MI:SS'),100,109,'N','N','D','N','22154794-072c-4240-891e-ad3623df3b93','N','N')
;

-- Sep 16, 2020, 10:28:44 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214242,0.0,'Default','Default value','The Default Checkbox indicates if this record will be used as a default value.',200266,'IsDefault',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:28:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:28:44','YYYY-MM-DD HH24:MI:SS'),100,1103,'Y','N','D','N','1fff3bb0-71bf-4078-babd-e14520cee945','N')
;

-- Sep 16, 2020, 10:28:44 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214243,0.0,'Read Only','Field is read only','The Read Only indicates that this field may only be Read.  It may not be updated.',200266,'IsReadOnly',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:28:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:28:44','YYYY-MM-DD HH24:MI:SS'),100,405,'Y','N','D','N','19ff0fe9-b846-41e7-aed7-8a0e04cbfac6','N')
;

-- Sep 16, 2020, 10:28:44 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214244,0.0,'User updatable','The field can be updated by the user','The User Updatable checkbox indicate if the user can update  this field.',200266,'IsUserUpdateable',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:28:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:28:44','YYYY-MM-DD HH24:MI:SS'),100,423,'Y','N','D','N','2f1898a5-408a-49c7-a6f4-0fa89522cb95','N','N')
;

-- Sep 16, 2020, 10:28:45 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203436,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:28:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:28:44','YYYY-MM-DD HH24:MI:SS'),100,'AD_UserDef_Info_UU','AD_UserDef_Info_UU','AD_UserDef_Info_UU','D','445df916-338b-4a70-8838-a7331b4d25c2')
;

-- Sep 16, 2020, 10:28:45 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214245,0.0,'AD_UserDef_Info_UU',200266,'AD_UserDef_Info_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:28:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:28:44','YYYY-MM-DD HH24:MI:SS'),100,203436,'N','N','D','N','04f2c9c7-d3e3-4847-93b0-edb8fc829af0','N')
;

-- Sep 16, 2020, 10:29:24 AM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,IsCentrallyMaintained,AD_Table_UU,Processing) VALUES (200267,'User defined Info Window Related','AD_UserDef_Related',135,'6',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:29:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:29:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','Y','L','Y','c7a35973-e80a-45a3-885f-ced286ba7d10','N')
;

-- Sep 16, 2020, 10:29:25 AM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_UserDef_Related',1000000,'N','N','Table AD_UserDef_Related','Y','Y',0,0,TO_TIMESTAMP('2020-09-16 10:29:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:29:24','YYYY-MM-DD HH24:MI:SS'),100,200333,'Y',1000000,1,200000,'e9e2ab78-76d9-4ddd-97ef-13e9f5f4f0ba')
;

-- Sep 16, 2020, 10:29:47 AM CEST
UPDATE AD_Table SET TableName='AD_UserDef_Info_Related',Updated=TO_TIMESTAMP('2020-09-16 10:29:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200267
;

-- Sep 16, 2020, 10:29:48 AM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_UserDef_Info_Related',1000000,'N','N','Table AD_UserDef_Info_Related','Y','Y',0,0,TO_TIMESTAMP('2020-09-16 10:29:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:29:47','YYYY-MM-DD HH24:MI:SS'),100,200334,'Y',1000000,1,200000,'5b898311-ff19-4779-8f60-ed9d8ed88abb')
;

-- Sep 16, 2020, 10:29:58 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214246,0.0,'User defined Info Related',200267,'AD_UserDef_Info_Related_ID',10,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:29:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:29:58','YYYY-MM-DD HH24:MI:SS'),100,203435,'N','N','D','N','ee258c88-b40b-47eb-9336-367ffaaf0c4f','N')
;

-- Sep 16, 2020, 10:29:59 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214247,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200267,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:29:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:29:58','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','75d6a16c-350f-435d-ad3a-14c3bd766de4','N','D')
;

-- Sep 16, 2020, 10:29:59 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214248,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200267,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:29:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:29:59','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','6f22c7ac-8e32-4d38-9dfb-6708920a6d14','N','D')
;

-- Sep 16, 2020, 10:29:59 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214249,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200267,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:29:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:29:59','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','0c7aabc6-4a40-42b0-b05a-44cdd06006bf','N')
;

-- Sep 16, 2020, 10:30:00 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214250,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200267,'Created','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:29:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:29:59','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','268d8df0-7714-40ad-a745-63f91b4921e2','N')
;

-- Sep 16, 2020, 10:30:00 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214251,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200267,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:30:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:30:00','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','8c0d4db1-8807-4646-b7c4-60c6a42040ee','N','D')
;

-- Sep 16, 2020, 10:30:00 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214252,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200267,'Updated','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:30:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:30:00','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','4b228dfd-2fd0-4b47-8879-b33d45e26cf8','N')
;

-- Sep 16, 2020, 10:30:00 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214253,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200267,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:30:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:30:00','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','16493810-fd33-4ca6-bb8d-20800c7a1184','N','D')
;

-- Sep 16, 2020, 10:30:01 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214254,0.0,'User defined Info Window',200267,'AD_UserDef_Info_ID',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:30:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:30:00','YYYY-MM-DD HH24:MI:SS'),100,203433,'N','N','D','N','9f604bf1-cfa8-49c1-a180-3aecfa55d681','N','N')
;

-- Sep 16, 2020, 10:30:01 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214255,0.0,'InfoRelated',200267,'AD_InfoRelated_ID',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:30:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:30:01','YYYY-MM-DD HH24:MI:SS'),100,202556,'N','N','D','N','33359872-aa10-4fa2-bc06-5d1a828c971f','N','N')
;

-- Sep 16, 2020, 10:30:02 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (214256,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200267,'Name',60,'N','N','N','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:30:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:30:01','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','887484d9-7533-474a-b0dd-f5bf391398c8',10,'N')
;

-- Sep 16, 2020, 10:30:02 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (214257,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200267,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:30:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:30:02','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','N','004544c7-eb56-47dc-8e3f-2205c9a9e047',20,'N')
;

-- Sep 16, 2020, 10:30:02 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214258,0.0,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200267,'Help',2000,'N','N','N','N','N','N',14,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:30:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:30:02','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','N','382d2129-4772-4554-8086-16bfea67929c','N')
;

-- Sep 16, 2020, 10:30:03 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203437,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:30:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:30:03','YYYY-MM-DD HH24:MI:SS'),100,'AD_UserDef_Info_Related_UU','AD_UserDef_Info_Related_UU','AD_UserDef_Info_Related_UU','D','61fbc58b-539b-4181-9eac-91867d39a6cf')
;

-- Sep 16, 2020, 10:30:04 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214261,0.0,'AD_UserDef_Info_Related_UU',200267,'AD_UserDef_Info_Related_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:30:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:30:03','YYYY-MM-DD HH24:MI:SS'),100,203437,'N','N','D','N','f0b0a8d8-3e22-4504-83fd-b50b49fea309','N')
;

-- Sep 16, 2020, 10:30:04 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214263,0.0,'Context Help',200267,'AD_CtxHelp_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:30:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:30:04','YYYY-MM-DD HH24:MI:SS'),100,202212,'N','N','D','N','f2485f3b-bb9a-4da7-a964-0566117af14d','N')
;

-- Sep 16, 2020, 10:30:05 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214264,0.0,'Displayed','Determines, if this field is displayed','If the field is displayed, the field Display Logic will determine at runtime, if it is actually displayed',200267,'IsDisplayed','Y',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:30:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:30:04','YYYY-MM-DD HH24:MI:SS'),100,368,'Y','N','D','N','a00cda11-0e9f-4b35-8acf-faf0b06d18cf','N')
;

-- Sep 16, 2020, 10:30:05 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214266,0.0,'Display Logic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
@AD_Table_ID@=14 | @Language@!GERGER <br>
@PriceLimit@>10 | @PriceList@>@PriceActual@<br>
@Name@>J<br>
Strings may be in single quotes (optional)',200267,'DisplayLogic',2000,'N','N','N','N','N','N',14,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:30:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:30:05','YYYY-MM-DD HH24:MI:SS'),100,283,'Y','N','D','N','93ce9482-7fb4-4d54-97b0-51da098363c3','N','N')
;

-- Sep 16, 2020, 10:30:05 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214267,0.0,'Related Info Window',200267,'RelatedInfo_ID','0',10,'N','N','N','N','N','N',18,200071,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:30:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:30:05','YYYY-MM-DD HH24:MI:SS'),100,202557,'Y','N','D','N','36f9db23-07c3-4bb3-9975-cba5014d73ab','N','N')
;

-- Sep 16, 2020, 10:30:06 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214268,0.0,'Related Info Column',200267,200046,'RelatedColumn_ID','0',10,'N','N','N','N','N','N',18,200072,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:30:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:30:06','YYYY-MM-DD HH24:MI:SS'),100,202558,'Y','N','D','N','72eef670-1d6f-48d5-a209-182cd6460654','N','N')
;

-- Sep 16, 2020, 10:30:06 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214269,0.0,'Parent Related Column','column in parent info window, link with column in this relate info','default column RelatedColumn in Relate Info window will link with key column of main info window
column define in ParentRelatedColumn will replace key column',200267,200065,'ParentRelatedColumn_ID',10,'N','N','N','N','N','N',18,200072,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:30:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:30:06','YYYY-MM-DD HH24:MI:SS'),100,202792,'Y','N','D','N','7fb59bc3-0257-443b-9f67-ef79dc57a673','N','N')
;

-- Sep 16, 2020, 10:30:06 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214270,0.0,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200267,'SeqNo',10,'N','N','Y','N','N','N',11,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:30:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:30:06','YYYY-MM-DD HH24:MI:SS'),100,566,'Y','N','D','N','1b5028d1-38db-41c5-9743-be85a4964b64','N')
;

-- Sep 16, 2020, 10:30:30 AM CEST
UPDATE AD_Table SET AD_Window_ID=NULL,Updated=TO_TIMESTAMP('2020-09-16 10:30:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200266
;

-- Sep 16, 2020, 10:31:03 AM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,IsCentrallyMaintained,AD_Table_UU,Processing) VALUES (200268,'User defined Info Window Column','AD_UserDef_Info_Column',135,'6',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','Y','L','Y','50038b97-2f94-40f0-8ae2-79b517c07390','N')
;

-- Sep 16, 2020, 10:31:03 AM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_UserDef_Info_Column',1000000,'N','N','Table AD_UserDef_Info_Column','Y','Y',0,0,TO_TIMESTAMP('2020-09-16 10:31:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:03','YYYY-MM-DD HH24:MI:SS'),100,200335,'Y',1000000,1,200000,'2f8b04e1-54cf-43cd-8f62-28b898370777')
;

-- Sep 16, 2020, 10:31:12 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214271,0.0,'User defined Info Column',200268,'AD_UserDef_Info_Column_ID',10,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:12','YYYY-MM-DD HH24:MI:SS'),100,203434,'N','N','D','N','b370b463-85ec-41d2-aa8f-2a121041d7a7','N')
;

-- Sep 16, 2020, 10:31:12 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214272,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200268,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:12','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','d39252c7-ae85-458c-b20b-9e13c47b7808','N','D')
;

-- Sep 16, 2020, 10:31:13 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214273,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200268,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:12','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','2c6e10f1-d702-4f9a-9420-1e3b8b7d49f7','N','D')
;

-- Sep 16, 2020, 10:31:13 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214274,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200268,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:13','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','dc7884f2-06ca-419f-bfdc-025b1f94de88','N')
;

-- Sep 16, 2020, 10:31:13 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214275,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200268,'Created','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:13','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','bf072bc6-b62b-4a04-acaa-e015c235c0cc','N')
;

-- Sep 16, 2020, 10:31:14 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214276,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200268,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:13','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','2056c54d-0543-4454-b660-28a3dba7ed1c','N','D')
;

-- Sep 16, 2020, 10:31:14 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214277,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200268,'Updated','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:14','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','e9767da8-79cd-4cf0-9acf-52a33269ee2b','N')
;

-- Sep 16, 2020, 10:31:14 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214278,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200268,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:14','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','857ea778-427d-4e25-8ba8-7dcbe2261069','N','D')
;

-- Sep 16, 2020, 10:31:15 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214279,0.0,'Info Column','Info Window Column','Column in the Info Window for display and/or selection.  If used for selection, the column cannot be a SQL expression. The SQL clause must be fully qualified based on the FROM clause in the Info Window definition',200268,'AD_InfoColumn_ID',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:14','YYYY-MM-DD HH24:MI:SS'),100,3069,'N','N','D','N','c8b226ca-a750-4f36-bbae-f0c9d8d681b8','N')
;

-- Sep 16, 2020, 10:31:15 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (214280,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200268,'Name',60,'N','N','N','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:15','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','2a4a9c5a-7abc-4556-b793-a021b9cd881b',10,'N')
;

-- Sep 16, 2020, 10:31:15 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (214281,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200268,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:15','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','N','dc13fdf2-6024-45f1-b5e1-1f038a471378',20,'N')
;

-- Sep 16, 2020, 10:31:15 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214282,0.0,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200268,'Help',2000,'N','N','N','N','N','N',14,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:15','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','N','1ca3f676-fc63-4a53-9093-d3971d3da078','N')
;

-- Sep 16, 2020, 10:31:16 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203438,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:15','YYYY-MM-DD HH24:MI:SS'),100,'AD_UserDef_Info_Column_UU','AD_UserDef_Info_Column_UU','AD_UserDef_Info_Column_UU','D','5caacb44-b85b-4041-aca9-c2537b53ce49')
;

-- Sep 16, 2020, 10:31:16 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214283,0.0,'AD_UserDef_Info_Column_UU',200268,'AD_UserDef_Info_Column_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:15','YYYY-MM-DD HH24:MI:SS'),100,203438,'N','N','D','N','515c5930-6520-4e23-8dd2-a3046d30c573','N')
;

-- Sep 16, 2020, 10:31:17 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214286,0.0,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200268,'SeqNo',10,'N','N','Y','N','N','N',11,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:17','YYYY-MM-DD HH24:MI:SS'),100,566,'Y','N','D','N','ade452ae-74c9-4c71-baff-7f5e98a35df0','N')
;

-- Sep 16, 2020, 10:31:17 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214287,0.0,'Displayed','Determines, if this field is displayed','If the field is displayed, the field Display Logic will determine at runtime, if it is actually displayed',200268,'IsDisplayed','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:17','YYYY-MM-DD HH24:MI:SS'),100,368,'Y','N','D','N','0f88487a-4f36-44a3-957b-88c5cbace276','N')
;

-- Sep 16, 2020, 10:31:17 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214288,0.0,'Query Criteria','The column is also used as a query criteria','The column is used to enter queries - the SQL cannot be an expression',200268,'IsQueryCriteria',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:17','YYYY-MM-DD HH24:MI:SS'),100,3070,'Y','N','D','N','15006214-23ce-4ee9-98c8-938401993124','N')
;

-- Sep 16, 2020, 10:31:18 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214290,0.0,'Reference','System Reference and Validation','The Reference could be a display type, list or table validation.',200268,'AD_Reference_ID',10,'N','N','Y','N','N','N',18,1,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:18','YYYY-MM-DD HH24:MI:SS'),100,120,'Y','N','D','N','9fe08529-33ae-4a29-b0d5-fa3268fd13fc','N','N')
;

-- Sep 16, 2020, 10:31:19 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214292,0.0,'Reference Key','Required to specify, if data type is Table or List','The Reference Value indicates where the reference values are stored.  It must be specified if the data type is Table or List.  ',200268,115,'AD_Reference_Value_ID',10,'N','N','N','N','N','N',18,4,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:18','YYYY-MM-DD HH24:MI:SS'),100,121,'Y','N','D','N','fda4d3fe-9b79-4c5c-b51d-8023dcbd3cee','N','N')
;

-- Sep 16, 2020, 10:31:19 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214293,0.0,'Dynamic Validation','Dynamic Validation Rule','These rules define how an entry is determined to valid. You can use variables for dynamic (context sensitive) validation.',200268,'AD_Val_Rule_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:19','YYYY-MM-DD HH24:MI:SS'),100,139,'Y','N','D','N','7db14722-0d54-4cd1-be09-3341053e3ea2','N','N')
;

-- Sep 16, 2020, 10:31:19 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214294,0.0,'Centrally maintained','Information maintained in System Element table','The Centrally Maintained checkbox indicates if the Name, Description and Help maintained in ''System Element'' table  or ''Window'' table.',200268,'IsCentrallyMaintained','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:19','YYYY-MM-DD HH24:MI:SS'),100,362,'Y','N','D','N','5a5c2bca-6148-42a3-a0d8-879db0701979','N')
;

-- Sep 16, 2020, 10:31:20 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214295,0.0,'Display Logic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
@AD_Table_ID@=14 | @Language@!GERGER <br>
@PriceLimit@>10 | @PriceList@>@PriceActual@<br>
@Name@>J<br>
Strings may be in single quotes (optional)',200268,'DisplayLogic',2000,'N','N','N','N','N','N',14,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:19','YYYY-MM-DD HH24:MI:SS'),100,283,'Y','N','D','N','06877dff-75a8-4d5c-b9a2-86e08406cbb7','N','N')
;

-- Sep 16, 2020, 10:31:20 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,MandatoryLogic,AD_Column_UU,IsToolbarButton) VALUES (214297,0.0,'Query Operator','Operator for database query',200268,'QueryOperator',10,'N','N','N','N','N','N',17,200061,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:20','YYYY-MM-DD HH24:MI:SS'),100,202188,'Y','N','D','N','@IsQueryCriteria@=Y','f77da0c5-bdac-40a9-83e3-9c1e2c0a86ac','N')
;

-- Sep 16, 2020, 10:31:21 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214300,0.0,'Selection Column Sequence','Selection Column Sequence','For ordering sequence of selection column',200268,'SeqNoSelection','0',10,'N','N','N','N','N','N',11,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:21','YYYY-MM-DD HH24:MI:SS'),100,200096,'Y','N','D','N','4248b59c-2f42-47f9-8f7c-65c8a0aa591b','N')
;

-- Sep 16, 2020, 10:31:21 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214301,0.0,'Length','Length of the column in the database','The Length indicates the length of a column as defined in the database.',200268,'FieldLength',10,'N','N','N','N','N','N',11,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:21','YYYY-MM-DD HH24:MI:SS'),100,302,'Y','N','D','N','74a84c67-8ffb-4833-9983-f51748a167b5','N')
;

-- Sep 16, 2020, 10:31:22 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214302,0.0,'Value Format','Format of the value; Can contain fixed format elements, Variables: "_lLoOaAcCa09"','<B>Validation elements:</B>
 	(Space) any character
_	Space (fixed character)
l	any Letter a..Z NO space
L	any Letter a..Z NO space converted to upper case
o	any Letter a..Z or space
O	any Letter a..Z or space converted to upper case
a	any Letters & Digits NO space
A	any Letters & Digits NO space converted to upper case
c	any Letters & Digits or space
C	any Letters & Digits or space converted to upper case
0	Digits 0..9 NO space
9	Digits 0..9 or space

Example of format "(000)_000-0000"',200268,'VFormat',60,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:21','YYYY-MM-DD HH24:MI:SS'),100,616,'Y','N','D','N','3bf68ca3-a511-4941-9c6f-fc20c27313ff','N')
;

-- Sep 16, 2020, 10:31:22 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214303,0.0,'Min. Value','Minimum Value for a field','The Minimum Value indicates the lowest  allowable value for a field.',200268,'ValueMin',20,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:22','YYYY-MM-DD HH24:MI:SS'),100,1060,'Y','N','D','N','c97d4378-b9b8-49c0-8b5a-124646ec0951','N')
;

-- Sep 16, 2020, 10:31:22 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214304,0.0,'Max. Value','Maximum Value for a field','The Maximum Value indicates the highest allowable value for a field',200268,'ValueMax',20,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:22','YYYY-MM-DD HH24:MI:SS'),100,1059,'Y','N','D','N','9c914d88-71e5-4fc8-a47f-8c0ee995cd1c','N')
;

-- Sep 16, 2020, 10:31:23 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214305,0.0,'Default Logic','Default value hierarchy, separated by ;','The defaults are evaluated in the order of definition, the first not null value becomes the default value of the column. The values are separated by comma or semicolon. a) Literals:. ''Text'' or 123 b) Variables - in format @Variable@ - Login e.g. #Date, #AD_Org_ID, #AD_Client_ID - Accounting Schema: e.g. $C_AcctSchema_ID, $C_Calendar_ID - Global defaults: e.g. DateFormat - Window values (all Picks, CheckBoxes, RadioButtons, and DateDoc/DateAcct) c) SQL code with the tag: @SQL=SELECT something AS DefaultValue FROM ... The SQL statement can contain variables.  There can be no other value other than the SQL statement. The default is only evaluated, if no user preference is defined.  Default definitions are ignored for record columns as Key, Parent, Client as well as Buttons.',200268,'DefaultValue',2000,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:22','YYYY-MM-DD HH24:MI:SS'),100,272,'Y','N','D','N','7f881248-d5d8-4b64-910b-cca588e38931','N')
;

-- Sep 16, 2020, 10:31:23 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214307,0.0,'Mandatory','Data entry is required in this column','The field must have a value for the record to be saved to the database.',200268,'IsMandatory',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:23','YYYY-MM-DD HH24:MI:SS'),100,392,'Y','N','D','N','409d763f-d6a0-46a7-9d16-4834a5de43af','N')
;

-- Sep 16, 2020, 10:31:24 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214309,0.0,'Read Only','Field is read only','The Read Only indicates that this field may only be Read.  It may not be updated.',200268,'IsReadOnly',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:24','YYYY-MM-DD HH24:MI:SS'),100,405,'Y','N','D','N','0c9661b8-33e5-49fe-a9be-411db249faf3','N')
;

-- Sep 16, 2020, 10:31:24 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214310,0.0,'Placeholder',200268,'Placeholder',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:24','YYYY-MM-DD HH24:MI:SS'),100,203163,'Y','N','D','N','8abd7b94-9da0-487f-a1dc-ca2f02ccae47','N','N')
;

-- Sep 16, 2020, 10:31:24 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214311,0.0,'Input field validation','Input field validaton query','Input field validaton query',200268,'InputFieldValidation',2000,'N','N','N','N','N','N',14,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:24','YYYY-MM-DD HH24:MI:SS'),100,203216,'Y','N','D','N','13dba0ff-8984-49a6-9876-2562a96a4aa1','N','N')
;

-- Sep 16, 2020, 10:31:25 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214312,0.0,'Field Style','Field CSS Style ',200268,'AD_FieldStyle_ID',10,'N','N','N','N','N','N',18,200121,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:24','YYYY-MM-DD HH24:MI:SS'),100,203012,'Y','N','D','N','b760d164-353e-4e61-98e9-61b4c1a7b2af','N','N')
;

-- Sep 16, 2020, 10:31:25 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214313,0.0,'Autocomplete','Automatic completion for textfields','The autocompletion uses all existing values (from the same client and organization) of the field.',200268,'IsAutocomplete','N',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:31:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:31:25','YYYY-MM-DD HH24:MI:SS'),100,53655,'Y','N','D','N','1ae09f15-49e6-42c1-a802-a43c410f857b','N','N')
;

-- Sep 16, 2020, 10:32:25 AM CEST
INSERT INTO AD_Window (AD_Window_ID,Name,Description,Help,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200110,'Info Window Customization','Define Info Window Customization for Role/User','The customization values defined here overwrite/replace the default system definition if defined.',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:32:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:32:25','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N','N','49fe86de-d43f-4069-98a4-e649a837e6ce')
;

-- Sep 16, 2020, 10:33:28 AM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,Description,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,MaxQueryRecords) VALUES (200279,'Info Window Customization',NULL,200110,10,'Y',200268,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:27','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',0,'N','D','Y','N','50258ad1-c73b-4b4e-9a84-098d8a8ca2a7','B',0)
;

-- Sep 16, 2020, 10:33:33 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206431,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200279,214272,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7c671412-91ba-4107-aa6c-75c24aa29b88','Y',10,2)
;

-- Sep 16, 2020, 10:33:33 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (206432,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200279,214273,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d9761524-5421-4a92-842e-ba7dca73b2cc','Y','N',4,2)
;

-- Sep 16, 2020, 10:33:34 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206433,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200279,214280,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5d7bbb44-7fe3-47fe-95d2-178256d95c93','Y',20,5)
;

-- Sep 16, 2020, 10:33:34 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206434,'Description','Optional short description of the record','A description is limited to 255 characters.',200279,214281,'Y',255,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f5903082-8d4b-44c0-964a-28cf4161c5a2','Y',30,5)
;

-- Sep 16, 2020, 10:33:34 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (206435,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200279,214282,'Y',2000,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1e423ac8-03ab-48cc-99b6-850d34002185','Y',40,5,3)
;

-- Sep 16, 2020, 10:33:35 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206436,'User defined Info Column',200279,214271,'N',10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2cceba74-a3db-488f-b061-91e840f8f8ca','N',2)
;

-- Sep 16, 2020, 10:33:35 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206437,'Info Column','Info Window Column','Column in the Info Window for display and/or selection.  If used for selection, the column cannot be a SQL expression. The SQL clause must be fully qualified based on the FROM clause in the Info Window definition',200279,214279,'Y',10,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','032bdc84-f757-4643-a618-8d6602c9b81e','Y',50,2)
;

-- Sep 16, 2020, 10:33:35 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206438,'AD_UserDef_Info_Column_UU',200279,214283,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ac44dab5-36be-4e7b-a87f-76fe91105761','N',2)
;

-- Sep 16, 2020, 10:33:36 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206441,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200279,214286,'Y',10,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','222e8de0-2c92-4eb6-94e3-3a89e8469e7b','Y',80,2)
;

-- Sep 16, 2020, 10:33:36 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206442,'Displayed','Determines, if this field is displayed','If the field is displayed, the field Display Logic will determine at runtime, if it is actually displayed',200279,214287,'Y',1,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f9bcf547-4868-4798-8b91-95d0c69c664f','Y',90,2,2)
;

-- Sep 16, 2020, 10:33:37 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206443,'Query Criteria','The column is also used as a query criteria','The column is used to enter queries - the SQL cannot be an expression',200279,214288,'Y',1,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a332223d-88d0-4582-8038-f3e9a5c40dc2','Y',100,2,2)
;

-- Sep 16, 2020, 10:33:37 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206445,'Reference','System Reference and Validation','The Reference could be a display type, list or table validation.',200279,214290,'Y',10,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','be75ecf9-7d02-460e-a286-bc16b7fce809','Y',120,2)
;

-- Sep 16, 2020, 10:33:38 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206447,'Reference Key','Required to specify, if data type is Table or List','The Reference Value indicates where the reference values are stored.  It must be specified if the data type is Table or List.  ',200279,214292,'Y',10,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','63cf963c-c92b-4f9d-94c8-4cc5f53dd4ab','Y',140,2)
;

-- Sep 16, 2020, 10:33:38 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206448,'Dynamic Validation','Dynamic Validation Rule','These rules define how an entry is determined to valid. You can use variables for dynamic (context sensitive) validation.',200279,214293,'Y',10,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ad8fc99f-339e-4ce0-adf2-cdb7e1db56e9','Y',150,2)
;

-- Sep 16, 2020, 10:33:38 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206449,'Centrally maintained','Information maintained in System Element table','The Centrally Maintained checkbox indicates if the Name, Description and Help maintained in ''System Element'' table  or ''Window'' table.',200279,214294,'Y',1,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','94d81a7c-b761-4426-927e-58aa4ad83082','Y',160,2,2)
;

-- Sep 16, 2020, 10:33:38 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (206450,'Display Logic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
@AD_Table_ID@=14 | @Language@!GERGER <br>
@PriceLimit@>10 | @PriceList@>@PriceActual@<br>
@Name@>J<br>
Strings may be in single quotes (optional)',200279,214295,'Y',2000,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','97feaea9-fbd1-4b7a-b037-b03ee26721c5','Y',170,5,3)
;

-- Sep 16, 2020, 10:33:39 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206452,'Query Operator','Operator for database query',200279,214297,'Y',10,200,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','10107421-94ef-4971-906a-d554f65ff4ea','Y',190,2)
;

-- Sep 16, 2020, 10:33:40 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206455,'Selection Column Sequence','Selection Column Sequence','For ordering sequence of selection column',200279,214300,'Y',10,230,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c4bfa94a-2b68-47de-974c-c0fe0378dc99','Y',220,2)
;

-- Sep 16, 2020, 10:33:40 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206456,'Length','Length of the column in the database','The Length indicates the length of a column as defined in the database.',200279,214301,'Y',10,240,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3d40ca72-43b5-4f49-bdb3-c5dc8670e1a4','Y',230,2)
;

-- Sep 16, 2020, 10:33:40 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206457,'Value Format','Format of the value; Can contain fixed format elements, Variables: "_lLoOaAcCa09"','<B>Validation elements:</B>
 	(Space) any character
_	Space (fixed character)
l	any Letter a..Z NO space
L	any Letter a..Z NO space converted to upper case
o	any Letter a..Z or space
O	any Letter a..Z or space converted to upper case
a	any Letters & Digits NO space
A	any Letters & Digits NO space converted to upper case
c	any Letters & Digits or space
C	any Letters & Digits or space converted to upper case
0	Digits 0..9 NO space
9	Digits 0..9 or space

Example of format "(000)_000-0000"',200279,214302,'Y',60,250,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5e66b443-8da1-4a08-bc85-6d348dcb2e29','Y',240,5)
;

-- Sep 16, 2020, 10:33:41 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206458,'Min. Value','Minimum Value for a field','The Minimum Value indicates the lowest  allowable value for a field.',200279,214303,'Y',20,260,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3c0e88c0-5548-4243-871d-29ffce210dcb','Y',250,2)
;

-- Sep 16, 2020, 10:33:41 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206459,'Max. Value','Maximum Value for a field','The Maximum Value indicates the highest allowable value for a field',200279,214304,'Y',20,270,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','649fced1-8e54-4e16-b1ae-0639818bfd6f','Y',260,2)
;

-- Sep 16, 2020, 10:33:41 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206460,'Default Logic','Default value hierarchy, separated by ;','The defaults are evaluated in the order of definition, the first not null value becomes the default value of the column. The values are separated by comma or semicolon. a) Literals:. ''Text'' or 123 b) Variables - in format @Variable@ - Login e.g. #Date, #AD_Org_ID, #AD_Client_ID - Accounting Schema: e.g. $C_AcctSchema_ID, $C_Calendar_ID - Global defaults: e.g. DateFormat - Window values (all Picks, CheckBoxes, RadioButtons, and DateDoc/DateAcct) c) SQL code with the tag: @SQL=SELECT something AS DefaultValue FROM ... The SQL statement can contain variables.  There can be no other value other than the SQL statement. The default is only evaluated, if no user preference is defined.  Default definitions are ignored for record columns as Key, Parent, Client as well as Buttons.',200279,214305,'Y',2000,280,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3af2c09a-f1d4-4194-9b65-173a2af8e4de','Y',270,5)
;

-- Sep 16, 2020, 10:33:42 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206462,'Mandatory','Data entry is required in this column','The field must have a value for the record to be saved to the database.',200279,214307,'Y',1,300,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1b1c69a5-25d1-49b2-bb1e-aa75cae10f1f','Y',290,2,2)
;

-- Sep 16, 2020, 10:33:42 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206464,'Read Only','Field is read only','The Read Only indicates that this field may only be Read.  It may not be updated.',200279,214309,'Y',1,320,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','33e258bb-49f5-4007-8339-b7274a9fab6d','Y',310,2,2)
;

-- Sep 16, 2020, 10:33:43 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206465,'Placeholder',200279,214310,'Y',255,330,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','813f1a59-3764-45e3-9214-e0adeea8662e','Y',320,5)
;

-- Sep 16, 2020, 10:33:43 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (206466,'Input field validation','Input field validaton query','Input field validaton query',200279,214311,'Y',2000,340,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','681cad79-973b-4729-9038-a768de6a2157','Y',330,5,3)
;

-- Sep 16, 2020, 10:33:43 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206467,'Field Style','Field CSS Style ',200279,214312,'Y',10,350,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3d662531-ed79-492b-81b0-d08d0cf4db6b','Y',340,2)
;

-- Sep 16, 2020, 10:33:44 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206468,'Autocomplete','Automatic completion for textfields','The autocompletion uses all existing values (from the same client and organization) of the field.',200279,214313,'Y',1,360,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','acb3ab3e-f88e-484f-ac3f-75720877d3f6','Y',350,2,2)
;

-- Sep 16, 2020, 10:33:44 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206469,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200279,214274,'Y',1,370,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:33:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:33:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c3bee628-857f-4315-9b60-422cb7b65001','Y',360,2,2)
;

-- Sep 16, 2020, 10:34:16 AM CEST
UPDATE AD_Field SET IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 10:34:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206431
;

-- Sep 16, 2020, 10:35:32 AM CEST
UPDATE AD_Tab SET Name='Column Customization', SeqNo=20, TabLevel=1,Updated=TO_TIMESTAMP('2020-09-16 10:35:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200279
;

-- Sep 16, 2020, 10:36:54 AM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,MaxQueryRecords) VALUES (200280,'Info Window Customization',200110,10,'Y',200266,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:36:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:36:54','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',0,'N','D','Y','N','e939cff1-b690-4902-97f0-2443609cc00e','B',0)
;

-- Sep 16, 2020, 10:37:00 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206470,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200280,214228,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:36:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:36:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','25bc5758-768c-4ac7-911b-c6f300b20794','Y',10,2)
;

-- Sep 16, 2020, 10:37:00 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (206471,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200280,214229,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:37:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:37:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','43009af9-0b73-4cc6-9af9-9de872e352d1','Y','N',4,2)
;

-- Sep 16, 2020, 10:37:00 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206472,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200280,214238,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:37:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:37:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4fb3e4fb-7508-4a26-8139-a521fd641398','Y',20,5)
;

-- Sep 16, 2020, 10:37:01 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206473,'Description','Optional short description of the record','A description is limited to 255 characters.',200280,214239,'Y',255,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:37:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:37:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','790e76b3-a79d-484c-8a35-7b815a9e080f','Y',30,5)
;

-- Sep 16, 2020, 10:37:01 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (206474,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200280,214240,'Y',2000,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:37:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:37:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4a91902b-1b73-450a-88c5-864c1ae5935f','Y',40,5,3)
;

-- Sep 16, 2020, 10:37:01 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206475,'User defined Info Window',200280,214227,'N',10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:37:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:37:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','93d70a87-d7bb-4900-8477-e2314b09394c','N',2)
;

-- Sep 16, 2020, 10:37:01 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206476,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200280,214235,'Y',10,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:37:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:37:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','141c6f74-1b7c-4898-8add-34d13d6525ad','Y',50,2)
;

-- Sep 16, 2020, 10:37:02 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206477,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200280,214236,'Y',10,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:37:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:37:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','602ae35f-8474-4f3d-922b-cd0fed2edb08','Y',60,2)
;

-- Sep 16, 2020, 10:37:02 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206478,'Info Window','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.',200280,214237,'Y',10,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:37:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:37:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6308fcb5-5f1d-4aa3-8376-8fc7aa54bb53','Y',70,2)
;

-- Sep 16, 2020, 10:37:02 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206479,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200280,214241,'Y',6,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:37:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:37:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','65a5db92-f50f-4cde-a274-3edaacc2d120','Y',80,2)
;

-- Sep 16, 2020, 10:37:03 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206480,'Default','Default value','The Default Checkbox indicates if this record will be used as a default value.',200280,214242,'Y',1,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:37:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:37:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','91379bf0-28fe-4abc-af54-dfaf7824100b','Y',90,2,2)
;

-- Sep 16, 2020, 10:37:03 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206481,'Read Only','Field is read only','The Read Only indicates that this field may only be Read.  It may not be updated.',200280,214243,'Y',1,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:37:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:37:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4d42bfaf-72ce-406a-a6de-61bb4da54886','Y',100,2,2)
;

-- Sep 16, 2020, 10:37:03 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206482,'User updatable','The field can be updated by the user','The User Updatable checkbox indicate if the user can update  this field.',200280,214244,'Y',1,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:37:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:37:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3ae39f69-ef15-47be-8f41-7eacd77019dc','Y',110,2,2)
;

-- Sep 16, 2020, 10:37:03 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206483,'AD_UserDef_Info_UU',200280,214245,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:37:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:37:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c5cf65a9-aa5a-48cd-a064-9cbb06429187','N',2)
;

-- Sep 16, 2020, 10:37:04 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206484,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200280,214230,'Y',1,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:37:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:37:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f3800950-3c95-4b9d-9319-d9c249438159','Y',120,2,2)
;

-- Sep 16, 2020, 10:37:53 AM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,MaxQueryRecords) VALUES (200281,'Related Customization',200110,30,'Y',200267,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:37:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:37:52','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',0,'N','D','Y','N','b592e5b9-2a8b-4f14-8639-f7b003539224','B',0)
;

-- Sep 16, 2020, 10:38:01 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206485,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200281,214247,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:38:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:38:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8540ad53-e8c1-41ea-b0b2-218fade7afc7','Y',10,2)
;

-- Sep 16, 2020, 10:38:01 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (206486,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200281,214248,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:38:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:38:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','82d03105-cd2d-43af-be66-c349e46c373f','Y','N',4,2)
;

-- Sep 16, 2020, 10:38:01 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206487,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200281,214256,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:38:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:38:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b2eae256-2ed0-40b9-b92d-c5fcdbddff83','Y',20,5)
;

-- Sep 16, 2020, 10:38:02 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206488,'Description','Optional short description of the record','A description is limited to 255 characters.',200281,214257,'Y',255,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:38:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:38:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a14e0b20-2f08-48ef-af67-b9f0fa29b76f','Y',30,5)
;

-- Sep 16, 2020, 10:38:02 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (206489,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200281,214258,'Y',2000,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:38:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:38:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','80840f5a-cf76-435c-a26d-c200fd1c5522','Y',40,5,3)
;

-- Sep 16, 2020, 10:38:02 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206490,'User defined Info Related',200281,214246,'N',10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:38:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:38:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7a14984f-f64e-43bb-be0f-ae19ea493e8c','N',2)
;

-- Sep 16, 2020, 10:38:02 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206491,'User defined Info Window',200281,214254,'Y',10,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:38:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:38:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d1e8b5ea-e001-48e5-924e-859ed79b6cdc','Y',50,2)
;

-- Sep 16, 2020, 10:38:03 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206492,'InfoRelated',200281,214255,'Y',10,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:38:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:38:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a8d3e0c3-a6d7-4209-8200-a5375131df0a','Y',60,2)
;

-- Sep 16, 2020, 10:38:03 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206495,'AD_UserDef_Info_Related_UU',200281,214261,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:38:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:38:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','091580eb-5bd1-4be2-b866-3d3dd920054f','N',2)
;

-- Sep 16, 2020, 10:38:04 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206497,'Context Help',200281,214263,'Y',10,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:38:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:38:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0df0940b-3f6d-4cfd-9908-e54d39b5db0d','Y',100,2)
;

-- Sep 16, 2020, 10:38:04 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206498,'Displayed','Determines, if this field is displayed','If the field is displayed, the field Display Logic will determine at runtime, if it is actually displayed',200281,214264,'Y',1,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:38:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:38:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','944d9461-53d1-46f0-bf96-af1a052db781','Y',110,2,2)
;

-- Sep 16, 2020, 10:38:05 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (206500,'Display Logic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
@AD_Table_ID@=14 | @Language@!GERGER <br>
@PriceLimit@>10 | @PriceList@>@PriceActual@<br>
@Name@>J<br>
Strings may be in single quotes (optional)',200281,214266,'Y',2000,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:38:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:38:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7a5af0d4-bf0a-44ec-b11a-fc2814adbb70','Y',130,5,3)
;

-- Sep 16, 2020, 10:38:05 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206501,'Related Info Window',200281,214267,'Y',10,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:38:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:38:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3dec6061-052f-44cb-b21b-82f853b08085','Y',140,2)
;

-- Sep 16, 2020, 10:38:06 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206502,'Related Info Column',200281,214268,'Y',10,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:38:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:38:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0362744b-ab59-4fec-a65a-bca8f01e725a','Y',150,2)
;

-- Sep 16, 2020, 10:38:06 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206503,'Parent Related Column','column in parent info window, link with column in this relate info','default column RelatedColumn in Relate Info window will link with key column of main info window
column define in ParentRelatedColumn will replace key column',200281,214269,'Y',10,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:38:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:38:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','44c6bf05-6d8b-49f3-a637-91e04ecb67d3','Y',160,2)
;

-- Sep 16, 2020, 10:38:06 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206504,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200281,214270,'Y',10,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:38:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:38:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','51d6bf36-4654-4591-9cee-4c7e00cf9ef4','Y',170,2)
;

-- Sep 16, 2020, 10:38:06 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206505,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200281,214249,'Y',1,190,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:38:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:38:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8aa5de2b-f9c0-4333-a302-dd572a688fc0','Y',180,2,2)
;

-- Sep 16, 2020, 10:38:52 AM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,"action",AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200174,'Info Window Customization','Define Info Window Customization for Role/User','W',200110,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:38:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:38:52','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','D','Y','b13e8923-8016-46ee-a687-0e12ca0a8391')
;

-- Sep 16, 2020, 10:38:52 AM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200174, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200174)
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200145
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200142
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53203
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=586
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=138
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=139
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200065
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200063
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=249
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=141
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=300
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=589
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200000
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=295
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=14, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=216
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=15, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=140
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=16, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=142
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=17, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53012
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=18, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=143
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=19, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=201
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=20, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=176
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=21, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200072
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=22, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53086
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=23, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=239
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=24, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=517
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=25, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=499
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=26, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200150
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=27, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200174
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=28, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53089
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=29, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53090
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=30, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200038
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=31, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200143
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=32, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200141
;

-- Sep 16, 2020, 10:40:23 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=33, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=50001
;

-- Sep 16, 2020, 10:41:53 AM CEST
UPDATE AD_Table SET AD_Window_ID=200110,Updated=TO_TIMESTAMP('2020-09-16 10:41:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200266
;

-- Sep 16, 2020, 10:42:26 AM CEST
UPDATE AD_Tab SET TabLevel=1,Updated=TO_TIMESTAMP('2020-09-16 10:42:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200281
;

-- Sep 16, 2020, 10:43:09 AM CEST
UPDATE AD_Field SET IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 10:43:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206470
;

-- Sep 16, 2020, 10:43:22 AM CEST
UPDATE AD_Field SET IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 10:43:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206485
;

-- Sep 16, 2020, 10:45:24 AM CEST
UPDATE AD_Column SET DefaultValue='@AD_UserDef_Info_ID@',Updated=TO_TIMESTAMP('2020-09-16 10:45:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214254
;

-- Sep 16, 2020, 10:50:20 AM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200177,'AD_InfoWindow','T',0,0,'Y',TO_TIMESTAMP('2020-09-16 10:50:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:50:19','YYYY-MM-DD HH24:MI:SS'),100,'D','N','33db9fbc-d7dd-4db2-b3e1-bc18939dc740')
;

-- Sep 16, 2020, 10:50:43 AM CEST
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200177,895,15744,15752,0,0,'Y',TO_TIMESTAMP('2020-09-16 10:50:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 10:50:43','YYYY-MM-DD HH24:MI:SS'),100,'N','D','f38854e3-f742-4139-b3fb-860f248f230b')
;

-- Sep 16, 2020, 10:50:51 AM CEST
UPDATE AD_Column SET AD_Reference_ID=18, AD_Reference_Value_ID=200177,Updated=TO_TIMESTAMP('2020-09-16 10:50:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214255
;

-- Sep 16, 2020, 10:55:53 AM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=200065,Updated=TO_TIMESTAMP('2020-09-16 10:55:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214279
;

-- Sep 16, 2020, 10:58:12 AM CEST
INSERT INTO t_alter_column values('ad_userdef_info_column','SelectClause','VARCHAR(2000)',null,'NULL')
;

-- Sep 16, 2020, 10:58:12 AM CEST
INSERT INTO t_alter_column values('ad_userdef_info_column','SelectClause',null,'NULL',null)
;

-- Sep 16, 2020, 10:58:32 AM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2020-09-16 10:58:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214290
;

-- Sep 16, 2020, 10:58:33 AM CEST
UPDATE AD_Column SET FKConstraintName='adreference_aduserdefcolumn', FKConstraintType='N',Updated=TO_TIMESTAMP('2020-09-16 10:58:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214290
;

-- Sep 16, 2020, 10:58:33 AM CEST
INSERT INTO t_alter_column values('ad_userdef_info_column','AD_Reference_ID','NUMERIC(10)',null,'NULL')
;

-- Sep 16, 2020, 10:58:33 AM CEST
INSERT INTO t_alter_column values('ad_userdef_info_column','AD_Reference_ID',null,'NULL',null)
;

-- Sep 16, 2020, 10:58:51 AM CEST
INSERT INTO t_alter_column values('ad_userdef_info_column','ColumnName','VARCHAR(30)',null,'NULL')
;

-- Sep 16, 2020, 10:58:51 AM CEST
INSERT INTO t_alter_column values('ad_userdef_info_column','ColumnName',null,'NULL',null)
;

-- Sep 16, 2020, 11:01:28 AM CEST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206447
;

-- Sep 16, 2020, 11:01:28 AM CEST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206448
;

-- Sep 16, 2020, 11:01:28 AM CEST
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206449
;

-- Sep 16, 2020, 11:01:28 AM CEST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206450
;

-- Sep 16, 2020, 11:01:28 AM CEST
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206452
;

-- Sep 16, 2020, 11:01:28 AM CEST
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206455
;

-- Sep 16, 2020, 11:01:28 AM CEST
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206456
;

-- Sep 16, 2020, 11:01:28 AM CEST
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206457
;

-- Sep 16, 2020, 11:01:28 AM CEST
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206458
;

-- Sep 16, 2020, 11:01:28 AM CEST
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206459
;

-- Sep 16, 2020, 11:01:28 AM CEST
UPDATE AD_Field SET SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206460
;

-- Sep 16, 2020, 11:01:28 AM CEST
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206462
;

-- Sep 16, 2020, 11:01:28 AM CEST
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206464
;

-- Sep 16, 2020, 11:01:28 AM CEST
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206465
;

-- Sep 16, 2020, 11:01:28 AM CEST
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206466
;

-- Sep 16, 2020, 11:01:28 AM CEST
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206467
;

-- Sep 16, 2020, 11:01:28 AM CEST
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206468
;

-- Sep 16, 2020, 11:01:28 AM CEST
UPDATE AD_Field SET SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206469
;

-- Sep 16, 2020, 11:01:28 AM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206438
;

-- Sep 16, 2020, 11:01:28 AM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206436
;

-- Sep 16, 2020, 11:03:25 AM CEST
INSERT INTO AD_UserDef_Win (AD_UserDef_Win_ID,AD_Client_ID,AD_Org_ID,AD_User_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Window_ID,Name,Description,Help,AD_Language,IsDefault,IsReadOnly,IsUserUpdateable,AD_Role_ID,AD_UserDef_Win_UU) VALUES (200001,0,0,100,'Y',TO_TIMESTAMP('2020-09-16 11:03:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 11:03:24','YYYY-MM-DD HH24:MI:SS'),100,276,'Alert','iDempiere Alert','iDempiere Alerts allow you define system conditions you want to be alerted of','en_US','N','N','N',0,'31f22b81-d636-4393-be32-b0b6e5dfcffd')
;

-- Sep 16, 2020, 11:03:29 AM CEST
INSERT INTO AD_UserDef_Tab (AD_UserDef_Tab_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_UserDef_Win_ID,AD_Tab_ID,Name,Description,Help,IsSingleRow,IsReadOnly,IsMultiRowOnly,AD_UserDef_Tab_UU) VALUES (200001,0,0,'Y',TO_TIMESTAMP('2020-09-16 11:03:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 11:03:29','YYYY-MM-DD HH24:MI:SS'),100,200001,505,'Alert Rule','Definition of the alert element','The definition of the altert or action','Y','N','N','6a3ab19a-9c22-4144-abc6-6525558fa2bb')
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206437
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206433
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206434
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206435
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206469
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206443
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206455
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206442
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206464
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206449
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206462
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206450
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206465
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206452
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206466
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206456
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206468
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206457
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206458
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206459
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206467
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206460
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=270, AD_FieldGroup_ID=200004, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206445
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206448
;

-- Sep 16, 2020, 11:14:03 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206447
;

-- Sep 16, 2020, 11:22:35 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:22:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206460
;

-- Sep 16, 2020, 11:22:35 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:22:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206467
;

-- Sep 16, 2020, 11:22:35 AM CEST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:22:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206468
;

-- Sep 16, 2020, 11:22:35 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:22:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206465
;

-- Sep 16, 2020, 11:22:35 AM CEST
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:22:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206445
;

-- Sep 16, 2020, 11:22:35 AM CEST
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:22:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206448
;

-- Sep 16, 2020, 11:22:35 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:22:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206447
;

-- Sep 16, 2020, 11:22:35 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:22:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206452
;

-- Sep 16, 2020, 11:22:35 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:22:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206456
;

-- Sep 16, 2020, 11:22:35 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:22:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206458
;

-- Sep 16, 2020, 11:22:35 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:22:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206459
;

-- Sep 16, 2020, 11:22:35 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:22:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206457
;

-- Sep 16, 2020, 11:22:35 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:22:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206466
;

-- Sep 16, 2020, 11:25:27 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:25:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206491
;

-- Sep 16, 2020, 11:25:27 AM CEST
UPDATE AD_Field SET SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:25:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206487
;

-- Sep 16, 2020, 11:25:27 AM CEST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:25:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206488
;

-- Sep 16, 2020, 11:25:27 AM CEST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:25:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206489
;

-- Sep 16, 2020, 11:25:27 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:25:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206505
;

-- Sep 16, 2020, 11:25:27 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:25:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206504
;

-- Sep 16, 2020, 11:25:27 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:25:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206500
;

-- Sep 16, 2020, 11:25:27 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:25:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206497
;

-- Sep 16, 2020, 11:25:27 AM CEST
UPDATE AD_Field SET SeqNo=170, AD_FieldGroup_ID=200004, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:25:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206501
;

-- Sep 16, 2020, 11:25:27 AM CEST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:25:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206502
;

-- Sep 16, 2020, 11:25:27 AM CEST
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:25:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206503
;

-- Sep 16, 2020, 11:25:27 AM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:25:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206495
;

-- Sep 16, 2020, 11:25:27 AM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:25:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206490
;

-- Sep 16, 2020, 11:27:35 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:27:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206498
;

-- Sep 16, 2020, 11:27:35 AM CEST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:27:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206500
;

-- Sep 16, 2020, 11:27:35 AM CEST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:27:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206497
;

-- Sep 16, 2020, 11:27:35 AM CEST
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:27:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206501
;

-- Sep 16, 2020, 11:27:35 AM CEST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:27:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206502
;

-- Sep 16, 2020, 11:27:35 AM CEST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:27:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206503
;

-- Sep 16, 2020, 11:30:46 AM CEST
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:30:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206498
;

-- Sep 16, 2020, 11:30:46 AM CEST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:30:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206504
;

-- Sep 16, 2020, 11:30:46 AM CEST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:30:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206500
;

-- Sep 16, 2020, 11:30:46 AM CEST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:30:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206497
;

-- Sep 16, 2020, 11:30:46 AM CEST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:30:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206501
;

-- Sep 16, 2020, 11:30:46 AM CEST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:30:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206502
;

-- Sep 16, 2020, 11:30:46 AM CEST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:30:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206503
;

-- Sep 16, 2020, 11:33:48 AM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:33:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206503
;

-- Sep 16, 2020, 11:33:48 AM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:33:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206502
;

-- Sep 16, 2020, 11:33:48 AM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:33:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206501
;

-- Sep 16, 2020, 11:34:15 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:34:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206504
;

-- Sep 16, 2020, 11:34:15 AM CEST
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:34:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206505
;

-- Sep 16, 2020, 11:34:15 AM CEST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:34:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206498
;

-- Sep 16, 2020, 11:34:15 AM CEST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:34:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206497
;

-- Sep 16, 2020, 11:34:15 AM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:34:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206500
;

-- Sep 16, 2020, 11:38:16 AM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200141,'AD_InfoRelated Windows','S','AD_InfoRelated.AD_InfoWindow_ID=@AD_InfoWindow_ID@',0,0,'Y',TO_TIMESTAMP('2020-09-16 11:38:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 11:38:15','YYYY-MM-DD HH24:MI:SS'),100,'D','1857d9ec-905b-4352-922d-dd9e46fab36c')
;

-- Sep 16, 2020, 11:38:26 AM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=200141,Updated=TO_TIMESTAMP('2020-09-16 11:38:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214255
;

-- Sep 16, 2020, 11:39:44 AM CEST
UPDATE AD_Field SET IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:39:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206491
;

-- Sep 16, 2020, 11:41:36 AM CEST
UPDATE AD_Column SET AD_Reference_ID=19, AD_Reference_Value_ID=NULL,Updated=TO_TIMESTAMP('2020-09-16 11:41:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214255
;

-- Sep 16, 2020, 11:46:44 AM CEST
INSERT INTO AD_InfoWindow (AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Table_ID,EntityType,FromClause,Processing,AD_InfoWindow_UU,IsDefault,IsDistinct,IsValid,SeqNo,IsShowInDashboard,MaxQueryRecords,isLoadPageNum,PagingSize) VALUES (200015,0,0,'Y',TO_TIMESTAMP('2020-09-16 11:46:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 11:46:44','YYYY-MM-DD HH24:MI:SS'),100,'Product Purchase Info',210,'U','M_Product_PO a','N','aee3ecea-a66d-4038-88c5-7f4b2cfe1aae','N','N','N',90,'N',0,'Y',0)
;

-- Sep 16, 2020, 11:47:11 AM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200159,0,0,'Y',TO_TIMESTAMP('2020-09-16 11:47:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 11:47:11','YYYY-MM-DD HH24:MI:SS'),100,'Product','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.',200015,'U','a.M_Product_ID',10,'Y','N',454,30,'ce4b2170-24ea-4536-a7f2-329f40c54bc3',231,'Y','M_Product_ID','N',0,'N','N','Y','N')
;

-- Sep 16, 2020, 11:47:11 AM CEST
UPDATE AD_InfoWindow SET IsValid='Y',Updated=TO_TIMESTAMP('2020-09-16 11:47:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200015
;

-- Sep 16, 2020, 11:47:23 AM CEST
UPDATE AD_InfoColumn SET EntityType='D',Updated=TO_TIMESTAMP('2020-09-16 11:47:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200159
;

-- Sep 16, 2020, 11:47:35 AM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200160,0,0,'Y',TO_TIMESTAMP('2020-09-16 11:47:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 11:47:35','YYYY-MM-DD HH24:MI:SS'),100,'Business Partner ','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',200015,'D','a.C_BPartner_ID',20,'Y','N',187,30,'a29cc2fe-1e5d-485a-952a-446e72010ef6',230,'Y','C_BPartner_ID','N',0,'N','N','Y','N')
;

-- Sep 16, 2020, 11:47:44 AM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200161,0,0,'Y',TO_TIMESTAMP('2020-09-16 11:47:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 11:47:44','YYYY-MM-DD HH24:MI:SS'),100,'Current vendor','Use this Vendor for pricing and stock replenishment','The Current Vendor indicates if prices are used and Product is reordered from this vendor',200015,'D','a.IsCurrentVendor',30,'Y','N',1235,20,'f9b88e52-4fd0-4146-9c2a-91add825f530','Y','IsCurrentVendor','N',0,'N','N','Y','N')
;

-- Sep 16, 2020, 11:47:56 AM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200162,0,0,'Y',TO_TIMESTAMP('2020-09-16 11:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 11:47:56','YYYY-MM-DD HH24:MI:SS'),100,'Minimum Order Qty','Minimum order quantity in UOM','The Minimum Order Quantity indicates the smallest quantity of this product which can be ordered.',200015,'D','a.Order_Min',40,'Y','N',942,29,'00d8b136-a007-4c77-86f4-bfda284d2a06','Y','Order_Min','N',0,'N','N','Y','N')
;

-- Sep 16, 2020, 11:48:12 AM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200163,0,0,'Y',TO_TIMESTAMP('2020-09-16 11:48:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 11:48:11','YYYY-MM-DD HH24:MI:SS'),100,'Order Pack Qty','Package order size in UOM (e.g. order set of 5 units)','The Order Pack Quantity indicates the number of units in each pack of this product.',200015,'D','a.Order_Pack',50,'Y','N',943,29,'2b088938-b725-417b-8ee0-2765c58bdb63','Y','Order_Pack','N',0,'N','N','Y','N')
;

-- Sep 16, 2020, 11:48:27 AM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200164,0,0,'Y',TO_TIMESTAMP('2020-09-16 11:48:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 11:48:27','YYYY-MM-DD HH24:MI:SS'),100,'Last PO Price','Price of the last purchase order for the product','The Last PO Price indicates the last price paid (per the purchase order) for this product.',200015,'D','a.PriceLastPO',60,'Y','N',954,37,'b5b3398b-65d5-4273-a6f9-b4616ad93206','Y','PriceLastPO','N',0,'N','N','Y','N')
;

-- Sep 16, 2020, 11:48:44 AM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200165,0,0,'Y',TO_TIMESTAMP('2020-09-16 11:48:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 11:48:44','YYYY-MM-DD HH24:MI:SS'),100,'Last Invoice Price','Price of the last invoice for the product','The Last Invoice Price indicates the last price paid (per the invoice) for this product.',200015,'D','a.PriceLastInv',70,'Y','N',1740,37,'3e56304f-90a6-4ac3-87c0-75f56b43837f','Y','PriceLastInv','N',0,'N','N','Y','N')
;

-- Sep 16, 2020, 11:48:54 AM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200166,0,0,'Y',TO_TIMESTAMP('2020-09-16 11:48:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 11:48:54','YYYY-MM-DD HH24:MI:SS'),100,'List Price','List Price','The List Price is the official List Price in the document currency.',200015,'D','a.PriceList',80,'Y','N',520,37,'40f7f31f-cc96-4aad-b3cb-c1db3d897b01','Y','PriceList','N',0,'N','N','Y','N')
;

-- Sep 16, 2020, 11:49:04 AM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200167,0,0,'Y',TO_TIMESTAMP('2020-09-16 11:49:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 11:49:04','YYYY-MM-DD HH24:MI:SS'),100,'PO Price','Price based on a purchase order','The PO Price indicates the price for a product per the purchase order.',200015,'D','a.PricePO',90,'Y','N',1124,37,'0879e5af-2d08-40bc-9674-2566c2d3a683','Y','PricePO','N',0,'N','N','Y','N')
;

-- Sep 16, 2020, 11:49:12 AM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200168,0,0,'Y',TO_TIMESTAMP('2020-09-16 11:49:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 11:49:11','YYYY-MM-DD HH24:MI:SS'),100,'Partner Product Key','Product Key of the Business Partner','The Business Partner Product Key identifies the number used by the Business Partner for this product. It can be printed on orders and invoices when you include the Product Key in the print format.',200015,'D','a.VendorProductNo',100,'Y','N',623,10,'2118e489-70ca-43f8-812b-ef1786c0d2ae','Y','VendorProductNo','N',0,'N','N','Y','N')
;

-- Sep 16, 2020, 11:49:21 AM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200169,0,0,'Y',TO_TIMESTAMP('2020-09-16 11:49:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 11:49:21','YYYY-MM-DD HH24:MI:SS'),100,'UOM','Unit of Measure','The UOM defines a unique non monetary Unit of Measure',200015,'D','a.C_UOM_ID',110,'Y','N',215,19,'1dc7c34b-6851-4575-8a01-388d5515bc23','Y','C_UOM_ID','N',0,'N','N','Y','N')
;

-- Sep 16, 2020, 11:49:39 AM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200170,0,0,'Y',TO_TIMESTAMP('2020-09-16 11:49:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 11:49:39','YYYY-MM-DD HH24:MI:SS'),100,'Promised Delivery Time','Promised days between order and delivery','The Promised Delivery Time indicates the number of days between the order date and the date that delivery was promised.',200015,'D','a.DeliveryTime_Promised',120,'Y','N',1256,11,'4a3949d2-dd87-43c8-ab36-eda99f03ed05','Y','DeliveryTime_Promised','N',0,'N','N','Y','N')
;

-- Sep 16, 2020, 11:50:57 AM CEST
INSERT INTO AD_InfoRelated (AD_InfoRelated_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_InfoWindow_ID,SeqNo,RelatedInfo_ID,RelatedColumn_ID,AD_InfoRelated_UU,EntityType) VALUES (200000,0,0,'Y',TO_TIMESTAMP('2020-09-16 11:50:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-09-16 11:50:56','YYYY-MM-DD HH24:MI:SS'),100,'Purchase PO',200000,10,200015,200159,'53e668d0-7d0d-4a2b-af19-a483e84fc505','D')
;

SELECT register_migration_script('202009161020_IDEMPIERE-4459.sql') FROM dual
;
