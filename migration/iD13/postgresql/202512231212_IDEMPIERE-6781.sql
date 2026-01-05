-- IDEMPIERE-6781 Currency dropdown values not loading in Cost Adjustment screen (Oracle server)
SELECT register_migration_script('202512231212_IDEMPIERE-6781.sql') FROM dual;

-- Dec 23, 2025, 12:12:05 PM IST
UPDATE AD_Val_Rule SET Code='C_Currency_ID in (SELECT C_Currency_ID FROM C_AcctSchema Where AD_Client_ID = @AD_Client_ID@ AND (IsMemberOfAcctSchema(AD_Client_ID,@AD_Org_ID@,C_AcctSchema_ID)=''Y'' OR AD_OrgOnly_ID Is NULL ))',Updated=TO_TIMESTAMP('2025-12-23 12:12:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200091
;


DROP FUNCTION ismemberofacctschema(numeric, numeric, numeric)
;


CREATE OR REPLACE FUNCTION ismemberofacctschema (
	p_ad_client_id NUMERIC,
	p_ad_org_id NUMERIC,
	p_c_acctschema_id NUMERIC
	)
RETURNS CHAR LANGUAGE plpgsql AS $FUNCTION$

DECLARE
	v_ad_org_id NUMERIC;
	v_count NUMERIC;

BEGIN
	v_ad_org_id = - 1;
	v_count = 0;

	SELECT count(1)
	INTO v_count
	FROM C_AcctSchema c
	WHERE C_AcctSchema_ID <> p_C_AcctSchema_ID AND AD_OrgOnly_ID = p_AD_Org_ID;

	IF (v_count = 0) Then WITH RECURSIVE tr(ad_org_id) AS
	(
			SELECT tn.node_id
			FROM ad_tree t
			INNER JOIN ad_treenode tn ON t.ad_tree_id = tn.ad_tree_id
			INNER JOIN ad_org ON tn.node_id = ad_org.ad_org_id
			INNER JOIN c_acctschema ca ON ad_org.ad_org_id = ca.AD_OrgOnly_ID AND ca.C_AcctSchema_ID = p_C_AcctSchema_ID
			WHERE t.treetype = 'OO' AND t.ad_client_id = p_AD_Client_ID AND ((tn.parent_id = 0 AND ad_org.issummary = 'Y') OR (ad_org.ad_org_id = p_AD_Org_ID))
			
			UNION
			
			SELECT tn.node_id
			FROM ad_tree t
			INNER JOIN ad_treenode tn ON t.ad_tree_id = tn.ad_tree_id
			INNER JOIN ad_org ON tn.node_id = ad_org.ad_org_id
			INNER JOIN tr ON tr.ad_org_id = tn.parent_id
			WHERE tn.node_id = p_AD_Org_ID
		)

		SELECT ad_org_id
		INTO v_ad_org_id
		FROM tr
		WHERE ad_org_id = p_ad_org_id;
	END IF;

	RETURN CASE WHEN v_ad_org_id = p_AD_Org_ID THEN 'Y' ELSE 'N' END;
END;
$FUNCTION$;
