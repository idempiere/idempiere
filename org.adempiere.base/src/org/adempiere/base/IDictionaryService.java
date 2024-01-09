/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * Copyright (C) 2009 ObjectCode GmbH										  *
 * Contributor(s): Joerg Viola www.objectcode.de                              *
 *****************************************************************************/
package org.adempiere.base;

import java.io.File;

import org.compiere.model.X_AD_Package_Imp_Proc;
import org.osgi.framework.BundleContext;

/**
 * Interface for import of Application Dictionary data.
 * 
 * @author Joerg Viola
 */
public interface IDictionaryService {
	/**
	 * Import application dictionary package
	 * @param context
	 * @param packageFile Application Dictionary package
	 * @throws Exception
	 */
	void merge(BundleContext context, File packageFile) throws Exception;
	
	/**
	 * @return X_AD_Package_Imp_Proc
	 */
	default public X_AD_Package_Imp_Proc getAD_Package_Imp_Proc() {
		return null;
	};
}
