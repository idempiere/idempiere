-- IDEMPIERE-5944
SELECT register_migration_script('202311271235_IDEMPIERE-5944.sql') FROM dual;

-- Nov 27, 2023, 12:35:35 PM BRT
UPDATE AD_Column c
SET DefaultValue = 
    CASE 
        WHEN c.AD_Element_ID = 348 THEN 'Y'
        ELSE 'N'
    END,
    isMandatory = 'Y'
FROM AD_Table t
WHERE
    c.AD_Table_ID = t.AD_Table_ID
    AND c.AD_Reference_ID = '20'
    AND t.IsView = 'N'
    AND c.isMandatory = 'N'
    AND (c.DefaultValue NOT IN ('N', 'Y') OR c.DefaultValue IS NULL)
   	AND c.ad_column_id < 1000000;


