-- IDEMPIERE-7074 Pin the Business Partner columns that may consume the info selection to the complex info window
SELECT register_migration_script('202609020910_IDEMPIERE-7074.sql') FROM dual;

-- Sep 2, 2026, 9:10:00 AM
-- IDEMPIERE-7074
-- The simplified window is the table default of C_BPartner (see 202609020900_IDEMPIERE-7074.sql), so every
-- Business Partner column without an explicit window shows one row per partner. A lookup always writes the
-- key of the selected record, the other columns of the selected row are only published in the TAB_INFO
-- context (InfoWindow.saveSelectionDetail) and have to be read by a callout. The complex window with the
-- contact and the location is kept on every column whose code this migration can not review, that is
--   every column that is not part of the core dictionary. The AD_Client_ID is 0 for the whole application
--     dictionary, so a column of a module or of a window created by the customer is recognized by its
--     entity type, and the code behind such a column is not delivered with the dictionary - a callout
--     annotation, a model conversion or a script can read the selection without a trace in AD_Column.
--   every column with a callout that is not one of the core callouts verified not to read the selection:
--     org.compiere.model.CalloutInOut.bpartner derives the contact and the location from the partner itself
--     and org.compiere.model.CalloutGLJournal.account does not touch them. The columns that do read the
--     selection are pinned by this condition, they are the ones with CalloutOrder.bPartner
--     (C_Order.C_BPartner_ID), CalloutOrder.bPartnerBill (C_Order.Bill_BPartner_ID),
--     CalloutInvoice.bPartner (C_Invoice.C_BPartner_ID) and CalloutInvoiceBatch.bPartner
--     (C_InvoiceBatchLine.C_BPartner_ID). DD_Order has the callout of M_InOut but an entity type of its own,
--     so the first condition pins it.
-- Every other core column stays at NULL and follows the table default: the partner that is written does not
-- change, only the list becomes shorter, and the contact or the location is still chosen in its own field -
-- that field is normally restricted to the partner by a validation rule, for example "AD_User BPartner" on
-- R_Request.AD_User_ID. An installation that prefers the previous list can pin the column or the single
-- field in the application dictionary, see 202609020930_IDEMPIERE-7074.sql.
-- The references are resolved through AD_Ref_Table, the columns without AD_Reference_Value_ID take the
-- lookup table from the column name and are covered by name. The "AD_InfoWindow_ID IS NULL" condition
-- protects an explicit configuration and leaves columns created after this script at the table default.
-- What this script can not know is the code that is not in the dictionary: a callout annotation is bound to
-- the table and the column in the code (org.adempiere.base.annotation.Callout) and never reaches AD_Column,
-- so an annotation on a CORE Business Partner column is not pinned here, and neither is a callout that is
-- set after this script has run. An installation that adds such code pins the column or the field itself.
UPDATE AD_Column SET AD_InfoWindow_ID = 200001
WHERE AD_InfoWindow_ID IS NULL
  AND ( ColumnName IN ('C_BPartner_ID','Bill_BPartner_ID')
     OR EXISTS (SELECT 1 FROM AD_Ref_Table rt
                JOIN AD_Table t ON t.AD_Table_ID = rt.AD_Table_ID
                WHERE rt.AD_Reference_ID = AD_Column.AD_Reference_Value_ID
                  AND t.TableName = 'C_BPartner') )
  AND ( EntityType <> 'D'
     OR COALESCE(Callout,'') NOT IN ('','org.compiere.model.CalloutInOut.bpartner',
                                     'org.compiere.model.CalloutGLJournal.account') )
;
