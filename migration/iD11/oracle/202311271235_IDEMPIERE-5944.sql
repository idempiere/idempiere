-- TESTE
SELECT register_migration_script('202311271235_IDEMPIERE-5944.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 27, 2023, 12:35:35 PM BRT
UPDATE (
    SELECT 
        c.DefaultValue,
        c.isMandatory,
        CASE 
            WHEN c.AD_Element_ID = 348 THEN 'Y'
            ELSE 'N'
        END AS newDefaultValue
    FROM 
        AD_Column c
        LEFT JOIN AD_Table t ON t.AD_Table_ID = c.AD_Table_ID
    WHERE
        c.AD_Reference_ID = '20'
        AND t.IsView = 'N'
        AND c.isMandatory = 'N'
        AND (c.DefaultValue NOT IN ('N', 'Y') OR c.DefaultValue IS NULL)
        AND c.ad_column_id < 1000000
) x
SET x.DefaultValue = x.newDefaultValue,
    x.isMandatory = 'Y';

