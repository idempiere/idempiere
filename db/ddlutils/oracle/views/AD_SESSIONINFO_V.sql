CREATE OR REPLACE VIEW ad_sessioninfo_v AS 
 SELECT s.ad_session_id,0 as ad_client_id,0 as ad_org_id, s.isactive, 
		s.created, s.createdby, s.updated, s.updatedby, s.websession, 
		s.remote_addr, s.remote_host, r.name as roleName, s.logindate, s.ad_session_uu, 
		s.servername,  c.name AS ClientName,o.name as orgName,s.ad_session_id as ad_sessioninfo_v_id,
		s.ad_session_uu as ad_sessioninfo_v_uu,u.name as LoginName,u.email as email
   FROM ad_session s
   inner join AD_User u on (s.createdby = u.AD_User_ID)
   left join AD_Role r on (s.ad_role_id=r.ad_role_id)
   inner join AD_Client c on (s.ad_client_id=c.ad_client_id)
   left join AD_Org o on (s.ad_org_id=o.ad_org_id)
  WHERE s.processed = 'N';