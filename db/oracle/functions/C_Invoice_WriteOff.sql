CREATE OR REPLACE FUNCTION invoiceWriteOff
(
    p_C_Invoice_ID IN NUMBER
)
RETURN NUMBER
AS
    v_Amount NUMBER;
    v_ClientId C_Invoice.AD_Client_ID%TYPE;
    custom_function AD_SysConfig.Value%TYPE;
    command VARCHAR2(1000);
BEGIN
    SELECT AD_Client_ID INTO v_ClientId FROM C_Invoice WHERE C_Invoice_ID=p_C_Invoice_ID;
    custom_function := get_Sysconfig('PAYSELECTION_CUSTOM_INVOICEWRITEOFF_FUNCTION', '', v_ClientId, 0);
    IF LENGTH(custom_function) > 0
    THEN
	command := 'SELECT '||custom_function||'('||p_C_Invoice_ID||') FROM DUAL';
        EXECUTE IMMEDIATE command INTO v_Amount;
    ELSE
        v_Amount := 0;
    END IF;
    RETURN v_Amount;
END invoiceWriteOff;
/
