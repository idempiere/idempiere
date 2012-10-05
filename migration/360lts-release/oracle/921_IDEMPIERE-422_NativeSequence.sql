CREATE OR REPLACE PROCEDURE nextID
(
    p_AD_Sequence_ID    	IN  NUMBER,
    p_System                    IN  CHAR,
    o_NextID                    OUT NUMBER
)
/*************************************************************************
 * The contents of this file are subject to the Adempiere License.  You may
 * obtain a copy of the License at    http://www.adempiere.org/license.html
 * Software is on an  "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either
 * express or implied. See the License for details. Code: Adempiere ERP+CRM
 * Copyright (C) 1999-2005 Jorg Janke, ComPiere, Inc. All Rights Reserved.
 *************************************************************************
 * $Id: nextID.sql,v 1.1 2006/04/21 17:51:58 jjanke Exp $
 ***
 * Title:	Get Next ID - no Commit
 * Description:
 *          Test via
DECLARE
    v_NextID       NUMBER;
BEGIN
    nextID(2, 'Y', v_NextID);
	DBMS_OUTPUT.PUT_LINE(v_NextID);
END;
 * 
 ************************************************************************/
As
Isnativeseqon   NVARCHAR2(1); 
Tablename       Nvarchar2(60);
sqlcmd          VARCHAR2(200);
BEGIN


    IF (p_System = 'Y') THEN
        SELECT CurrentNextSys
        INTO o_NextID
        FROM AD_Sequence
        WHERE AD_Sequence_ID=p_AD_Sequence_ID
        FOR UPDATE OF CurrentNextSys;
        --
        UPDATE AD_Sequence
          SET CurrentNextSys = CurrentNextSys + IncrementNo
        WHERE AD_Sequence_ID=p_AD_Sequence_ID;
    ELSE 
     
        BEGIN
          SELECT Value
            Into Isnativeseqon		
            From Ad_Sysconfig 
           Where Name ='SYSTEM_NATIVE_SEQUENCE';
        EXCEPTION
           WHEN NO_DATA_FOUND THEN
              Isnativeseqon:= 'N';
        END; 
      
       IF Isnativeseqon = 'Y' THEN 
       
          Select Name 
            INTO tablename
            From Ad_Sequence
           Where Ad_Sequence_Id=P_Ad_Sequence_Id
             And Istableid = 'Y';
          --
          Sqlcmd := 'SELECT '||Tablename||'_SQ.Nextval FROM DUAL'; 
          --      
          Execute Immediate Sqlcmd Into O_Nextid;       
          --
       ELSE 
       
         SELECT CurrentNext
          INTO o_NextID
          FROM AD_Sequence
          WHERE AD_Sequence_ID=p_AD_Sequence_ID
          FOR UPDATE OF CurrentNext;
          --
          Update Ad_Sequence
             Set Currentnext = Currentnext + Incrementno
           Where Ad_Sequence_Id=P_Ad_Sequence_Id;
           --
       END IF;
    END IF;
    --
EXCEPTION
    WHEN  OTHERS THEN
    	DBMS_OUTPUT.PUT_LINE(SQLERRM);
END nextID;
/
SELECT register_migration_script('921_IDEMPIERE-422_NativeSequence.sql') FROM dual;

