UPDATE ad_column SET ad_reference_id=30/*Search*/ WHERE ad_column_id=213515 /*AD_PrintHeaderFooter.CreatedBy*/ and ad_reference_id=18/*Table*/
;

UPDATE ad_column SET ad_reference_id=30/*Search*/ WHERE ad_column_id=213519 /*AD_PrintHeaderFooter.UpdatedBy*/ and ad_reference_id=18/*Table*/
;

UPDATE ad_column SET ad_reference_id=30/*Search*/ WHERE ad_column_id=214549 /*AD_SMTP.CreatedBy*/ and ad_reference_id=18/*Table*/
;

UPDATE ad_column SET ad_reference_id=30/*Search*/ WHERE ad_column_id=214553 /*AD_SMTP.UpdatedBy*/ and ad_reference_id=18/*Table*/
;

UPDATE ad_column SET ad_reference_id=30/*Search*/ WHERE ad_column_id=213052 /*AD_Tree_Favorite.CreatedBy*/ and ad_reference_id=18/*Table*/
;

UPDATE ad_column SET ad_reference_id=30/*Search*/ WHERE ad_column_id=213055 /*AD_Tree_Favorite.UpdatedBy*/ and ad_reference_id=18/*Table*/
;

UPDATE ad_column SET ad_reference_id=30/*Search*/ WHERE ad_column_id=213063 /*AD_Tree_Favorite_Node.CreatedBy*/ and ad_reference_id=18/*Table*/
;

UPDATE ad_column SET ad_reference_id=30/*Search*/ WHERE ad_column_id=213066 /*AD_Tree_Favorite_Node.UpdatedBy*/ and ad_reference_id=18/*Table*/
;

SELECT register_migration_script('202112231523_IDEMPIERE-5109_HighVolume.sql') FROM dual
;

