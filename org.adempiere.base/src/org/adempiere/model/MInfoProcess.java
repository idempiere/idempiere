/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
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

package org.adempiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.model.X_AD_InfoProcess;

/**
 * Contain info of process in info window
 * include process_id, image name, name
 * @author hieplq
 *
 */
public class MInfoProcess extends X_AD_InfoProcess {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4978433930748011554L;

	/**
	 * {@inheritDoc}
	 * @param ctx
	 * @param AD_InfoProcess_ID
	 * @param trxName
	 */
	public MInfoProcess(Properties ctx, int AD_InfoProcess_ID, String trxName) {
		super(ctx, AD_InfoProcess_ID, trxName);

	}

	/**
	 * {@inheritDoc}
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MInfoProcess(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);

	}
	
}
