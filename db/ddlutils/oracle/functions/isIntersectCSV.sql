CREATE or REPLACE FUNCTION isIntersectCSV( p_csv1 IN VARCHAR2 , p_csv2 IN VARCHAR2) 
RETURN boolean AS 
BEGIN
   return toTableOfVarchar2(p_csv1) MULTISET INTERSECT toTableOfVarchar2(p_csv2) IS NOT EMPTY;
END;
/

