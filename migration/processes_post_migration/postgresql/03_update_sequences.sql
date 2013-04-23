-- TODO: Currently not inserting new sequences
CREATE OR REPLACE FUNCTION update_sequences() RETURNS void as $func$
DECLARE
   cmdsys           VARCHAR (1000);
   cmdnosys         VARCHAR (1000);
   cmdseq           VARCHAR (1000);
   cmdcrseq         VARCHAR (1000);
   cmdupd           VARCHAR (1000);
   currentnextsys   NUMERIC (10);
   currentnext      NUMERIC (10);
   currentseqsys    NUMERIC (10);
   currentseq       NUMERIC (10);
   ok               BOOLEAN;
   r                RECORD;
   isnativeseqon    VARCHAR (1);  
BEGIN

 FOR r IN (SELECT tablename
             FROM AD_TABLE t
                WHERE EXISTS (
                         SELECT 1
                           FROM AD_COLUMN c
                          WHERE t.ad_table_id = c.ad_table_id
                            AND c.columnname = t.tablename || '_ID')
                AND IsView= 'N'
             ORDER BY 1)
   LOOP
      cmdsys :=
            'SELECT  MAX ('
         || r.tablename
         || '_id) as currentnextsys FROM '
         || r.tablename
         || ' where '
         || r.tablename
         || '_id<1000000';

      ok := true;
      BEGIN
         EXECUTE cmdsys INTO currentnextsys;
      EXCEPTION
         WHEN OTHERS
         THEN
            ok := false;
      END;

    IF ok THEN
      isnativeseqon := get_Sysconfig('SYSTEM_NATIVE_SEQUENCE','N',0,0);
      IF currentnextsys IS NULL
      THEN
         currentnextsys := 0;
      END IF;

      SELECT INTO currentnextsys CASE SIGN (currentnextsys - 200000)
                     WHEN -1 THEN 200000
                     ELSE coalesce (currentnextsys + 1, 200000)
                     END;

      cmdnosys :=
            'SELECT  MAX ('
         || r.tablename
         || '_id) as currentnext FROM '
         || r.tablename
         || ' where '
         || r.tablename
         || '_id>=1000000';

      EXECUTE cmdnosys INTO currentnext;

      IF currentnext IS NULL
      THEN
         currentnext := 0;
      END IF;

      SELECT INTO currentnext CASE SIGN (currentnext - 1000000)
                     WHEN -1 THEN 1000000
                     ELSE coalesce (currentnext + 1, 1000000)
                     END ;

      IF isnativeseqon ='Y' THEN 
       cmdseq :=
 	    'SELECT nextval('''||trim(r.tablename)||'_sq'''||') as currentnext, 
		    currentnextsys 
	       FROM AD_Sequence '
 	 || 'WHERE Name = '''
	 || r.tablename
	 || ''' AND istableid = ''Y''';
	   BEGIN
        EXECUTE cmdseq INTO currentseq, currentseqsys;
       EXCEPTION
        WHEN undefined_table THEN
          cmdcrseq := 'CREATE SEQUENCE '||trim(r.tablename)||'_SQ INCREMENT 1 MINVALUE 1000000 MAXVALUE 2147483647 START '||currentseq;
	      EXECUTE cmdcrseq;
          EXECUTE cmdseq INTO currentseq, currentseqsys;
       END;
      ELSE 
       cmdseq :=
 	    'SELECT currentnext, currentnextsys FROM AD_Sequence '
 	 || 'WHERE Name = '''
	 || r.tablename
	 || ''' AND istableid = ''Y''';
       EXECUTE cmdseq INTO currentseq, currentseqsys;
      END IF;  

      IF currentnextsys <> currentseqsys OR (currentnext <> currentseq AND isnativeseqon ='N')
      THEN
         cmdupd :=
               'update ad_sequence set currentnextsys = '
            || currentnextsys
            || ', currentnext='
            || currentnext
            || ' where name='''
            || r.tablename
            || ''' and istableid=''Y''';

         EXECUTE cmdupd;
      END IF;
      IF currentseq < currentnext AND isnativeseqon ='Y' THEN 
         WHILE NOT currentseq >= (currentnext-1) LOOP
           EXECUTE 'SELECT nextval('''||trim(r.tablename)||'_sq'''||')' INTO currentseq;
         END LOOP;
      END IF;			
    END IF;
   END LOOP;
END;
$func$ LANGUAGE plpgsql;

select update_sequences();

commit;
