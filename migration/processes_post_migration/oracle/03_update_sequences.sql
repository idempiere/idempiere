-- TODO: Currently not inserting new sequences
DECLARE
   cmdsys           VARCHAR2 (1000);
   cmdnosys         VARCHAR2 (1000);
   cmdseq           VARCHAR2 (1000);
   cmdupd           VARCHAR2 (1000);
   currentnextsys   NUMBER (10);
   currentnext      NUMBER (10);
   currentseqsys    NUMBER (10);
   Currentseq       Number (10);
   Isnativeseqon    Varchar2(1);  
   sqlcmd           VARCHAR2(200);
BEGIN
   DBMS_OUTPUT.PUT_LINE ('Start');

   FOR r IN (SELECT   tablename
                 FROM AD_TABLE t
                WHERE EXISTS (
                         SELECT 1
                           FROM AD_COLUMN c
                          WHERE t.ad_table_id = c.ad_table_id
                            AND c.columnname = t.tablename || '_ID')
             ORDER BY 1)
   LOOP
      cmdsys :=
            'SELECT  MAX ('
         || r.tablename
         || '_id) currentnextsys FROM '
         || r.tablename
         || ' where '
         || r.tablename
         || '_id<1000000';

      BEGIN
         EXECUTE IMMEDIATE cmdsys
                      INTO currentnextsys;
      EXCEPTION
         WHEN OTHERS
         THEN
            DBMS_OUTPUT.PUT_LINE ('Table not found');
            DBMS_OUTPUT.PUT_LINE (cmdsys);
            GOTO next_iteration;
      END;
     
      Isnativeseqon := get_Sysconfig('SYSTEM_NATIVE_SEQUENCE','N',0,0);
      IF currentnextsys IS NULL
      THEN
         currentnextsys := 0;
      END IF;

      SELECT DECODE (SIGN (currentnextsys - 200000),
                     -1, 200000,
                     NVL (currentnextsys + 1, 200000)
                    )
        INTO currentnextsys
        FROM DUAL;

      cmdnosys :=
            'SELECT  MAX ('
         || r.tablename
         || '_id) currentnext FROM '
         || r.tablename
         || ' where '
         || r.tablename
         || '_id>=1000000';

      EXECUTE IMMEDIATE cmdnosys
                   INTO currentnext;

      IF currentnext IS NULL
      THEN
         currentnext := 0;
      END IF;

      SELECT DECODE (SIGN (currentnext - 1000000),
                     -1, 1000000,
                     NVL (currentnext + 1, 1000000)
                    )
        INTO currentnext
        FROM DUAL;

      If Isnativeseqon ='Y' Then 
       Cmdseq :=
            'SELECT '||R.Tablename||'_SQ.Nextval as currentnext, 
                     currentnextsys 
              FROM AD_Sequence '
         || 'WHERE Name = '''
         || r.Tablename
         || ''' AND istableid = ''Y''';      
      ELSE   
        cmdseq :=
              'SELECT currentnext, currentnextsys FROM AD_Sequence '
           || 'WHERE Name = '''
           || r.tablename
           || ''' AND istableid = ''Y''';
      END IF;

      EXECUTE IMMEDIATE cmdseq
                   INTO currentseq, currentseqsys;

      IF currentnextsys <> currentseqsys OR (currentnext <> currentseq AND Isnativeseqon ='N')
      THEN
         DBMS_OUTPUT.PUT_LINE (   r.tablename
                               || ' sys='
                               || currentnextsys
                               || ' nosys='
                               || currentnext
                               || ' seqsys='
                               || currentseqsys
                               || ' seqnosys='
                               || currentseq
                              );
         cmdupd :=
               'update ad_sequence set currentnextsys = '
            || currentnextsys
            || ', currentnext='
            || currentnext
            || ' where name='''
            || r.tablename
            || ''' and istableid=''Y''';
         DBMS_OUTPUT.PUT_LINE (cmdupd);

         EXECUTE IMMEDIATE cmdupd;
      End If;
      
      If Currentseq < Currentnext And Isnativeseqon ='Y' Then 
         Sqlcmd := 'SELECT '||R.Tablename||'_SQ.Nextval FROM DUAL'; 
         DBMS_OUTPUT.PUT_LINE (Sqlcmd);
         While Not Currentseq >= (currentnext-1) Loop
           Execute Immediate Sqlcmd
           Into currentseq;
         End Loop;
      END IF;			
      <<next_iteration>>
      NULL;
   END LOOP;

   COMMIT;
   DBMS_OUTPUT.PUT_LINE ('End');
END;
/

