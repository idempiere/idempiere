/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2012 Trek Global                							  *
 * Copyright (C) 2012 Carlos Ruiz                							  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.base;

import java.io.File;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.util.List;

import org.compiere.model.GridTab;

/**
 *
 * @author Carlos Ruiz
 *
 */
public interface IGridTabImporter {

	/**
	 * export gridTab data to file
	 * @param gridTab
	 * @param childs
	 * @param filestream
	 * @param charset
	 */
	public File fileImport(GridTab gridTab, List<GridTab> childs, InputStream filestream, Charset charset, String importMode);

	/**
	 * @return file extension
	 */
	public String getFileExtension();

	/**
	 * @return description for file extension
	 */
	public String getFileExtensionLabel();

	/**
	 * @return mime type
	 */
	public String getContentType();

	/**
	 * @return suggested file name
	 */
	public String getSuggestedFileName(GridTab gridTab);
}
