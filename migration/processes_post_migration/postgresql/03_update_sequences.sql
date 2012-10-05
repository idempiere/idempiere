CREATE OR REPLACE FUNCTION update_sequences() RETURNS void as $func$
-- TODO: Currently not inserting new sequences
DECLARE
   cmdsys           VARCHAR (1000);
   cmdnosys         VARCHAR (1000);
   cmdseq           VARCHAR (1000);
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

      BEGIN
	 SELECT Value
	   INTO isnativeseqon		
	   FROM AD_SYSCONFIG 
	  WHERE Name ='SYSTEM_NATIVE_SEQUENCE';
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            isnativeseqon:= 'N';
      END;
          
      IF currentnextsys IS NULL
      THEN
         currentnextsys := 0;
      END IF;

      SELECT INTO currentnextsys CASE SIGN (currentnextsys - 50000)
                     WHEN -1 THEN 50000
                     ELSE coalesce (currentnextsys + 1, 50000)
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
      ELSE 
       cmdseq :=
 	    'SELECT currentnext, currentnextsys FROM AD_Sequence '
 	 || 'WHERE Name = '''
	 || r.tablename
	 || ''' AND istableid = ''Y''';
      END IF;  

      EXECUTE cmdseq INTO currentseq, currentseqsys;

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
	 --RAISE NOTICE 'currentseq % ,currentnext %',currentseq,currentnext;
         WHILE NOT currentseq >= (currentnext-1) LOOP
           EXECUTE 'SELECT nextval('''||trim(r.tablename)||'_sq'''||')' INTO currentseq;
         --RAISE NOTICE 'currentseq % ,currentnext %',currentseq,currentnext;
         END LOOP;
      END IF;			
    END IF;
   END LOOP;
END;
$func$ LANGUAGE plpgsql;

select update_sequences();

commit;
