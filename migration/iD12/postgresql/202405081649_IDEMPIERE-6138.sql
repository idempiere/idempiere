-- define label for context meu of gridview columns (IDEMPIERE-6138 freeze any column on grid)
SELECT register_migration_script('202405081649_IDEMPIERE-6138.sql') FROM dual;

-- May 8, 2024, 4:49:50 PM ICT
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Freeze Column','Freeze this column to keep it visible when scrolling horizontally',0,0,'Y',TO_TIMESTAMP('2024-05-08 16:49:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-05-08 16:49:50','YYYY-MM-DD HH24:MI:SS'),100,200895,'FrozenColumnContextMenuLabel','D','0b139c87-3c66-460f-ab27-692afcf693f8')
;

-- May 8, 2024, 4:55:35 PM ICT
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Reset Freeze Column','Reset freeze to indicator column (default)',0,0,'Y',TO_TIMESTAMP('2024-05-08 16:55:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-05-08 16:55:35','YYYY-MM-DD HH24:MI:SS'),100,200896,'ResetFrozenColumnContextMenuLabel','D','d7a3119c-b7fa-4825-81e6-cec12676b219')
;

