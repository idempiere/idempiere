CREATE OR REPLACE FUNCTION ismemberofacctschema(p_ad_client_id numeric, p_ad_org_id numeric, p_c_acctschema_id numeric)
 RETURNS boolean
 LANGUAGE plpgsql
AS $BODY$
DECLARE
 v_ad_org_id numeric;
 v_count numeric;
BEGIN
v_ad_org_id = -1;
v_count = 0;

SELECT count(*) into v_count from C_AcctSchema c 
Where C_AcctSchema_ID <> p_C_AcctSchema_ID
and AD_OrgOnly_ID= p_AD_Org_ID;


if (v_count = 0 ) Then
  WITH RECURSIVE tr( ad_org_id) as (
	select tn.node_id 
	from ad_tree t
	join ad_treenode tn on t.ad_tree_id=tn.ad_tree_id
	join ad_org on tn.node_id=ad_org.ad_org_id
	join c_acctschema ca on ad_org.ad_org_id=ca.AD_OrgOnly_ID and ca.C_AcctSchema_ID=p_C_AcctSchema_ID
	where t.treetype='OO' AND t.ad_client_id= p_AD_Client_ID 
	and ((tn.parent_id = 0 and ad_org.issummary='Y') or (ad_org.ad_org_id=p_AD_Org_ID))
   UNION select tn.node_id
	from ad_tree t
	join ad_treenode tn on t.ad_tree_id=tn.ad_tree_id
	join ad_org on tn.node_id=ad_org.ad_org_id
	join tr on tr.ad_org_id=tn.parent_id 
	where tn.node_id=p_AD_Org_ID)
	select ad_org_id into v_ad_org_id from tr where ad_org_id=p_ad_org_id;
End If;
   return v_ad_org_id=p_ad_org_id;
END;
$BODY$
;
