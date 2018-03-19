SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 11, 2015 10:13:08 AM CET
-- IDEMPIERE-2509 ResetLockedAccount messages are hardcoded
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Message_UU,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200331,'2483519c-32fb-496d-86d0-55b59ec42939',0,TO_DATE('2015-03-11 10:13:07','YYYY-MM-DD HH24:MI:SS'),100,'U','Y','User {0} is not locked','I',TO_DATE('2015-03-11 10:13:07','YYYY-MM-DD HH24:MI:SS'),100,'UserIsNotLocked')
;

-- Mar 11, 2015 10:13:29 AM CET
UPDATE AD_Message SET EntityType='D',Updated=TO_DATE('2015-03-11 10:13:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200331
;

-- Mar 11, 2015 10:13:41 AM CET
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Message_UU,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200332,'04e54944-1af1-4d0c-89a6-0240201e529e',0,TO_DATE('2015-03-11 10:13:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Could not unlock user account','I',TO_DATE('2015-03-11 10:13:41','YYYY-MM-DD HH24:MI:SS'),100,'CouldNotUnlockAccount')
;

-- Mar 11, 2015 10:14:11 AM CET
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Message_UU,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200333,'a84c1b33-f127-4b3b-a526-a2fd35efafa7',0,TO_DATE('2015-03-11 10:14:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','The user {0} has been unlocked','I',TO_DATE('2015-03-11 10:14:11','YYYY-MM-DD HH24:MI:SS'),100,'UserUnlocked')
;

-- Mar 11, 2015 10:14:23 AM CET
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Message_UU,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200334,'9857d80f-65fd-465b-98ec-398644fd93cf',0,TO_DATE('2015-03-11 10:14:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','locked account has been reset','I',TO_DATE('2015-03-11 10:14:22','YYYY-MM-DD HH24:MI:SS'),100,'LockedAccountResetted')
;

SELECT register_migration_script('201503111036_IDEMPIERE-2509.sql') FROM dual
;
