DECLARE
   roleaccesslevel      VARCHAR2 (200);
   roleaccesslevelwin   VARCHAR2 (200);
   sqlins               VARCHAR2 (2000);
BEGIN
   FOR r IN (SELECT   ad_role_id, userlevel, NAME, ad_client_id, ad_org_id
                 FROM AD_ROLE
                WHERE ismanual = 'N' AND isactive = 'Y'
             ORDER BY ad_role_id)
   LOOP
      DBMS_OUTPUT.PUT_LINE ('Role : ' || r.NAME || ' - ' || r.ad_role_id);
      IF r.userlevel = 'S  '                                        -- system
      THEN
         roleaccesslevel := '(''4'',''7'',''6'')';
         roleaccesslevelwin := roleaccesslevel;
      ELSIF r.userlevel = ' C '                                      -- client
      THEN
         roleaccesslevel := '(''7'',''6'',''3'',''2'')';
         roleaccesslevelwin := roleaccesslevel;
      ELSIF r.userlevel = ' CO'                                -- client + org
      THEN
         roleaccesslevel := '(''7'',''6'',''3'',''2'',''1'')';
         roleaccesslevelwin := roleaccesslevel;
      ELSE                                                    -- org or others
         roleaccesslevel := '(''3'',''1'',''7'')';
         roleaccesslevelwin :=
                        roleaccesslevel || ' AND w.Name NOT LIKE ''%(all)%''';
      END IF;

      sqlins :=
            'INSERT INTO AD_Window_Access (AD_Window_ID, AD_Role_ID, AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadWrite) SELECT DISTINCT w.AD_Window_ID, '
         || r.ad_role_id
         || ','||r.ad_client_id||','||r.ad_org_id||',''Y'', SysDate,0, SysDate,0,''Y'' FROM AD_Window w INNER JOIN AD_Tab t ON (w.AD_Window_ID=t.AD_Window_ID) INNER JOIN AD_Table tt ON (t.AD_Table_ID=tt.AD_Table_ID) LEFT JOIN AD_Window_Access wa ON (wa.AD_Role_ID='
	 || r.ad_role_id
	 || ' AND w.AD_Window_ID = wa.AD_Window_ID) WHERE wa.AD_Window_ID IS NULL AND t.SeqNo=(SELECT MIN(SeqNo) FROM AD_Tab xt WHERE xt.AD_Window_ID=w.AD_Window_ID) AND tt.AccessLevel IN '
         || roleaccesslevelwin;

      -- DBMS_OUTPUT.PUT_LINE (sqlins);
      EXECUTE IMMEDIATE sqlins;

      sqlins :=
            'INSERT INTO AD_Process_Access (AD_Process_ID, AD_Role_ID, AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadWrite) SELECT DISTINCT p.AD_Process_ID, '
         || r.ad_role_id
         || ','||r.ad_client_id||','||r.ad_org_id||',''Y'', SysDate,0, SysDate,0,''Y'' FROM AD_Process p LEFT JOIN AD_Process_Access pa ON (pa.AD_Role_ID='
	 || r.ad_role_id
	 || ' AND p.AD_Process_ID = pa.AD_Process_ID) WHERE pa.AD_Process_ID IS NULL AND AccessLevel IN '
         || roleaccesslevel;

      -- DBMS_OUTPUT.PUT_LINE (sqlins);
      EXECUTE IMMEDIATE sqlins;

      sqlins :=
            'INSERT INTO AD_Form_Access (AD_Form_ID, AD_Role_ID, AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadWrite) SELECT f.AD_Form_ID, '
         || r.ad_role_id
         || ','||r.ad_client_id||','||r.ad_org_id||',''Y'', SysDate,0, SysDate,0,''Y'' FROM AD_Form f LEFT JOIN AD_Form_Access fa ON (fa.AD_Role_ID='
	 || r.ad_role_id
	 || ' AND f.AD_Form_ID = fa.AD_Form_ID) WHERE fa.AD_Form_ID IS NULL AND AccessLevel IN '
         || roleaccesslevel;

      -- DBMS_OUTPUT.PUT_LINE (sqlins);
      EXECUTE IMMEDIATE sqlins;

      sqlins :=
            'INSERT INTO AD_WorkFlow_Access (AD_WorkFlow_ID, AD_Role_ID, AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadWrite) SELECT w.AD_WorkFlow_ID, '
         || r.ad_role_id
         || ','||r.ad_client_id||','||r.ad_org_id||',''Y'', SysDate,0, SysDate,0,''Y'' FROM AD_WorkFlow w LEFT JOIN AD_WorkFlow_Access wa ON (wa.AD_Role_ID='
	 || r.ad_role_id
	 || ' AND w.AD_WorkFlow_ID = wa.AD_WorkFlow_ID) WHERE w.AD_Client_ID IN (0,'||r.ad_client_id||') AND wa.AD_WorkFlow_ID IS NULL AND AccessLevel IN '
         || roleaccesslevel;

      -- DBMS_OUTPUT.PUT_LINE (sqlins);
      EXECUTE IMMEDIATE sqlins;

      sqlins :=
            'INSERT INTO AD_Document_Action_Access (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_DocType_ID, AD_Ref_List_ID, AD_Role_ID) (SELECT '
	 || r.ad_client_id || ',' || r.ad_org_id 
	 || ',''Y'', SysDate,0, SysDate,0, doctype.C_DocType_ID, action.AD_Ref_List_ID, rol.AD_Role_ID '
         || ' FROM AD_Client client INNER JOIN C_DocType doctype ON (doctype.AD_Client_ID=client.AD_Client_ID) INNER JOIN AD_Ref_List action ON (action.AD_Reference_ID=135) INNER JOIN AD_Role rol ON (rol.AD_Client_ID=client.AD_Client_ID AND rol.AD_Role_ID='
	 || r.ad_role_id
         || ') LEFT JOIN AD_Document_Action_Access da ON (da.AD_Role_ID='
	 || r.ad_role_id
	 || ' AND da.C_DocType_ID=doctype.C_DocType_ID AND da.AD_Ref_List_ID=action.AD_Ref_List_ID) WHERE (da.C_DocType_ID IS NULL AND da.AD_Ref_List_ID IS NULL))';

      -- DBMS_OUTPUT.PUT_LINE (sqlins);
      EXECUTE IMMEDIATE sqlins;

      sqlins :=
            'INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_ID, AD_Role_ID, AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy) SELECT i.AD_InfoWindow_ID, '
         || r.ad_role_id
         || ','||r.ad_client_id||','||r.ad_org_id||',''Y'', SysDate,0, SysDate,0 FROM AD_InfoWindow i LEFT JOIN AD_InfoWindow_Access ia ON (ia.AD_Role_ID='
	 || r.ad_role_id
	 || ' AND i.AD_InfoWindow_ID = ia.AD_InfoWindow_ID) WHERE i.AD_Client_ID IN (0,'||r.ad_client_id||') AND ia.AD_InfoWindow_ID IS NULL';

      -- DBMS_OUTPUT.PUT_LINE (sqlins);
      EXECUTE IMMEDIATE sqlins;

   END LOOP;

   COMMIT;
END;
/

