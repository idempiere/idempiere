CREATE OR REPLACE FUNCTION IsMemberOfAcctSchema( p_AD_Client_ID NUMBER , p_AD_Org_ID NUMBER , p_C_AcctSchema_ID NUMBER )
RETURN boolean AS
 v_ad_org_id NUMBER ;
 v_count NUMBER ;
BEGIN
v_ad_org_id := -1;
v_count :=0 ;
SELECT count(*) into v_count from C_AcctSchema c
Where C_AcctSchema_ID <> p_C_AcctSchema_ID
and AD_OrgOnly_ID= p_AD_Org_ID;


if (v_count = 0 ) Then
	WITH tr(level, parent_name, name, ad_org_id) as (
	 select 0, null as parentName, ad_org.name, tn.node_id
	 from ad_tree t
	 join ad_treenode tn on t.ad_tree_id=tn.ad_tree_id
	 join ad_org on tn.node_id=ad_org.ad_org_id
	 join c_acctschema ca on ad_org.ad_org_id=ca.AD_OrgOnly_ID and ca.C_AcctSchema_ID=p_C_AcctSchema_ID
	 where t.treetype='OO' AND t.ad_client_id= p_AD_Client_ID
	 and ((tn.parent_id = 0 and ad_org.issummary='Y') or (ad_org.ad_org_id=p_AD_Org_ID))
	   UNION ALL select level+1, tr.name, ad_org.name, tn.node_id
	 from ad_tree t
	 join ad_treenode tn on t.ad_tree_id=tn.ad_tree_id
	 join ad_org on tn.node_id=ad_org.ad_org_id
	 join tr on tr.ad_org_id=tn.parent_id
			where tn.node_id=p_AD_Org_ID)
	 select ad_org_id into v_ad_org_id from tr where ad_org_id=p_ad_org_id;
END IF;

   return v_ad_org_id=p_ad_org_id;
END;
/
