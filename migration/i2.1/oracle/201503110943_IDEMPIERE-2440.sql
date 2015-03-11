SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2440
-- Mar 11, 2015 9:43:16 AM COT
UPDATE AD_Column SET FieldLength=60,Updated=TO_DATE('2015-03-11 09:43:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200702
;

CREATE OR REPLACE VIEW ad_sessioninfo_v AS 
 SELECT s.ad_session_id,0 as ad_client_id,0 as ad_org_id, s.isactive,
                s.created, s.createdby, s.updated, s.updatedby,  substr(s.websession,1,40) as websession,
                substr(s.remote_addr,1,60) as remote_addr, substr(s.remote_host,1,120) as remote_host, substr(r.name,1,60) as roleName, s.logindate, s.ad_session_uu,
                substr(s.servername,1,80) as servername, substr(c.name,1,60) AS ClientName,substr(o.name,1,60) as orgName,s.ad_session_id as ad_sessioninfo_v_id,
                s.ad_session_uu as ad_sessioninfo_v_uu,substr(u.name,1,60) as LoginName,substr(u.email,1,60) as email
   FROM ad_session s
   inner join AD_User u on (s.createdby = u.AD_User_ID)
   left join AD_Role r on (s.ad_role_id=r.ad_role_id)
   inner join AD_Client c on (s.ad_client_id=c.ad_client_id)
   left join AD_Org o on (s.ad_org_id=o.ad_org_id)
  WHERE s.processed = 'N'
;

SELECT register_migration_script('201503110943_IDEMPIERE-2440.sql') FROM dual
;

