-- IDEMPIERE-6096 Implement regexp VFormat
SELECT register_migration_script('202404081845_IDEMPIERE-6096.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 8, 2024, 6:45:20 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','The entered value does not match the required regular expression: {0}',0,0,'Y',TO_TIMESTAMP('2024-04-08 18:45:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-04-08 18:45:20','YYYY-MM-DD HH24:MI:SS'),100,200886,'InvalidFormatRegExp','D','ba94f2c9-ac3e-4efd-a054-fa0b653e7322')
;

-- Apr 8, 2024, 6:48:11 PM CEST
UPDATE AD_Element SET Description='Format of the value; Can contain fixed format elements, Variables: "_lLoOaAcCa09", or ~regex', Help='<B>Validation elements:</B>

~regex - Validates a regular expression

 	(Space) any character
_	Space (fixed character)
l	any Letter a..Z NO space
L	any Letter a..Z NO space converted to upper case
o	any Letter a..Z or space
O	any Letter a..Z or space converted to upper case
a	any Letters & Digits NO space
A	any Letters & Digits NO space converted to upper case
c	any Letters & Digits or space
C	any Letters & Digits or space converted to upper case
0	Digits 0..9 NO space
9	Digits 0..9 or space

Example of format "(000)_000-0000"',Updated=TO_TIMESTAMP('2024-04-08 18:48:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=616
;

