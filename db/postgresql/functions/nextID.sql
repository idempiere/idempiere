CREATE OR REPLACE FUNCTION nextid(
	p_AD_Sequence_ID 	IN 	INTEGER, 
	p_System 		IN 	VARCHAR,
	o_NextID		OUT	INTEGER
)
  RETURNS INTEGER AS $body$
/*************************************************************************
 * The contents of this file are subject to the Compiere License.  You may
 * obtain a copy of the License at    http://www.compiere.org/license.html
 * Software is on an  "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either
 * express or implied. See the License for details. Code: Compiere ERP+CRM
 * Copyright (C) 1999-2005 Jorg Janke, ComPiere, Inc. All Rights Reserved.
 *
 * converted to postgreSQL by Karsten Thiemann (Schaeffer AG), 
 * kthiemann@adempiere.org
 *************************************************************************
 ***
 * Title:	Get Next ID - no Commit
 * Description: Returns the next id of the sequence.
 * Test:
 *	select * from nextid((select ad_sequence_id from ad_sequence where name = 'Test')::Integer, 'Y'::Varchar);
 * 
 ************************************************************************/
DECLARE
Isnativeseqon VARCHAR(1);
tablename     VARCHAR(60);
BEGIN
    IF (p_System = 'Y') THEN
	RAISE NOTICE 'system';
        SELECT CurrentNextSys
            INTO o_NextID
        FROM AD_Sequence
        WHERE AD_Sequence_ID=p_AD_Sequence_ID;
        --
        UPDATE AD_Sequence
          SET CurrentNextSys = CurrentNextSys + IncrementNo
        WHERE AD_Sequence_ID=p_AD_Sequence_ID;
    ELSE
    
        Isnativeseqon := get_Sysconfig('SYSTEM_NATIVE_SEQUENCE','N',0,0);
        IF Isnativeseqon = 'Y' THEN 
          SELECT Name
            INTO tablename 
            FROM Ad_Sequence
           WHERE Ad_Sequence_Id=P_Ad_Sequence_Id;
	   --
	   EXECUTE 'SELECT nextval('''||tablename||'_sq'''||')' INTO o_NextID;
	   --
       ELSE   
          SELECT CurrentNext
            INTO o_NextID
            FROM AD_Sequence
           WHERE AD_Sequence_ID=p_AD_Sequence_ID;
          --
          UPDATE AD_Sequence
             SET CurrentNext = CurrentNext + IncrementNo
           WHERE AD_Sequence_ID=p_AD_Sequence_ID;
       END IF; 
    END IF;
    --
EXCEPTION
    WHEN  OTHERS THEN
    	RAISE NOTICE '%',SQLERRM;
END;

$body$ LANGUAGE plpgsql;

