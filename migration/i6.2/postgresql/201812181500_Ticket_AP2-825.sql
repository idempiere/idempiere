-- Dec 18, 2018 10:50:26 AM MYT
-- AP2-825 Match PO | M_MatchPO unposted in Prod
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Ref_List_UU,Name,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Created,Updated,EntityType,AD_Reference_ID,Value,AD_Org_ID) VALUES (200448,'0630b5d2-0fe4-4ef8-9d2f-a14791c02c7d','Deferred','Y',100,100,0,TO_TIMESTAMP('2018-12-18 10:50:25','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2018-12-18 10:50:25','YYYY-MM-DD HH24:MI:SS'),'D',234,'d',0)
;

SELECT register_migration_script('201812181500_Ticket_AP2-825.sql') FROM dual
;

