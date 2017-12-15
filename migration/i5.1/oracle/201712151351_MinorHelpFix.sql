SET SQLBLANKLINES ON
SET DEFINE OFF

-- Fix help of form Merge Entities wrongly formatted breaking the wiki manual
-- Dec 15, 2017 1:49:32 PM CET
UPDATE AD_Form SET Help='<i>Dangerous - Please are aware of what you are doing!</i>
All instances of the From entity (e.g. Customer A) are changed to the To entity (e.g. Customer B). 
The From entity (e.g. Customer A) is deleted. 
<p><b>There is NO undo nor trace !  Please do a backup first</b> Please be aware that you may be changing history records (e.g. invoices, etc.) ! </p>
<p><b>Side effects:</b> Merging Products are likely to distort product costs; Merging Business Partners may result in incorrect open item balance. Check with support on remedies.</p>
<p><b>Restrictions:</b> Accounting and Inventory conflicts are not resolved in this version.</p>',Updated=TO_DATE('2017-12-15 13:49:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Form_ID=112
;

SELECT register_migration_script('201712151351_MinorHelpFix.sql') FROM dual
;

