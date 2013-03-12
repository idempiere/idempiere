-- Mar 12, 2013 10:55:02 AM COT
-- IDEMPIERE-166 Rebranding of logo and product name 
UPDATE AD_PrintTableFormat SET FunctBG_PrintColor_ID=115, HdrLine_PrintColor_ID=NULL, Line_PrintColor_ID=NULL, FunctFG_PrintColor_ID=100, IsPaintHLines='N', IsPaintVLines='N', HdrTextBG_PrintColor_ID=115, Hdr_PrintFont_ID=161, LineStrokeType='S', LineStroke=0.5, HdrTextFG_PrintColor_ID=100, HdrStroke=1, Funct_PrintFont_ID=155,Updated=TO_TIMESTAMP('2013-03-12 10:55:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintTableFormat_ID=100
;

SELECT register_migration_script('201303121104_IDEMPIERE-166.sql') FROM dual
;

