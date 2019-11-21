-- Fix wrong entity types
-- Nov 21, 2019, 9:28:25 PM CET
UPDATE AD_TableIndex SET entitytype='D' WHERE ad_tableindex_id IN (201075,201076)
;

UPDATE AD_IndexColumn SET entitytype='D' WHERE AD_IndexColumn_ID IN (201390,201391)
;

UPDATE AD_Message SET entitytype='D' WHERE AD_Message_ID IN (200512,200539,200543,200544,200545,200546,200547,200548,200549,200550,200553,200555,200556,200557,200558,200559,200560)
;

SELECT register_migration_script('201911212202_FixEntityTypes.sql') FROM dual
;

