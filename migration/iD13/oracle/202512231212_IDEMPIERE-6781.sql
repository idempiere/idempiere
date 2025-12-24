-- IDEMPIERE-6781 Currency dropdown values not loading in Cost Adjustment screen (Oracle server)
SELECT register_migration_script('202512231212_IDEMPIERE-6781.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 23, 2025, 12:12:04 PM IST
UPDATE AD_Val_Rule SET Code='C_Currency_ID in (SELECT C_Currency_ID FROM C_AcctSchema Where AD_Client_ID = @AD_Client_ID@ AND (IsMemberOfAcctSchema(AD_Client_ID,@AD_Org_ID@,C_AcctSchema_ID)=''Y'' OR AD_OrgOnly_ID Is NULL ))',Updated=TO_DATE('2025-12-23 12:12:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200091
;


DROP FUNCTION ISMEMBEROFACCTSCHEMA
;


CREATE OR REPLACE FUNCTION IsMemberOfAcctSchema (
  p_AD_Client_ID    IN NUMBER,
  p_AD_Org_ID       IN NUMBER,
  p_C_AcctSchema_ID IN NUMBER
)
RETURN CHAR
IS
  v_ad_org_id NUMBER := -1;
  v_count     NUMBER := 0;
BEGIN
  SELECT COUNT(1)
  INTO v_count
  FROM C_AcctSchema c
  WHERE c.C_AcctSchema_ID <> p_C_AcctSchema_ID
    AND c.AD_OrgOnly_ID = p_AD_Org_ID;

  IF v_count = 0 THEN
    BEGIN
      WITH tr (level_no, parent_name, name, ad_org_id) AS (
        SELECT 0,
               NULL,
               ad_org.name,
               tn.node_id
        FROM ad_tree t
        JOIN ad_treenode tn ON t.ad_tree_id = tn.ad_tree_id
        JOIN ad_org ON tn.node_id = ad_org.ad_org_id
        JOIN c_acctschema ca
          ON ad_org.ad_org_id = ca.AD_OrgOnly_ID
         AND ca.C_AcctSchema_ID = p_C_AcctSchema_ID
        WHERE t.treetype = 'OO'
          AND t.ad_client_id = p_AD_Client_ID
          AND ( (tn.parent_id = 0 AND ad_org.issummary = 'Y')
                OR ad_org.ad_org_id = p_AD_Org_ID )

        UNION ALL

        SELECT tr.level_no + 1,
               tr.name,
               ad_org.name,
               tn.node_id
        FROM ad_tree t
        JOIN ad_treenode tn ON t.ad_tree_id = tn.ad_tree_id
        JOIN ad_org ON tn.node_id = ad_org.ad_org_id
        JOIN tr ON tr.ad_org_id = tn.parent_id
        WHERE tn.node_id = p_AD_Org_ID
      )
      SELECT ad_org_id
      INTO v_ad_org_id
      FROM tr
      WHERE ad_org_id = p_AD_Org_ID;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN v_ad_org_id := -1;
      WHEN TOO_MANY_ROWS THEN v_ad_org_id := p_AD_Org_ID;
    END;
  END IF;

  RETURN CASE WHEN v_ad_org_id = p_AD_Org_ID THEN 'Y' ELSE 'N' END;

EXCEPTION WHEN OTHERS THEN RETURN 'N';
END
;
