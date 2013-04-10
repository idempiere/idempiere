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
 * Title:	Create or replace directory for data pump
 * Description:	
 *	Parameter: Directory
 *	Run as system
 ************************************************************************/
CREATE OR REPLACE DIRECTORY ADEMPIERE_DATA_PUMP_DIR AS '&1'
/
EXIT
