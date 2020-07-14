INSERT INTO ad_val_rule(ad_val_rule_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, name, description, type, code, entitytype, ad_val_rule_uu) 
VALUES(200089, 0, 0, 'Y', '2020-07-13 20:43:31', 0, '2020-07-13 20:43:31', 0, 'AD_Reference List or Table (Attribute)', 'List or Table validation choices', 'S',
'(
    (@AD_Reference_ID@ IN (17, 200161)  
    AND AD_Reference.ValidationType= ''L'')  
    OR (@AD_Reference_ID@ IN (18,30,200162, 200163) 
        AND AD_Reference.ValidationType=''T'' 
        AND AD_Reference.AD_Reference_ID 
        IN ( select r.ad_reference_id 
            from ad_column c
            join ad_ref_table rt on rt.ad_key = c.ad_column_id
            join ad_reference r on r.ad_reference_id = rt.ad_reference_id
            join ad_table t on t.ad_table_id = rt.ad_table_id  
            where lower(c.columnname) = lower(t.tablename) || ''_id'' 
        )
    )
)', 'D', '2258689f-d448-42ee-90f7-182a8e0e5578')
;

UPDATE ad_val_rule
SET code = 'AD_Reference_ID NOT IN (19,21,23,28,35,53370) AND EntityType = ''D''',
updated = '2020-07-13 20:43:31',
updatedby = 0
WHERE ad_val_rule_id = 200090
;

UPDATE ad_field
SET displaylogic = '@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 & @AttributeValueType@=''R''',
updated = '2020-07-13 20:43:31',
updatedby = 0
WHERE ad_field_id = 204144
;

UPDATE ad_column
SET ad_val_rule_id = 200089,
updated = '2020-07-13 20:43:31',
updatedby = 0
WHERE ad_column_id = 212644
;

SELECT register_migration_script('202007132043_IDEMPIERE-2999.sql') FROM dual
;