CREATE OR REPLACE VIEW ad_sessioninfo_v AS 
 SELECT s.ad_session_id, 0::numeric(10,0) AS ad_client_id, 0::numeric(10,0) AS  ad_org_id, s.isactive, 
		s.created, s.createdby, s.updated, s.updatedby, s.websession, 
		s.remote_addr, s.remote_host, s.ad_role_id, s.logindate, s.ad_session_uu, 
		s.servername, s.ad_client_id AS login_client_id,createdby as ad_user_id,s.ad_org_id as login_org_id,s.ad_session_id as ad_sessioninfo_v_id,
		s.ad_session_uu as ad_sessioninfo_v_uu
   FROM ad_session s
  WHERE s.processed = 'N'::bpchar;