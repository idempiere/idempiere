UPDATE AD_Message SET MsgText='Advanced' WHERE AD_Message_ID=135 /* Advanced */
;

UPDATE AD_Message SET MsgText='Cancel' WHERE AD_Message_ID=166 /* Cancel */
;

UPDATE AD_Message SET MsgText='Cancel Query' WHERE AD_Message_ID=167 /* CancelQuery */
;

UPDATE AD_Message SET MsgText='Copy Record' WHERE AD_Message_ID=188 /* Copy */
;

UPDATE AD_Message SET MsgText='Delete Record' WHERE AD_Message_ID=214 /* Delete */
;

UPDATE AD_Message SET MsgText='Edit' WHERE AD_Message_ID=234 /* Edit */
;

UPDATE AD_Message SET MsgText='Exit Window' WHERE AD_Message_ID=236 /* End */
;

UPDATE AD_Message SET MsgText='Enter Query' WHERE AD_Message_ID=237 /* EnterQuery */
;

UPDATE AD_Message SET MsgText='Expand Tree' WHERE AD_Message_ID=245 /* ExpandTree */
;

UPDATE AD_Message SET MsgText='File' WHERE AD_Message_ID=253 /* File */
;

UPDATE AD_Message SET MsgText='Lookup Record' WHERE AD_Message_ID=270 /* Find */
;

UPDATE AD_Message SET MsgText='Go' WHERE AD_Message_ID=284 /* Go */
;

UPDATE AD_Message SET MsgText='Help' WHERE AD_Message_ID=291 /* Help */
;

UPDATE AD_Message SET MsgText='Home' WHERE AD_Message_ID=293 /* Home */
;

UPDATE AD_Message SET MsgText='Undo Changes' WHERE AD_Message_ID=295 /* Ignore */
;

UPDATE AD_Message SET MsgText='Product Info' WHERE AD_Message_ID=305 /* InfoProduct */
;

UPDATE AD_Message SET MsgText='Menu' WHERE AD_Message_ID=334 /* Menu */
;

UPDATE AD_Message SET MsgText='Grid Toggle' WHERE AD_Message_ID=340 /* Multi */
;

UPDATE AD_Message SET MsgText='Name' WHERE AD_Message_ID=343 /* Name */
;

UPDATE AD_Message SET MsgText='OK' WHERE AD_Message_ID=366 /* OK */
;

UPDATE AD_Message SET MsgText='Print' WHERE AD_Message_ID=425 /* Print */
;

UPDATE AD_Message SET MsgText='ReQuery' WHERE AD_Message_ID=465 /* Refresh */
;

UPDATE AD_Message SET MsgText='Report' WHERE AD_Message_ID=473 /* Report */
;

UPDATE AD_Message SET MsgText='Save Changes' WHERE AD_Message_ID=497 /* Save */
;

UPDATE AD_Message SET MsgText='Tools' WHERE AD_Message_ID=567 /* Tools */
;

UPDATE AD_Message SET MsgText='Key' WHERE AD_Message_ID=592 /* Value */
;

UPDATE AD_Message SET MsgText='View' WHERE AD_Message_ID=599 /* View */
;

UPDATE AD_Message SET MsgText='Enter Query' WHERE AD_Message_ID=602 /* ViewerQuery */
;

UPDATE AD_Message SET MsgText='Warehouse' WHERE AD_Message_ID=612 /* Warehouse */
;

UPDATE AD_Message SET MsgText='Zoom' WHERE AD_Message_ID=618 /* Zoom */
;

UPDATE AD_Message SET MsgText='Active Workflows' WHERE AD_Message_ID=757 /* WorkFlow */
;

UPDATE AD_Message SET MsgText='Zoom Across (where used)' WHERE AD_Message_ID=759 /* ZoomAcross */
;

UPDATE AD_Message SET MsgText='Product' WHERE AD_Message_ID=777 /* Product */
;

UPDATE AD_Message SET MsgText='Business Partner' WHERE AD_Message_ID=778 /* BPartner */
;

UPDATE AD_Message SET MsgText='Check Requests' WHERE AD_Message_ID=821 /* Request */
;

UPDATE AD_Message SET MsgText='Archived Documents/Reports' WHERE AD_Message_ID=822 /* Archive */
;

UPDATE AD_Message SET MsgText='Workflow' WHERE AD_Message_ID=859 /* WorkflowPanel */
;

UPDATE AD_Message SET MsgText='Lookup' WHERE AD_Message_ID=860 /* TreeSearch */
;

UPDATE AD_Message SET MsgText='OK' WHERE AD_Message_ID=863 /* Ok */
;

UPDATE AD_Message SET MsgText='Document No' WHERE AD_Message_ID=864 /* DocumentNo */
;

UPDATE AD_Message SET MsgText='Performance' WHERE AD_Message_ID=866 /* PAPanel */
;

UPDATE AD_Message SET MsgText='Select All' WHERE AD_Message_ID=888 /* SelectAll */
;

SELECT register_migration_script('202010281235_IDEMPIERE-4511.sql') FROM dual
;

