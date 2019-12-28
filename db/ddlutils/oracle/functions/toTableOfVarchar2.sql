-- IDEMPIERE-3413 Multi Select List and table reference

CREATE TYPE TABLE_OF_VARCHAR2 AS TABLE OF VARCHAR2(4000)
/

CREATE OR REPLACE FUNCTION toTableOfVarchar2(p_list IN VARCHAR2)
      RETURN TABLE_OF_VARCHAR2 DETERMINISTIC
    AS
      l_tab TABLE_OF_VARCHAR2 := TABLE_OF_VARCHAR2();
    BEGIN
      FOR i IN
      ( select trim('"' from REGEXP_SUBSTR(p_list, '(".*?"|.*?)(,|$)', 1, level, NULL, 1)) split
      from dual
      connect by level<=length(regexp_replace(p_list,'".*?"|[^,]*'))+1)
      LOOP
       l_tab.EXTEND;
       l_tab(l_tab.COUNT) := i.split;
     END LOOP;
     RETURN l_tab;
   END toTableOfVarchar2
;
/

