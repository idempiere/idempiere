/******************************************************************************
 * Copyright (C) 2013 Elaine Tan                                              *
 * Copyright (C) 2013 Trek Global
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
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.adempiere.model.IAddressValidation;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * Address transaction model
 * @author Elaine
 *
 */
public class MAddressTransaction extends X_C_AddressTransaction 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 8572809249265680649L;

	public MAddressTransaction(Properties ctx, int C_AddressTransaction_ID, String trxName) 
	{
		super(ctx, C_AddressTransaction_ID, trxName);
	}
	
	public MAddressTransaction(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
	
	/** Error Message						*/
	private String				m_errorMessage = null;
	
	/**
	 * Set error message
	 * @param errorMessage
	 */
	public void setErrorMessage(String errorMessage)
	{
		m_errorMessage = errorMessage;
	}
	
	/**
	 * Get error message
	 * @return error message
	 */
	public String getErrorMessage()
	{
		return m_errorMessage;
	}
	
	/**
	 * Get address validation
	 * @return address validation
	 */
	public MAddressValidation getMAddressValidation()
	{
		return new MAddressValidation(getCtx(), getC_AddressValidation_ID(), get_TrxName());
	}
	
	/**
	 * Online process address validation
	 * @return true if valid
	 */
	public boolean processOnline()
	{
		setErrorMessage(null);

		boolean processed = false;
		try
		{
			IAddressValidation validation = Core.getAddressValidation(getMAddressValidation());
			if (validation == null)
				setErrorMessage(Msg.getMsg(Env.getCtx(), "AddressNoValidation"));
			else
			{
				processed = validation.onlineValidate(getCtx(), this, get_TrxName());				
				if (!processed || !isValid())
					setErrorMessage("From " + getMAddressValidation().getName() + ": " + getResult());
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "processOnline", e);
			setErrorMessage(Msg.getMsg(Env.getCtx(), "AddressNotProcessed") + ":\n" + e.getMessage());
		}
		
		MOnlineTrxHistory history = new MOnlineTrxHistory(getCtx(), 0, get_TrxName());
		history.setAD_Table_ID(MAddressTransaction.Table_ID);
		history.setRecord_ID(getC_AddressTransaction_ID());
		history.setIsError(!(processed && isValid()));
		history.setProcessed(processed);
		
		StringBuilder msg = new StringBuilder();
		if (processed)
			msg.append(getResult());
		else
			msg.append("ERROR: " + getErrorMessage());
		history.setTextMsg(msg.toString());
		
		history.saveEx();
		
		setProcessed(processed);
		return processed;
	}
}