/******************************************************************************
 * Project: Trek Global ERP                                                   *                       
 * Copyright (C) 2009-2018 Trek Global Corporation                            *
 *                                                                            *
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
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
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.idempiere.print;

import java.awt.Rectangle;

import org.compiere.model.MQuery;
import org.compiere.print.MPrintFormat;
import org.compiere.print.layout.HeaderFooter;

/**
 * Print header/footer interface
 * @author Elaine
 *
 */
public interface IPrintHeaderFooter {
	/***
	 * 
	 * @param m_format
	 * @param m_headerFooter
	 * @param m_header
	 * @param m_footer
	 * @param m_query
	 */
	public void createHeaderFooter(MPrintFormat m_format, HeaderFooter m_headerFooter, Rectangle m_header, Rectangle m_footer, MQuery m_query);
	
	/**
	 * 
	 * @return header height
	 */
	public int getHeaderHeight();
	
	/**
	 * 
	 * @return footer height
	 */
	public int getFooterHeight();
}
