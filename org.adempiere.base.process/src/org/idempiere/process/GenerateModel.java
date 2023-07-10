/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - Nicolas Micoud (TGI)                                              *
 **********************************************************************/
package org.idempiere.process;

import org.adempiere.util.ModelClassGenerator;
import org.adempiere.util.ModelInterfaceGenerator;
import org.compiere.model.MProcessPara;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.Util;

/**
 *	IDEMPIERE-5796 - Generate Model Template
 * 	@author 	Nicolas Micoud - TGI
 */
@org.adempiere.base.annotation.Process
public class GenerateModel extends SvrProcess {

	private int p_generateModelTemplate_ID = 0;
	private String	p_sourceFolder = "";
	private String	p_packageName = "";
	private String	p_tableName = "";
	private String	p_tableEntityType = "";
	private String	p_columnEntityType = "";

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			switch (name) {
			case "AD_ModelGeneratorTemplate_ID":
				p_generateModelTemplate_ID = para.getParameterAsInt();
				break;
			case "Folder":
				p_sourceFolder = para.getParameterAsString();
				break;
			case "PackageName":
				p_packageName = para.getParameterAsString();
				break;
			case "TableName":
				p_tableName = para.getParameterAsString();
				break;
			case "TableEntityType":
				p_tableEntityType = para.getParameterAsString();
				break;
			case "ColumnEntityType":
				p_columnEntityType = para.getParameterAsString();
				break;

			default:
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para);
			}
		}
	}	//	prepare

	/**
	 *  Perform process.
	 *  @return Message
	 *  @throws Exception
	 */
	protected String doIt() {

		ModelInterfaceGenerator.generateSource(p_sourceFolder, p_packageName, p_tableEntityType, p_tableName, p_columnEntityType);
		ModelClassGenerator.generateSource(p_sourceFolder, p_packageName, p_tableEntityType, p_tableName, p_columnEntityType);

		return "@ProcessOK@";
	}

}	//	GenerateModel
