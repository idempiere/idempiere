-- IDEMPIERE-2064 Show all DocAction button in trx windows in toolbar and window
update ad_column set istoolbarbutton='B' where ad_column_id in (
1789,
2171,
3495,
4324,
5497,
10797,
11480,
12076,
12120,
12282,
12319,
12330,
12412,
12449,
12461,
59447,
59452,
59480,
210983)
;

SELECT register_migration_script('201602191721_IDEMPIERE-2064.sql') FROM dual
;

