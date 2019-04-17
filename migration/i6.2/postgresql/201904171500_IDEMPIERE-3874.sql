-- IDEMPIERE-3874 Process Recalculate Cube not loading GL journal facts due to c_calendar_id
-- Apr 17, 2019, 4:14:39 PM MYT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200134,'C_Period Open For OrgInfo/ClientInfo Calendar','S','((EXISTS (SELECT 1 FROM C_Period a 
JOIN C_Year b ON a.C_Year_ID=b.C_Year_ID 
JOIN C_Calendar c ON b.C_Calendar_ID=c.C_Calendar_ID 
WHERE ((c.C_Calendar_ID=(SELECT AD_OrgInfo.C_Calendar_ID FROM AD_OrgInfo WHERE AD_OrgInfo.AD_Org_ID=@AD_Org_ID@)) OR
((EXISTS (SELECT 1 FROM AD_OrgInfo WHERE AD_OrgInfo.AD_Org_ID=@AD_Org_ID@ AND AD_OrgInfo.C_Calendar_ID IS NULL)) AND
(c.C_Calendar_ID=(SELECT AD_ClientInfo.C_Calendar_ID FROM AD_ClientInfo WHERE AD_ClientInfo.AD_Client_ID=@#AD_Client_ID@))))
AND a.IsActive=''Y'' AND b.IsActive=''Y'' AND a.C_Period_ID=C_Period.C_Period_ID)) AND
(EXISTS ( SELECT * FROM C_PeriodControl pc WHERE C_Period.C_Period_ID = pc.C_Period_ID AND pc.PeriodStatus = ''O'') 
OR EXISTS ( SELECT * FROM C_AcctSchema a, C_Period p WHERE C_Period.C_Period_ID = p.C_Period_ID AND a.AutoPeriodControl = ''Y''
AND a.C_AcctSchema_ID=@C_AcctSchema_ID@ 
AND ( (p.StartDate BETWEEN SYSDATE - a.Period_OpenHistory AND SYSDATE + a.Period_OpenFuture) 
OR (p.EndDate BETWEEN SYSDATE - a.Period_OpenHistory AND SYSDATE + a.Period_OpenFuture)))))',0,0,'Y',TO_TIMESTAMP('2019-04-17 16:14:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-04-17 16:14:38','YYYY-MM-DD HH24:MI:SS'),100,'D','017034e9-6be4-4810-9aa1-88d4aa044def')
;

-- Apr 17, 2019, 4:15:57 PM MYT
UPDATE AD_Column SET AD_Val_Rule_ID=200134,Updated=TO_TIMESTAMP('2019-04-17 16:15:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1654
;

-- Apr 17, 2019, 4:16:43 PM MYT
UPDATE AD_Column SET AD_Val_Rule_ID=200134,Updated=TO_TIMESTAMP('2019-04-17 16:16:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1636
;

SELECT register_migration_script('201904171500_IDEMPIERE-3874.sql') FROM dual
;

