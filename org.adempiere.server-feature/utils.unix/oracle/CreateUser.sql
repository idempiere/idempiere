SET ECHO ON
/*************************************************************************
 * The contents of this file are subject to the Adempiere License.  You may
 * obtain a copy of the License at    http://www.adempiere.org/license.html 
 * Software is on an  "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either 
 * express or implied. See the License for details. Code: Adempiere ERP+CRM
 * Copyright (C) 1999-2001 Jorg Janke, ComPiere, Inc. All Rights Reserved.
 *************************************************************************
 * $Id: CreateUser.sql,v 1.1 2006/04/21 17:51:58 jjanke Exp $
 ***
 * Title:	Drop User and re-create new
 * Description:	
 *	Parameter: UserID UserPwd
 *	Run as system
 ************************************************************************/
DROP USER &1 CASCADE
/
CREATE USER &1 IDENTIFIED BY &2
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP
    PROFILE DEFAULT
    ACCOUNT UNLOCK
/
DECLARE
    v_version VARCHAR2(50);
BEGIN
    SELECT version INTO v_version FROM v$instance;
    
    IF v_version>='23.0.0.0.0' THEN
        EXECUTE IMMEDIATE 'GRANT DB_DEVELOPER_ROLE TO &1';
    ELSE
        EXECUTE IMMEDIATE 'GRANT CONNECT TO &1';
        EXECUTE IMMEDIATE 'GRANT DBA TO &1';
        EXECUTE IMMEDIATE 'GRANT RESOURCE TO &1';
        EXECUTE IMMEDIATE 'ALTER USER &1 DEFAULT ROLE CONNECT, RESOURCE, DBA';
        EXECUTE IMMEDIATE 'GRANT CREATE TABLE TO &1';
    END IF;
END;
/
GRANT UNLIMITED TABLESPACE TO &1
/
EXIT
