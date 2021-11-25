/******************************************************************************
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
package org.compiere.process;

import java.util.logging.Level;

import org.compiere.model.MField;
import org.compiere.model.MTab;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.DB;


/**
 *	Copy Tab Fields
 *	
 *  @author Jorg Janke
 *  @version $Id: TabCopy.java,v 1.3 2006/07/30 00:51:02 jjanke Exp $
 */
@org.adempiere.base.annotation.Process
public class TabCopy extends SvrProcess
{
	/**	Tab	To					*/
	private int			p_AD_TabTo_ID = 0;
	/**	Tab	From				*/
	private int			p_AD_TabFrom_ID = 0;

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("AD_Tab_ID"))
				p_AD_TabFrom_ID = para[i].getParameterAsInt();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		p_AD_TabTo_ID = getRecord_ID();
	}	//	prepare

	/**
	 * 	Process
	 *	@return message
	 *	@throws Exception
	 */
	protected String doIt() throws Exception
	{
		final String sqluptrltab = ""
				+ "UPDATE ad_tab_trl "
				+ "SET    name = (SELECT name "
				+ "               FROM   ad_tab_trl t2 "
				+ "               WHERE  t2.ad_tab_id = ? AND t2.ad_language = ad_tab_trl.ad_language), "
				+ "       description = (SELECT description "
				+ "                      FROM   ad_tab_trl t2 "
				+ "                      WHERE  t2.ad_tab_id = ? AND t2.ad_language = ad_tab_trl.ad_language), "
				+ "       help = (SELECT help "
				+ "               FROM   ad_tab_trl t2 "
				+ "               WHERE  t2.ad_tab_id = ? AND t2.ad_language = ad_tab_trl.ad_language), "
				+ "       commitwarning = (SELECT commitwarning "
				+ "                        FROM   ad_tab_trl t2 "
				+ "                        WHERE  t2.ad_tab_id = ? AND t2.ad_language = ad_tab_trl.ad_language), "
				+ "       istranslated = (SELECT istranslated "
				+ "                       FROM   ad_tab_trl t2 "
				+ "                       WHERE  t2.ad_tab_id = ? AND t2.ad_language = ad_tab_trl.ad_language) "
				+ "WHERE  ad_tab_id = ?";
		final String sqluptrlfld = ""
				+ "UPDATE ad_field_trl "
				+ "SET    name = (SELECT name "
				+ "               FROM   ad_field_trl t2 "
				+ "               WHERE  t2.ad_field_id = ? AND t2.ad_language = ad_field_trl.ad_language), "
				+ "       description = (SELECT description "
				+ "                      FROM   ad_field_trl t2 "
				+ "                      WHERE  t2.ad_field_id = ? AND t2.ad_language = ad_field_trl.ad_language), "
				+ "       help = (SELECT help "
				+ "               FROM   ad_field_trl t2 "
				+ "               WHERE  t2.ad_field_id = ? AND t2.ad_language = ad_field_trl.ad_language), "
				+ "       istranslated = (SELECT istranslated "
				+ "                       FROM   ad_field_trl t2 "
				+ "                       WHERE  t2.ad_field_id = ? AND t2.ad_language = ad_field_trl.ad_language) "
				+ "WHERE  ad_field_id = ?";		

		if (log.isLoggable(Level.INFO)) log.info("To AD_Tab_ID=" + p_AD_TabTo_ID + ", From=" + p_AD_TabFrom_ID);
		MTab from = new MTab (getCtx(), p_AD_TabFrom_ID, get_TrxName());
		if (from.get_ID() == 0)
			throw new AdempiereUserError("@NotFound@ (from->) @AD_Tab_ID@");
		MTab to = new MTab (getCtx(), p_AD_TabTo_ID, get_TrxName());
		if (to.get_ID() == 0)
			throw new AdempiereUserError("@NotFound@ (to<-) @AD_Tab_ID@");
		if (from.getAD_Table_ID() != to.getAD_Table_ID())
			throw new AdempiereUserError("@Error@ @AD_Table_ID@");
		DB.executeUpdateEx(sqluptrltab, new Object[]{from.get_ID(),from.get_ID(),from.get_ID(),from.get_ID(),from.get_ID(),to.get_ID()}, get_TrxName());
		
		int count = 0;
		for (MField oldField : from.getFields(false, get_TrxName()))
		{
			MField newField = new MField (to, oldField);
			if (! oldField.isActive())
				newField.setIsActive(false);
			if (newField.save()) {
				DB.executeUpdateEx(sqluptrlfld, new Object[]{oldField.get_ID(),oldField.get_ID(),oldField.get_ID(),oldField.get_ID(),newField.get_ID()}, get_TrxName());
				count++;
			} else {
				throw new AdempiereUserError("@Error@ @AD_Field_ID@");
			}
		}
		StringBuilder msgreturn = new StringBuilder("@Copied@ #").append(count);
		return msgreturn.toString();
	}	//	doIt

}	//	TabCopy
